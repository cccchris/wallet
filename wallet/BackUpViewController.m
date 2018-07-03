//
//  BackUpViewController.m
//  wallet
//
//  Created by yanghuan on 2018/6/12.
//  Copyright © 2018年 wyChirs. All rights reserved.
//

#import "BackUpViewController.h"
#import "MnemonicView.h"
#import "HomeVC.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"


@interface BackUpViewController ()
@property(nonatomic,strong)MnemonicView *mnemonicViewTop;// 助记词
@property(nonatomic,strong)MnemonicView *mnemonicViewBottom; // 待选助记词


@end

@implementation BackUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[self.view addSubview:self.mnemonicViewTop];
	[self.view addSubview:self.mnemonicViewBottom];
}

- (MnemonicView *)mnemonicViewTop {
	if (!_mnemonicViewTop) {
		//__weak typeof(self) weakSelf = self;
		_mnemonicViewTop = [[MnemonicView alloc] initWithFrame:CGRectMake(20, 100, SCREEN_WIDTH-40, 100) tagColor:[UIColor whiteColor] tagBlock:^(NSString *key) {
			NSLog(@"点击热搜%@",key);
			// 移除点击的助记词
			NSMutableArray *removeArys = [NSMutableArray arrayWithArray:_mnemonicViewTop.wordsArr];
			[removeArys removeObject:key];
			_mnemonicViewTop.wordsArr = removeArys;
			
			//添加到待选助记词中
			NSMutableArray *addArys = [NSMutableArray arrayWithArray:_mnemonicViewBottom.wordsArr];
			[addArys addObject:key];
			_mnemonicViewBottom.wordsArr = addArys;
		}];
	}
	return _mnemonicViewTop;
}

- (MnemonicView *)mnemonicViewBottom {
	if (!_mnemonicViewBottom) {
		//__weak typeof(self) weakSelf = self;
		_mnemonicViewBottom = [[MnemonicView alloc] initWithFrame:CGRectMake(20, 300, SCREEN_WIDTH-40, 100) tagColor:[UIColor whiteColor] tagBlock:^(NSString *key) {
			NSLog(@"点击助记词-----%@",key);
			//	__strong typeof(weakSelf) strongSelf = weakSelf;
			// 添加到助记词中
			NSMutableArray *addArys = [NSMutableArray arrayWithArray:_mnemonicViewTop.wordsArr];
			[addArys addObject:key];
			_mnemonicViewTop.wordsArr = addArys;
			
			// 从可选助记词中移除，
			NSMutableArray *removeArys = [NSMutableArray arrayWithArray:_mnemonicViewBottom.wordsArr];
			[removeArys removeObject:key];
			// 重新随机打乱数组
			_mnemonicViewBottom.wordsArr = [removeArys sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
				int seed = arc4random_uniform(2);
				if (seed) {
					return [str1 compare:str2];
				} else {
					return [str2 compare:str1];
				}
			}];
		}];
		
		_mnemonicViewBottom.wordsArr = [self.wordsAry sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
			int seed = arc4random_uniform(2);
			if (seed) {
				return [str1 compare:str2];
			} else {
				return [str2 compare:str1];
			}
		}];//@[@"fault",@"keep",@"swift",@"enhance",@"benefit",@"hazard",@"mistake",@"estate",@"arch",@"diamond",@"click"];
	}
	return _mnemonicViewBottom;
}

- (IBAction)action:(id)sender {
	if ([[self.wordsAry componentsJoinedByString:@"  "] isEqualToString:[_mnemonicViewTop.wordsArr componentsJoinedByString:@"  "]]) {
		NSLog(@"备份成功");
		[SVProgressHUD showSuccessWithStatus:@"备份成功"];
		WalletInfoModel *model = [[CurrentWalletHandle shareInstace] getCurrentWalletModel];
		// 先将当前钱包信息在本地删除掉
		[WalletManager deleWalletOf:model];
		
		// 去掉钱包的助记词信息，在将钱包信息保存在本地
		model.mnemonicPhrase = @"";
		[WalletManager saveData:model];
		
		// 设置 其钱包信息 为当前钱包
		[[CurrentWalletHandle shareInstace] setCurrentWalletModel:model];
		
		// 进入钱包主界面
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			//设置为rootview
			MainTabBarController *vc = [[MainTabBarController alloc] init];
			
			AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
			delegate.window.rootViewController = vc;
			
		});
		
	}else {
		NSLog(@"助记词顺序不正确");
		[SVProgressHUD showErrorWithStatus:@"请检查助记词的顺序"];
	}
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
