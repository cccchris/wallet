//
//  CurrentWalletHandle.h
//  wallet
//
//  Created by yanghuan on 2018/6/14.
//  Copyright © 2018年 wyChirs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentWalletHandle : NSObject

+ (CurrentWalletHandle *)shareInstace;

- (void)setCurrentWalletModel:(WalletInfoModel *)model;
- (WalletInfoModel *)getCurrentWalletModel;


@end
