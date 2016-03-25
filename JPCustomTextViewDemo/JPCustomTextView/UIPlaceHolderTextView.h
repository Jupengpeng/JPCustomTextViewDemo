//
//  UIPlaceHolderTextView.h
//  BY_iphone
//
//  Created by 鞠鹏 on 15/11/5.
//  Copyright © 2015年 wuxinyi. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIPlaceHolderTextView : UITextView {
    
    NSString *placeholder;
    
    UIColor *placeholderColor;
    
    
    
@private
    
    UILabel *placeHolderLabel;
    
}



@property(nonatomic, retain) UILabel *placeHolderLabel;

@property(nonatomic, retain) NSString *placeholder;

@property(nonatomic, retain) UIColor *placeholderColor;



-(void)textChanged:(NSNotification*)notification;



@end
