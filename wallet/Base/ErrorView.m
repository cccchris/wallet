//
//  ErrorView.m
//  基类调试
//
//  Created by ios on 2016/12/23.
//  Copyright © 2016年 Wy. All rights reserved.
//

#import "ErrorView.h"


@implementation ErrorView

-(instancetype)initWithFrame:(CGRect)frame{
   
    if (self == [super initWithFrame:frame]) {
        
        UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(25, (SCREEN_HEIGHT-280)/2-100, SCREEN_WIDTH-50, 280)];
        tempView.userInteractionEnabled = YES;
        tempView.tag = 1000;
        [self addSubview:tempView];
        
        self.backgroudImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 0, tempView.frame.size.width-50, tempView.frame.size.height-50)];
        self.backgroudImageView.userInteractionEnabled = YES;
        self.backgroudImageView.contentMode = UIViewContentModeScaleAspectFit;
        [tempView addSubview:self.backgroudImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, tempView.frame.size.height-40, tempView.frame.size.width, 21)];
        
        self.titleLabel.text = @"您的访问出错啦";
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [tempView addSubview:self.titleLabel];
        
        self.refershBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.refershBtn.frame = CGRectMake(SCREEN_WIDTH/2-60, CGRectGetMaxY(tempView.frame)+5, 120, 40);
        [self.refershBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        self.refershBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.refershBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.refershBtn.layer.borderWidth = 0.6;
        self.refershBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        
        [self.refershBtn addTarget:self action:@selector(refershDataClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.refershBtn];
        
       // UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refershDataClick:)];
        
      //  [self.backgroudImageView addGestureRecognizer:tap];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)setIsError:(BOOL)isError{
    if (isError) {
        self.titleLabel.text = @"您的访问出错了";
        self.refershBtn.hidden = NO;
        self.backgroudImageView.userInteractionEnabled = YES;
    }
    else
    {
        self.titleLabel.text = @"暂无数据";
        self.refershBtn.hidden = NO;
        self.backgroudImageView.userInteractionEnabled = YES;
    }
    
}

-(void)refershDataClick:(UIButton *)sender{
    
    if (self.block != nil) {
        self.block(0);
    }
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
