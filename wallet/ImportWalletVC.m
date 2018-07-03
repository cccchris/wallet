//
//  ImportWalletVC.m
//  wallet
//
//  Created by yanghuan on 2018/6/14.
//  Copyright © 2018年 wyChirs. All rights reserved.
//

#import "ImportWalletVC.h"
#import "MainTabBarController.h"
#import "AppDelegate.h"


@interface ImportWalletVC ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIView *mnemonicsView;
@property(nonatomic,strong)UIView *keyStoreView;
@property(nonatomic,strong)UIView *privateKeyView;

@property (weak, nonatomic) IBOutlet UIButton *mnemonicsBtn;
@property (weak, nonatomic) IBOutlet UIButton *keyStoreBtn;
@property (weak, nonatomic) IBOutlet UIButton *privateBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation ImportWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.edgesForExtendedLayout =UIRectEdgeNone;
	self.automaticallyAdjustsScrollViewInsets = NO;
	
	self.navigationItem.title = @"导入钱包";
	
	self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, SCREEN_HEIGHT-50-64);
	self.scrollView.pagingEnabled = YES;
	self.scrollView.delegate = self;
	self.scrollView.contentOffset = CGPointMake(0, 0);
	
	_mnemonicsBtn.selected = YES;
	
	[self addMnemonicsView];
	[self addkeyStoreView];
	[self addPrivateKeyView];
}

- (IBAction)action1:(id)sender {
	_mnemonicsBtn.selected = YES;
	_keyStoreBtn.selected = NO;
	_privateBtn.selected = NO;
	
	self.scrollView.contentOffset = CGPointMake(0, 0);
}
- (IBAction)action2:(id)sender {
	_mnemonicsBtn.selected = NO;
	_keyStoreBtn.selected = YES;
	_privateBtn.selected = NO;
	
	self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
}
- (IBAction)action3:(id)sender {
	_mnemonicsBtn.selected = NO;
	_keyStoreBtn.selected = NO;
	_privateBtn.selected = YES;
	
	self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*2, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	if (scrollView.contentOffset.x == 0) {
		// 助记词
		_mnemonicsBtn.selected = YES;
		_keyStoreBtn.selected = NO;
		_privateBtn.selected = NO;
		
		self.scrollView.contentOffset = CGPointMake(0, 0);
	}else if (scrollView.contentOffset.x == SCREEN_WIDTH) {
		//key store
		_mnemonicsBtn.selected = NO;
		_keyStoreBtn.selected = YES;
		_privateBtn.selected = NO;
		
		self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
	}else {
		// 私钥
		_mnemonicsBtn.selected = NO;
		_keyStoreBtn.selected = NO;
		_privateBtn.selected = YES;
		
		self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*2, 0);
	}
	
}

- (void)addMnemonicsView {
	self.mnemonicsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,self.scrollView.frame.size.height)];
	
	// 助记词  以 空格 隔开
	UITextView *textView = [[UITextView alloc] init];
	textView.layer.borderWidth = 0.6;
	textView.layer.borderColor = [UIColor grayColor].CGColor;
	[self.mnemonicsView addSubview:textView];
	
	UITextField *pwdTextField = [[UITextField alloc] init];
	pwdTextField.layer.borderWidth = 0.6;
	pwdTextField.layer.borderColor = [UIColor grayColor].CGColor;
	[self.mnemonicsView addSubview:pwdTextField];
	
	UIButton *importBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[importBtn setTitle:@"开始导入" forState:UIControlStateNormal];
	[importBtn setTintColor:[UIColor whiteColor]];
	[importBtn setBackgroundColor:UIColorHex(0x43ABC6)]; //43ABC6
	[self.mnemonicsView addSubview:importBtn];
	
	[importBtn addTapBlock:^(UIButton *btn) {
		if (textView.text.length == 0 || pwdTextField.text.length == 0) {
			[SVProgressHUD showInfoWithStatus:@"请输入关键词和密码"];
			return ;
		}
		if (pwdTextField.text.length <= 5) {
			[SVProgressHUD showInfoWithStatus:@"密码需要6位以上"];
			return;
		}
		
		[SVProgressHUD showWithStatus:@"开始导入"];
		[HSEther hs_inportMnemonics:textView.text pwd:pwdTextField.text block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey, BOOL suc, HSWalletError error) {
			
			if (!suc) {
			    // 导入失败
				[SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%ld",error]];
				return ;
			}
			
			//导入成功
			WalletInfoModel *model = [[WalletInfoModel alloc] init];
			model.address = address;
			model.keyStore = keyStore;
			model.mnemonicPhrase = mnemonicPhrase;
			model.privateKey = privateKey;
			model.walletName = @"PK-新钱包";
			model.walletPwd = pwdTextField.text;
			
			// 将钱包信息存在本地
			[WalletManager saveData:model];
			
			// 设置钱包为当前钱包
			[[CurrentWalletHandle shareInstace] setCurrentWalletModel:model];
			
			// 创建成功、跳转到备份页面
			[SVProgressHUD showSuccessWithStatus:@"钱包创建成功"];
			
			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
				MainTabBarController *vc = [[MainTabBarController alloc] init];
				AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
				delegate.window.rootViewController = vc;
				
			});
			
		}];
		
	}];
	
	
	[textView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.mnemonicsView).offset(0);
		make.left.equalTo(self.mnemonicsView).offset(20);
		make.right.equalTo(self.mnemonicsView).offset(-20);
		make.height.mas_equalTo(100);
	}];
	
	[pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(textView.mas_bottom).offset(10);
		make.left.equalTo(self.mnemonicsView).offset(20);
		make.right.equalTo(self.mnemonicsView).offset(-20);
		make.height.mas_equalTo(40);
	}];
	
	[importBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(pwdTextField.mas_bottom).offset(10);
		make.left.equalTo(self.mnemonicsView).offset(20);
		make.right.equalTo(self.mnemonicsView).offset(-20);
		make.height.mas_equalTo(40);
	}];
	
	[self.scrollView addSubview:self.mnemonicsView];
}

- (void)addkeyStoreView {
	self.keyStoreView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH,self.scrollView.frame.size.height)];
	
	// keyStore
	UITextView *textView = [[UITextView alloc] init];
	textView.layer.borderWidth = 0.6;
	textView.layer.borderColor = [UIColor grayColor].CGColor;
	[self.keyStoreView addSubview:textView];
	
	UITextField *pwdTextField = [[UITextField alloc] init];
	pwdTextField.layer.borderWidth = 0.6;
	pwdTextField.layer.borderColor = [UIColor grayColor].CGColor;
	[self.keyStoreView addSubview:pwdTextField];
	
	UIButton *importBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[importBtn setTitle:@"开始导入" forState:UIControlStateNormal];
	[importBtn setTintColor:[UIColor whiteColor]];
	[importBtn setBackgroundColor:UIColorHex(0x43ABC6)]; //43ABC6
	[self.keyStoreView addSubview:importBtn];
	
	[importBtn addTapBlock:^(UIButton *btn) {
		if (textView.text.length == 0 || pwdTextField.text.length == 0) {
			[SVProgressHUD showInfoWithStatus:@"请输入KeyStore和密码"];
			return ;
		}
		if (pwdTextField.text.length <= 5) {
			[SVProgressHUD showInfoWithStatus:@"密码需要6位以上"];
			return;
		}
		[SVProgressHUD showWithStatus:@"开始导入"];
		
		[HSEther hs_importKeyStore:textView.text pwd:pwdTextField.text block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey, BOOL suc, HSWalletError error) {
				if (!suc) {
					// 导入失败
					[SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%ld",error]];
					return ;
				}
			
				//导入成功
				WalletInfoModel *model = [[WalletInfoModel alloc] init];
				model.address = address;
				model.keyStore = keyStore;
			//	model.mnemonicPhrase = mnemonicPhrase == nil ? @" ":mnemonicPhrase ;
			
				model.privateKey = privateKey;
				model.walletName = @"PK-新钱包";
				model.walletPwd = pwdTextField.text;
			
				// 将钱包信息存在本地
				[WalletManager saveData:model];
			
				// 设置钱包为当前钱包
				[[CurrentWalletHandle shareInstace] setCurrentWalletModel:model];
			
				// 创建成功、跳转到备份页面
				[SVProgressHUD showSuccessWithStatus:@"钱包创建成功"];
			
				dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
					
					MainTabBarController *vc = [[MainTabBarController alloc] init];
					AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
					delegate.window.rootViewController = vc;
					
				});
			
			}];
			
		}];
	
	
	[textView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.keyStoreView).offset(0);
		make.left.equalTo(self.keyStoreView).offset(20);
		make.right.equalTo(self.keyStoreView).offset(-20);
		make.height.mas_equalTo(100);
	}];
	
	[pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(textView.mas_bottom).offset(10);
		make.left.equalTo(self.keyStoreView).offset(20);
		make.right.equalTo(self.keyStoreView).offset(-20);
		make.height.mas_equalTo(40);
	}];
	
	[importBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(pwdTextField.mas_bottom).offset(10);
		make.left.equalTo(self.keyStoreView).offset(20);
		make.right.equalTo(self.keyStoreView).offset(-20);
		make.height.mas_equalTo(40);
	}];
	
	[self.scrollView addSubview:self.keyStoreView];
}

- (void)addPrivateKeyView {
	self.privateKeyView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH,self.scrollView.frame.size.height)];
	
	// keyStore
	UITextView *textView = [[UITextView alloc] init];
	textView.layer.borderWidth = 0.6;
	textView.layer.borderColor = [UIColor grayColor].CGColor;
	[self.privateKeyView addSubview:textView];
	
	UITextField *pwdTextField = [[UITextField alloc] init];
	pwdTextField.layer.borderWidth = 0.6;
	pwdTextField.layer.borderColor = [UIColor grayColor].CGColor;
	[self.privateKeyView addSubview:pwdTextField];
	
	UIButton *importBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[importBtn setTitle:@"开始导入" forState:UIControlStateNormal];
	[importBtn setTintColor:[UIColor whiteColor]];
	[importBtn setBackgroundColor:UIColorHex(0x43ABC6)]; //43ABC6
	[self.privateKeyView addSubview:importBtn];
	
	[importBtn addTapBlock:^(UIButton *btn) {
		if (textView.text.length == 0 || pwdTextField.text.length == 0) {
			[SVProgressHUD showInfoWithStatus:@"请输入privateKey和密码"];
			return ;
		}
		if (pwdTextField.text.length <= 5) {
			[SVProgressHUD showInfoWithStatus:@"密码需要6位以上"];
			return;
		}
		[SVProgressHUD showWithStatus:@"开始导入"];
		// 导入私钥
		[HSEther hs_importWalletForPrivateKey:textView.text pwd:pwdTextField.text block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey, BOOL suc, HSWalletError error) {
			if (!suc) {
				// 导入失败
				[SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%ld",error]];
				return ;
			}
			
			//导入成功
			WalletInfoModel *model = [[WalletInfoModel alloc] init];
			model.address = address;
			model.keyStore = keyStore;
			model.mnemonicPhrase = mnemonicPhrase;
			model.privateKey = privateKey;
			model.walletName = @"PK-新钱包";
			model.walletPwd = pwdTextField.text;
			
			// 将钱包信息存在本地
			[WalletManager saveData:model];
			
			// 设置钱包为当前钱包
			[[CurrentWalletHandle shareInstace] setCurrentWalletModel:model];
			
			// 创建成功、跳转到备份页面
			[SVProgressHUD showSuccessWithStatus:@"钱包创建成功"];
			
			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
				MainTabBarController *vc = [[MainTabBarController alloc] init];
				AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
				delegate.window.rootViewController = vc;
				
			});
			
		}];
		
	}];
	
	
	[textView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.privateKeyView).offset(0);
		make.left.equalTo(self.privateKeyView).offset(20);
		make.right.equalTo(self.privateKeyView).offset(-20);
		make.height.mas_equalTo(100);
	}];
	
	[pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(textView.mas_bottom).offset(10);
		make.left.equalTo(self.privateKeyView).offset(20);
		make.right.equalTo(self.privateKeyView).offset(-20);
		make.height.mas_equalTo(40);
	}];
	
	[importBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(pwdTextField.mas_bottom).offset(10);
		make.left.equalTo(self.privateKeyView).offset(20);
		make.right.equalTo(self.privateKeyView).offset(-20);
		make.height.mas_equalTo(40);
	}];
	
	[self.scrollView addSubview:self.privateKeyView];
	
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
