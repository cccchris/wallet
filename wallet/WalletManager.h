//
//  SaveManager.h
//  wallet
//
//  Created by yanghuan on 2018/6/14.
//  Copyright © 2018年 wyChirs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WalletManager : NSObject

// 移除所有钱包
+ (void)deleWalletAll;
// 移除指定钱包
+ (void)deleWalletOf:(WalletInfoModel *)model;

// 保存 钱包信息
+ (void)saveData:(WalletInfoModel *)model;

// 获取所有本地保存的所有钱包信息
+ (NSArray *)getAllWalletInfo;

@end
