//
//  UIView+util.h
//  BY_iphone
//
//  Created by 鞠鹏 on 15/11/3.
//  Copyright © 2015年 wuxinyi. All rights reserved.
//

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
@interface UIView (util)

@property (nonatomic,strong) UIImageView * toolImageView;

@property (nonatomic,strong) UIPlaceHolderTextView * customTextView;


- (UIView *)addTextView:(UITextView *)textView  font:(UIFont *)font rightArrowisHidden:(BOOL)isArrowHidden  bolderisHidden:(BOOL)isBolderHidden originStr:(NSString *)originStr;

- (UIView *)changeHeightWithcontentStr:(NSString *)contentStr andTextView:(UITextView *)textView withSize:(CGFloat)size;

- (UIView *)changeUnEditableHeightWithcontentStr:(NSString *)contentStr andTextView:(UITextView *)textView withSize:(CGFloat)size;

@end
