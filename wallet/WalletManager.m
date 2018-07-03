//
//  SaveManager.m
//  wallet
//
//  Created by yanghuan on 2018/6/14.
//  Copyright © 2018年 wyChirs. All rights reserved.
//

#import "WalletManager.h"

#define WalletInfoPath @"wallet.plist"

@implementation WalletManager

+ (void)deleWalletAll {
	NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documents = [array objectAtIndex:0];
	//删除沙盒文件
	NSString *documnetPath = [documents stringByAppendingPathComponent:WalletInfoPath];
	BOOL blHave= [[NSFileManager defaultManager] fileExistsAtPath:documnetPath];
	if (blHave) {
		[[NSFileManager defaultManager] removeItemAtPath:documnetPath error:nil];
	}
}

+ (void)deleWalletOf:(WalletInfoModel *)model {
	NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documents = [array objectAtIndex:0];
	NSString *documnetPath = [documents stringByAppendingPathComponent:WalletInfoPath];
	
	// 通过address 删除指定的钱包
	NSMutableArray *ary = [NSMutableArray arrayWithArray:[self getAllWalletInfo]];
	for (NSDictionary *obj in ary) {
		if ([obj[@"address"] isEqualToString:model.address]) {
			[ary removeObject:obj];
			break;
		}
	}
	[ary writeToFile:documnetPath atomically:YES];
}

#pragma mark - 保存plist文件
+ (void)saveData:(WalletInfoModel *)model {
	NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documents = [array objectAtIndex:0];
	NSLog(@"沙盒路径----%@",documents);
	NSString *documnetPath = [documents stringByAppendingPathComponent:WalletInfoPath];
	
	NSMutableDictionary *dic = [NSMutableDictionary dictionary];
	[dic setObject:model.address forKey:@"address"];
	[dic setObject:model.keyStore forKey:@"keyStore"];
	if (model.mnemonicPhrase) {
			[dic setObject:model.mnemonicPhrase forKey:@"mnemonicPhrase"];
	}
	[dic setObject:model.privateKey forKey:@"privateKey"];
	
	[dic setObject:model.walletName forKey:@"walletName"];
	[dic setObject:model.walletPwd forKey:@"walletPwd"];
	
	//去除空的value  否则不能写入到plist文件中去
	for (NSString *key in [dic allKeys]) {
		if ([[dic valueForKey:key] isEqual:[NSNull null]] || [dic valueForKey:key] == nil) {
			[dic removeObjectForKey:key];
		}
	}
	//将字典存入指定的本地文件
	NSMutableArray *ary = [NSMutableArray arrayWithArray:[self getAllWalletInfo]];
	[ary addObject:dic];
	
	[ary writeToFile:documnetPath atomically:YES];
}

+ (NSArray *)getAllWalletInfo{
	NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documents = [array objectAtIndex:0];
	NSString *documnetPath = [documents stringByAppendingPathComponent:WalletInfoPath];
	
	NSArray *ary;
	if([[NSFileManager defaultManager] fileExistsAtPath:documnetPath]){
		ary = [[NSArray alloc] initWithContentsOfFile:documnetPath];
	}else{
		return [NSArray array];
	}
	return ary;
}


//- (NSArray *)getAllWallet {
//	NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	NSString *documents = [array objectAtIndex:0];
//	NSString *documnetPath = [documents stringByAppendingPathComponent:WalletInfoPath];
//
//	NSArray *ary;
//	if([[NSFileManager defaultManager] fileExistsAtPath:documnetPath]){
//		ary = [[NSArray alloc] initWithContentsOfFile:documnetPath];
//	}else{
//		return [NSArray array];
//	}
//	return ary;
//}

@end
