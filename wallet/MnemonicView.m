//
//  MnemonicView.m
//  wallet
//
//  Created by yanghuan on 2018/6/12.
//  Copyright © 2018年 wyChirs. All rights reserved.
//

#import "MnemonicView.h"



/** 字体离边框的水平距离 */
#define kTitleHorizontal_space 10.0f

/** 字体离边框的竖直距离 */
#define kTitleVertical_space   5.0f

/** tagLab之间的水平间距 */
#define kTagHorizontal_margin  15.0f

/** tagLab之间的竖直间距 */
#define kTagVertical_margin    10.0f

/** tagLab与屏幕左右间距 */
#define kTagScreen_margin  12.f

/** tag字体 **/
#define kTagFont [UIFont systemFontOfSize:13]


@interface MnemonicView ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong)UILabel *lastTagLabel;

@end

@implementation MnemonicView

- (instancetype)initWithFrame:(CGRect)frame
					 tagColor:(UIColor *)tagColor
					 tagBlock:(ClickWordTagBlock)clickBlock {
	
	self = [super initWithFrame:frame];
	
	if (self) {
		
		self.userInteractionEnabled = YES;
		
		self.backgroundColor =  UIColorHex(0xE7E7E7);  //[UIColor lightGrayColor];
		
		_tagColor = tagColor;
		
		_clickBlock = clickBlock;
		
	}
	return self;
}

- (void)setWordsArr:(NSArray *)wordsArr {
	
	_wordsArr = wordsArr;
	
	//移除所有标签
	[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
	
	//如果没有文本
	if (_wordsArr.count == 0) {
		//self.hidden = YES;
		return;
	}
	
	//复原布局
	_lastTagLabel = nil;
	
	for (int i = 0 ; i<_wordsArr.count ;i++) {
		
		NSString *textStr = _wordsArr[i];
		
		UILabel *tag = [UILabel new];
		
		tag.text = textStr;
		
		CGSize tagSize = [textStr sizeWithAttributes:@{NSFontAttributeName:kTagFont}];
		tagSize.width += kTitleHorizontal_space*2;
		tagSize.height += kTitleVertical_space*2;
		
		if (i == 0) {
			//第一条，不存在lastTagLabel
			tag.frame = CGRectMake(kTagScreen_margin, kTagVertical_margin, tagSize.width, tagSize.height);
		} else {
			
			if (CGRectGetMaxX(_lastTagLabel.frame)+
				kTagHorizontal_margin +
				tagSize.width  > self.bounds.size.width-kTagScreen_margin) {
				//换行
				tag.frame = CGRectMake(kTagScreen_margin, CGRectGetMaxY(_lastTagLabel.frame)+kTagVertical_margin, tagSize.width, tagSize.height);
			}
			else {
				// 同一行
				tag.frame = CGRectMake(CGRectGetMaxX(_lastTagLabel.frame)+kTagHorizontal_margin, CGRectGetMinY(_lastTagLabel.frame), tagSize.width, tagSize.height);
				
			}
		}
		
		//配置文本
		[self configLabel:tag];
		
		[self addSubview:tag];
		
		_lastTagLabel = tag;
		
		//最后一个tag的时候赋值高度
		if (i == _wordsArr.count-1) {
			CGRect tempFrame = self.frame;
			tempFrame.size.height = CGRectGetMaxY(_lastTagLabel.frame)+kTagVertical_margin;
			self.frame = tempFrame;
		}
	}
	
	
}
- (void)setBgColor:(UIColor *)bgColor {
	_bgColor = bgColor;
	self.backgroundColor = bgColor;
}
#pragma mark -- 文本属性设置
- (void)configLabel:(UILabel *)tag {
	
	
	tag.userInteractionEnabled = YES;
	if(_tagColor){
		//可以单一设置tag的颜色
		tag.backgroundColor = _tagColor;
	}else{
		//tag颜色默认白色
		tag.backgroundColor = [UIColor whiteColor];
	}
	tag.textAlignment = NSTextAlignmentCenter;
	tag.textColor = [UIColor blackColor];
	tag.font = kTagFont;
	
	//给文本添加点击
	UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchSubTagView:)];
	tapOne.delegate = self;
	tapOne.numberOfTapsRequired = 1.0;
	[tag addGestureRecognizer:tapOne];
}

#pragma mark -- 点击文本
-(void)touchSubTagView:(UITapGestureRecognizer*)tapOne
{
	UILabel *tag = (UILabel *)tapOne.view;
	if (_clickBlock) {
		_clickBlock(tag.text);
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
