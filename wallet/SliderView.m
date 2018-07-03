//
//  SliderView.m
//  wallet
//
//  Created by yanghuan on 2018/6/26.
//  Copyright © 2018年 wyChirs. All rights reserved.
//

#import "SliderView.h"
#import "WalletManager.h"

@interface SliderView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,weak)UIView *bgView;
@property(nonatomic,strong)NSMutableArray *data;

@end

@implementation SliderView

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		UIView *bgview = [[UIView alloc] init];
		bgview.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
		self.bgView = bgview;
		[self addSubview:self.bgView];
		
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeViewAction)];
		[self.bgView addGestureRecognizer:tap];
		
		
		self.data = [NSMutableArray arrayWithArray:[WalletManager getAllWalletInfo]];
		
		UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, 50)];
		
		UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height-49-64) style:UITableViewStylePlain];
		self.tableView = tableView;
		self.tableView.tableHeaderView = headView;
		self.tableView.delegate = self;
		self.tableView.dataSource = self;
		[self addSubview:tableView];
		
		
		
	}
	return self;
}

// 2.重写layoutSubviews，给自己内部子控件设置frame
- (void)layoutSubviews {
	[super layoutSubviews];
	CGSize size = self.frame.size;
	self.bgView.frame = CGRectMake(0, 0, size.width , size.height);
}

- (void)closeViewAction {
	[UIView animateWithDuration:0.25 animations:^{
		self.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
	} completion:^(BOOL finished) {
		[self removeFromSuperview];
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
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
	}
	
	
	NSDictionary *dic = self.data[indexPath.row];
	cell.textLabel.text =  dic[@"walletName"];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	NSLog(@"第%ld个钱包",indexPath.row+1);
	NSDictionary *dic = self.data[indexPath.row];
	
	if (self.block) {
		self.block(dic);
	}
	
	[UIView animateWithDuration:0.25 animations:^{
		self.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
	} completion:^(BOOL finished) {
		[self removeFromSuperview];
	}];
	
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
