//
//  WalletInfoModel.h
//  wallet
//
//  Created by yanghuan on 2018/6/14.
//  Copyright © 2018年 wyChirs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WalletInfoModel : NSObject
//,address,keyStore,mnemonicPhrase,privateKey
@property(nonatomic,copy)NSString *address;//钱包地址
@property(nonatomic,copy)NSString *keyStore;//官方keyStore
@property(nonatomic,copy)NSString *mnemonicPhrase;//助记词
@property(nonatomic,copy)NSString *privateKey;//私钥

@property(nonatomic,copy)NSString *walletName;//钱包名称
@property(nonatomic,copy)NSString *walletPwd;//钱包密码


@end
