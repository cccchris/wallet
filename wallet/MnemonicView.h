//
//  MnemonicView.h
//  wallet
//
//  Created by yanghuan on 2018/6/12.
//  Copyright © 2018年 wyChirs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickWordTagBlock)(NSString *key);

@interface MnemonicView : UIView

- (instancetype)initWithFrame:(CGRect)frame
					 tagColor:(UIColor *)tagColor
					 tagBlock:(ClickWordTagBlock)clickBlock;


/**
 *  整个View的背景颜色
 */
@property (nonatomic, strong) UIColor *bgColor;
/**
 *  设置子标签View的单一颜色
 */
@property (nonatomic, strong) UIColor *tagColor;

/**
 * 助记词数组
 */
@property (nonatomic, strong)NSArray *wordsArr;

/**
 * 点击标签
 */
@property (nonatomic, copy)ClickWordTagBlock clickBlock;


@end

/*
 - (MnemonicView *)mnemonicViewTop {
 if (!_mnemonicViewTop) {
 //__weak typeof(self) weakSelf = self;
 _mnemonicViewTop = [[MnemonicView alloc] initWithFrame:CGRectMake(20, 100, SCREEN_WIDTH-40, 100) tagColor:[UIColor whiteColor] tagBlock:^(NSString *key) {
 NSLog(@"点击热搜%@",key);
 // 移除点击的助记词
 NSMutableArray *removeArys = [NSMutableArray arrayWithArray:_mnemonicViewTop.wordsArr];
 [removeArys removeObject:key];
 _mnemonicViewTop.wordsArr = removeArys;
 
 //添加到待选助记词中
 NSMutableArray *addArys = [NSMutableArray arrayWithArray:_mnemonicViewBottom.wordsArr];
 [addArys addObject:key];
 _mnemonicViewBottom.wordsArr = addArys;
 
 
 }];
 //_mnemonicViewTop.wordsArr = @[@"我是",@"创建",@"科技",@"研发",@"iOS组员",@"玉树临风",@"高大威猛",@"才华横溢",@"这TM都信"];
 }
 return _mnemonicViewTop;
 }
 
 - (MnemonicView *)mnemonicViewBottom {
 if (!_mnemonicViewBottom) {
 //__weak typeof(self) weakSelf = self;
 _mnemonicViewBottom = [[MnemonicView alloc] initWithFrame:CGRectMake(20, 300, SCREEN_WIDTH-40, 100) tagColor:[UIColor whiteColor] tagBlock:^(NSString *key) {
 NSLog(@"点击助记词-----%@",key);
 //	__strong typeof(weakSelf) strongSelf = weakSelf;
 // 添加到助记词中
 NSMutableArray *addArys = [NSMutableArray arrayWithArray:_mnemonicViewTop.wordsArr];
 [addArys addObject:key];
 _mnemonicViewTop.wordsArr = addArys;
 
 // 从可选助记词中移除，
 NSMutableArray *removeArys = [NSMutableArray arrayWithArray:_mnemonicViewBottom.wordsArr];
 [removeArys removeObject:key];
 // 重新随机打乱数组
 _mnemonicViewBottom.wordsArr = [removeArys sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
 int seed = arc4random_uniform(2);
 if (seed) {
 return [str1 compare:str2];
 } else {
 return [str2 compare:str1];
 }
 }];
 }];
 _mnemonicViewBottom.wordsArr = @[@"fault",@"keep",@"swift",@"enhance",@"benefit",@"hazard",@"mistake",@"estate",@"arch",@"diamond",@"click"];
 }
 return _mnemonicViewBottom;
 }

 */
