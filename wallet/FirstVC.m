//
//  FirstVC.m
//  wallet
//
//  Created by yanghuan on 2018/6/13.
//  Copyright © 2018年 wyChirs. All rights reserved.
//

#import "FirstVC.h"
#import "HSEther.h"
#import "CreateWalletVC.h"
#import "ImportWalletVC.h"
@interface FirstVC ()

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.navigationItem.title = @"钱包";
	
}

- (IBAction)createAction:(id)sender {
	// 创建钱包
	CreateWalletVC *vc = [[CreateWalletVC alloc] initWithNibName:@"CreateWalletVC" bundle:nil];
	[self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)importAction:(id)sender {
    // 导入钱包 ---- （私钥导入  keyStroe导入）
	ImportWalletVC *vc = [[ImportWalletVC alloc] initWithNibName:@"ImportWalletVC" bundle:nil];
	[self.navigationController pushViewController:vc animated:YES];
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
