//
//  MainTabBarItem.h
//  ThankYou
//
//  Created by lizzy on 16/5/4.
//  Copyright © 2016年 2011-2013 湖南长沙阳环科技实业有限公司 @license http://www.yhcloud.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarItem : UIControl
/*!
 *  @author lizzy, 15-08-14 17:08:23
 *
 *  @brief  选中状态，YES为选中状态，NO为非选中状态
 *
 *  @since 3.0.1
 */
@property (nonatomic, assign)BOOL isSelected;

@property (nonatomic,strong) UIImageView *imgView;

@property (nonatomic,strong) UILabel *titleLabel;

/*!
 *  @author lizzy, 15-08-18 09:08:02
 *
 *  @brief  初始化Tabbar的item
 *
 *  @param frame             item的frame
 *  @param normalImageName   非选中状态的图片名称
 *  @param selectedImageName 选中状态的按钮图片名称
 *  @param normalFontColor   非选中状态的字体颜色
 *  @param selectedFontColor 选中状态的字体颜色
 *  @param title             item的title
 *
 *  @return item
 *
 *  @since 3.0.1
 */

- (id)initWithFrame:(CGRect)frame
    normalImageName:(NSString *)normalImageName
  selectedImageNemd:(NSString *)selectedImageName
    normalFontColor:(UIColor *)normalFontColor
  selectedFontColor:(UIColor *)selectedFontColor
              title:(NSString *)title;

- (id)initWithFrame:(CGRect)frame
    normalImageName:(NSString *)normalImageName
  selectedImageNemd:(NSString *)selectedImageName
    normalFontColor:(UIColor *)normalFontColor
  selectedFontColor:(UIColor *)selectedFontColor;
@end
