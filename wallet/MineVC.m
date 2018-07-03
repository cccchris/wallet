//
//  MineVC.m
//  wallet
//
//  Created by yanghuan on 2018/6/14.
//  Copyright © 2018年 wyChirs. All rights reserved.
//

#import "MineVC.h"
#import "SliderView.h"
#import "ImportWalletVC.h"
#import "CreateWalletVC.h"
#import "FirstVC.h"

@interface MineVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *walletNameLab;
@property (weak, nonatomic) IBOutlet UILabel *walletAddressLab;
@property (weak, nonatomic) IBOutlet UIButton *shiftBtn;

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.edgesForExtendedLayout =UIRectEdgeNone;
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.navigationItem.title = @"管理";
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	[self.tableView reloadData];
	WalletInfoModel *model = [[CurrentWalletHandle shareInstace] getCurrentWalletModel];
	_walletNameLab.text = model.walletName;
	_walletAddressLab.text = model.address;
	
}

- (IBAction)shiftAction:(id)sender {
	// 切换账号
	SliderView *sliderView = [[SliderView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
	[self.view addSubview:sliderView];
	
	sliderView.block = ^(NSDictionary *walletDic) {
		
		WalletInfoModel *model = [WalletInfoModel mj_objectWithKeyValues:walletDic];
		[[CurrentWalletHandle shareInstace] setCurrentWalletModel:model];
		_walletNameLab.text = model.walletName;
		_walletAddressLab.text = model.address;
	};
	
	[UIView animateWithDuration:0.25 animations:^{
		sliderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
	}];
}


#pragma mark - tableView delegate

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		return 1;
	}else if (section == 1) {
		return 2;
	}
	return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	}
	
	if (indexPath.section ==0) {
		cell.textLabel.text = @"修改密码";
	}else if (indexPath.section == 1) {
		if (indexPath.row == 0) {
			cell.textLabel.text = @"导出私钥";
		}else {
			cell.textLabel.text = @"导出Keystore";
		}
	}else if (indexPath.section == 2 ){
		if (indexPath.row == 0) {
			cell.textLabel.text = @"删除钱包";
		}else if (indexPath.row == 1) {
			cell.textLabel.text = @"创建钱包";
		}else {
			cell.textLabel.text = @"导入钱包";
		}
	}
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		// 修改密码
		// 与本地存储的密码校对、 对了之后直接更改密码即可
		[self AlertWithTitle:@"温馨提示" message:@"请输入密码" buttons:@[@"取消",@"确定"] textFieldNumber:3 configuration:^(UITextField *field, NSInteger index) {
			if (index == 0) {
				field.placeholder = @"原密码";
			}else {
				field.placeholder = @"新密码";
			}
			
		} animated:YES action:^(NSArray<UITextField *> *fields, NSInteger index) {
			if (index == 1) {
				WalletInfoModel *model = [[CurrentWalletHandle shareInstace] getCurrentWalletModel];
				if ([fields[0].text isEqualToString:model.walletPwd]) {
					if (fields[1].text.length > 0) {
						model.walletPwd = fields[1].text;
						[[CurrentWalletHandle shareInstace] setCurrentWalletModel:model];
						dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
							
						});
						[SVProgressHUD showSuccessWithStatus:@"设置成功"];
					}else {
						dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
						[SVProgressHUD showErrorWithStatus:@"请输入新密码"];
						});
				    }
				}else {
					dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
						[SVProgressHUD showErrorWithStatus:@"密码错误"];
					});
				}
			}
		}];
		
	}else if(indexPath.section == 1) {
		if (indexPath.row == 0) {
			// 导出私钥
			// 匹配密码，对了之后再 将私钥导出来
			[self AlertWithTitle:@"温馨提示" message:@"请输入密码" buttons:@[@"取消",@"确定"] textFieldNumber:1 configuration:^(UITextField *field, NSInteger index) {
				
			} animated:YES action:^(NSArray<UITextField *> *fields, NSInteger index) {
				if (index == 1) {
					WalletInfoModel *model = [[CurrentWalletHandle shareInstace] getCurrentWalletModel];
					if ([fields[0].text isEqualToString:model.walletPwd]) {
						dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
							[SVProgressHUD showSuccessWithStatus:model.privateKey];
						});
						
					}else {
						dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
							[SVProgressHUD showErrorWithStatus:@"密码错误"];
						});
						
					}
				}
			}];
		}else {
			// 导出keystore
			// 匹配密码，对了之后再 将keystore导出来
			[self AlertWithTitle:@"温馨提示" message:@"请输入密码" buttons:@[@"取消",@"确定"] textFieldNumber:1 configuration:^(UITextField *field, NSInteger index) {
				
			} animated:YES action:^(NSArray<UITextField *> *fields, NSInteger index) {
				if (index == 1) {
					WalletInfoModel *model = [[CurrentWalletHandle shareInstace] getCurrentWalletModel];
					if ([fields[0].text isEqualToString:model.walletPwd]) {
						dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
								[SVProgressHUD showSuccessWithStatus:model.keyStore];
						});
					
					}else {
						dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
							[SVProgressHUD showErrorWithStatus:@"密码错误"];
						});
						
					}
				}
			}];
		}
	}else {
		if (indexPath.row == 0) {
			// 删除钱包
			[self AlertWithTitle:@"温馨提示" message:@"请输入密码" buttons:@[@"取消",@"确定"] textFieldNumber:1 configuration:^(UITextField *field, NSInteger index) {
				
			} animated:YES action:^(NSArray<UITextField *> *fields, NSInteger index) {
				if (index == 1) {
					WalletInfoModel *model = [[CurrentWalletHandle shareInstace] getCurrentWalletModel];
					if ([fields[0].text isEqualToString:model.walletPwd]) {
						[WalletManager deleWalletOf:model];
						
						NSArray *ary = [NSArray arrayWithArray:[WalletManager getAllWalletInfo]];
						if (ary.count > 0) {
							NSDictionary *dic = ary[0];
							WalletInfoModel *newModel = [WalletInfoModel mj_objectWithKeyValues:dic];
							[[CurrentWalletHandle shareInstace] setCurrentWalletModel:newModel];
							_walletNameLab.text = model.walletName;
							_walletAddressLab.text = model.address;
							
						}else {
							// 回到 创建的页面
							FirstVC *vc = [[FirstVC alloc] initWithNibName:@"FirstVC" bundle:nil];
							UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
							nav.navigationBar.translucent = NO;
							[UIApplication sharedApplication].keyWindow.rootViewController = nav;
							
						}
						
					}else {
						dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
							[SVProgressHUD showErrorWithStatus:@"密码错误"];
						});
						
					}
				}
			}];
			
		}else if (indexPath.row == 1) {
			// 创建钱包
			CreateWalletVC *vc = [[CreateWalletVC alloc] initWithNibName:@"CreateWalletVC" bundle:nil];
			[self.navigationController pushViewController:vc animated:YES];
		}else {
			// 导入钱包
			ImportWalletVC *vc = [[ImportWalletVC alloc] initWithNibName:@"ImportWalletVC" bundle:nil];
			[self.navigationController pushViewController:vc animated:YES];
		}
		
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
