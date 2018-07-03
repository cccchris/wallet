//
//  BaseViewController.h
//  Keepcaring
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ErrorView.h"

@interface BaseViewController : UIViewController
///**
// *  显示没有数据页面
// */
//-(void)showNoDataImage;
//
///**
// *  移除无数据页面
// */
//-(void)removeNoDataImage;

// 重新获取数据
- (void)refreshData;

//展示 错误或 无数据页面
-(void)showImagePage:(BOOL)show withIsError:(BOOL)error;

@end
