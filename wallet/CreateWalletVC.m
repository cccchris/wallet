//
//  CreateWalletVC.m
//  wallet
//
//  Created by yanghuan on 2018/6/14.
//  Copyright © 2018年 wyChirs. All rights reserved.
//

#import "CreateWalletVC.h"
#import "HSEther.h"
#import "WalletInfoModel.h"
#import "MnemonicVC.h"

@interface CreateWalletVC ()
@property (weak, nonatomic) IBOutlet UITextField *walletNametextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdtextField;

@end

@implementation CreateWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.edgesForExtendedLayout =UIRectEdgeNone;
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.navigationItem.title = @"创建钱包";
}

- (IBAction)createAction:(id)sender {
	[self.view endEditing:YES];
	
	if (_walletNametextField.text.length == 0  || _pwdtextField.text.length == 0 ) {
		[SVProgressHUD showErrorWithStatus:@"请输入钱包名称及密码"];
		return;
	}
	
	if (_pwdtextField.text.length <=5) {
		[SVProgressHUD showErrorWithStatus:@"密码长度必须大于6位"];
		return;
	}
	
	[SVProgressHUD showWithStatus:@"创建钱包中..."];
	
	//创建钱包 等5秒钟，创建比较慢
	[HSEther hs_createWithPwd:_pwdtextField.text block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey) {
		NSLog(@"\n\n%@\n%@\n%@\n%@\n\n",address,keyStore,mnemonicPhrase,privateKey);
		// 这里创建成功之后，将对应的信息存在本地  跳转到备份助记词-----备份完助记词后就删掉助记词
		// 私钥和 keyStore 保存在本地
		WalletInfoModel *model = [[WalletInfoModel alloc] init];
		model.address = address;
		model.keyStore = keyStore;
		model.mnemonicPhrase = mnemonicPhrase;
		model.privateKey = privateKey;
		model.walletName = _walletNametextField.text;
		model.walletPwd = _pwdtextField.text;
		
		// 将钱包信息存在本地
		[WalletManager saveData:model];
		
		// 设置钱包为当前钱包
		[[CurrentWalletHandle shareInstace] setCurrentWalletModel:model];
		
		// 创建成功、跳转到备份页面
		[SVProgressHUD showSuccessWithStatus:@"钱包创建成功"];
		
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			MnemonicVC *vc = [[MnemonicVC alloc] initWithNibName:@"MnemonicVC" bundle:nil];
			vc.mnemonic = model.mnemonicPhrase;
			[self.navigationController pushViewController:vc animated:YES];
		});
		
	}];
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
