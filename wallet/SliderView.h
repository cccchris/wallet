//
//  SliderView.h
//  wallet
//
//  Created by yanghuan on 2018/6/26.
//  Copyright © 2018年 wyChirs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectWalletBlock)(NSDictionary *walletDic);

@interface SliderView : UIView

@property(nonatomic,copy)selectWalletBlock block;

@end
