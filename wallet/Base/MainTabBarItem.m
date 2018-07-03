//
//  MainTabBarItem.m
//  ThankYou
//
//  Created by lizzy on 16/5/4.
//  Copyright © 2016年 2011-2013 湖南长沙阳环科技实业有限公司 @license http://www.yhcloud.com.cn. All rights reserved.
//

#import "MainTabBarItem.h"

@implementation MainTabBarItem {

    NSString *_normalImageName;
    NSString *_selectedImageName;
    
    UIColor *_normalFontColor;
    UIColor *_selectedFontColor;
}

- (id)initWithFrame:(CGRect)frame
    normalImageName:(NSString *)normalImageName
  selectedImageNemd:(NSString *)selectedImageName
    normalFontColor:(UIColor *)normalFontColor
  selectedFontColor:(UIColor *)selectedFontColor
              title:(NSString *)title
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _normalImageName = normalImageName;
        _selectedImageName = selectedImageName;
        
        _normalFontColor = normalFontColor;
        _selectedFontColor = selectedFontColor;
        
        // 设置背景图片
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-40)/2, 5, 38, 30)];
        // 设置图片模式
        self.imgView.contentMode = UIViewContentModeScaleAspectFit;
        self.imgView.image = [UIImage imageNamed:normalImageName];
        [self addSubview:self.imgView];
        
        //设置title
        CGFloat imageViewBottom = CGRectGetMaxY(self.imgView.frame);
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageViewBottom, CGRectGetWidth(self.frame), 15)];
        self.titleLabel.text = title;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
		self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textColor = normalFontColor;
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
    normalImageName:(NSString *)normalImageName
  selectedImageNemd:(NSString *)selectedImageName
    normalFontColor:(UIColor *)normalFontColor
  selectedFontColor:(UIColor *)selectedFontColor
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _normalImageName = normalImageName;
        _selectedImageName = selectedImageName;
        
        _normalFontColor = normalFontColor;
        _selectedFontColor = selectedFontColor;
        
        // 设置背景图片
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-27)/2, 5, 27, 23)];
        // 设置图片模式
        self.imgView.contentMode = UIViewContentModeScaleAspectFit;
        self.imgView.image = [UIImage imageNamed:normalImageName];
        [self addSubview:self.imgView];
    }
    return self;
}

// 设置选中状态和非选中状态
- (void)setIsSelected:(BOOL) selected
{
    if (selected) { // 设置选中效果
        self.imgView.image = [UIImage imageNamed:_selectedImageName];
        self.titleLabel.textColor = _selectedFontColor;
    } else { // 设置未选中状态下的效果
        self.imgView.image = [UIImage imageNamed:_normalImageName];
        self.titleLabel.textColor = _normalFontColor;
    }
    
}
@end
