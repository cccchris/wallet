//
//  ErrorView.h
//  基类调试
//
//  Created by ios on 2016/12/23.
//  Copyright © 2016年 Wy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH ( [[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ( [[UIScreen mainScreen] bounds].size.height)

typedef void(^refreshData)(NSInteger tag);
@interface ErrorView : UIView

@property(nonatomic,strong)UIImageView *backgroudImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *refershBtn;
@property(nonatomic,strong)refreshData block;
@property(nonatomic,assign)BOOL isError;

@end
