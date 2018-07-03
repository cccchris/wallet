//
//  HomeVC.m
//  wallet
//
//  Created by yanghuan on 2018/6/14.
//  Copyright © 2018年 wyChirs. All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *walletNameLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *data;

@end

@implementation HomeVC


- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	[self requestETHProperty];
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.navigationItem.title = @"资产";
	self.data = [NSMutableArray array];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	
}

- (void)requestETHProperty {
	WalletInfoModel *model = [[CurrentWalletHandle shareInstace] getCurrentWalletModel];
	_walletNameLab.text = model.walletName;
	_addressLab.text = model.address;
	
	// eth  token
	NSString *ethAddress = @"0x86fa049857e0209aa7d9e616f7eb3b3b78ecfdb0";
	// 钱包地址
	NSString *walletAddress = model.address;
	
	// 只查询了 eth 的余额
	[HSEther hs_getBalanceWithTokens:@[ethAddress] withAddress:walletAddress block:^(NSArray *arrayBanlance, BOOL suc) {
		[self.data removeAllObjects];
		if (suc) {
			// eth 小数位  是18位
			NSLog(@"eth余额====%@",arrayBanlance.firstObject);
			NSString *eth = arrayBanlance.firstObject;
			[self.data addObject:[NSString stringWithFormat:@"%.04f",eth.floatValue /1000000000000000000]];
			
		}else {
			[self.data addObject:@"0"];
			
		}
		[self.tableView reloadData];
	}];
}


#pragma mark - tableView delegate

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.data.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
	}
	
	cell.textLabel.text = @"ETH";
	cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
	cell.textLabel.textColor = [UIColor blackColor];
	cell.detailTextLabel.text = self.data[indexPath.row];
	return cell;
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
