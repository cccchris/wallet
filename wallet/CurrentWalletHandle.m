//
//  CurrentWalletHandle.m
//  wallet
//
//  Created by yanghuan on 2018/6/14.
//  Copyright © 2018年 wyChirs. All rights reserved.
//

#import "CurrentWalletHandle.h"


static  CurrentWalletHandle *instance = nil;
#define CurrentWalletPath @"wallet.archive"

@implementation CurrentWalletHandle
+ (CurrentWalletHandle *)shareInstace {
	
	static dispatch_once_t onecToken = 0;
	
	dispatch_once(&onecToken, ^{
		instance = [[self alloc] init];
	});
	
	return instance;
}

- (void)setCurrentWalletModel:(WalletInfoModel *)model {
	NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documents = [array objectAtIndex:0];
	NSLog(@"沙盒路径----%@",documents);
	NSString *documnetPath = [documents stringByAppendingPathComponent:CurrentWalletPath];
	
	[NSKeyedArchiver archiveRootObject:model toFile:documnetPath];
}

- (WalletInfoModel *)getCurrentWalletModel{
	NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documents = [array objectAtIndex:0];
	NSLog(@"沙盒路径----%@",documents);
	NSString *documnetPath = [documents stringByAppendingPathComponent:CurrentWalletPath];
	WalletInfoModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:documnetPath];
	
	return model;
}

@end
