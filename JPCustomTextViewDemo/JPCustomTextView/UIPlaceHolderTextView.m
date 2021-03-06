//
//  UIPlaceHolderTextView.m
//  BY_iphone
//
//  Created by 鞠鹏 on 15/11/5.
//  Copyright © 2015年 wuxinyi. All rights reserved.
//

#import "UIPlaceHolderTextView.h"

@implementation UIPlaceHolderTextView

@synthesize placeHolderLabel;

@synthesize placeholder;

@synthesize placeholderColor;



//- (void)dealloc
//
//{
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    
//    [placeHolderLabel release]; placeHolderLabel = nil;
//    
//    [placeholderColor release]; placeholderColor = nil;
//    
//    [placeholder release]; placeholder = nil;
//    
//    [super dealloc];
//    
//}



- (void)awakeFromNib

{
    
    [super awakeFromNib];
    
    [self setPlaceholder:@""];
    
    [self setPlaceholderColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
}



- (id)initWithFrame:(CGRect)frame

{
    
    if( (self = [super initWithFrame:frame]) )
        
    {
        
        [self setPlaceholder:@""];
        
        [self setPlaceholderColor:[[UIColor blackColor]colorWithAlphaComponent:0.2]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    
    return self;
    
    
}



- (void)textChanged:(NSNotification *)notification

{
    
    if([[self placeholder] length] == 0)
        
    {
        return;
    }
    
    
    
    if([[self text] length] == 0)
        
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    else
        
    {
        [[self viewWithTag:999] setAlpha:0];
    }
}



- (void)setText:(NSString *)text {
    
    [super setText:text];
    
    [self textChanged:nil];
    
}



- (void)drawRect:(CGRect)rect

{
    
    if( [[self placeholder] length] > 0 )
        
    {
        if ( placeHolderLabel == nil )
            
        {
            placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,0)];
            placeHolderLabel.lineBreakMode = UILineBreakModeWordWrap;
            placeHolderLabel.numberOfLines = 0;
            placeHolderLabel.font = self.font;
            placeHolderLabel.backgroundColor = [UIColor clearColor];
            placeHolderLabel.textColor = self.placeholderColor;
            placeHolderLabel.alpha = 0;
            placeHolderLabel.tag = 999;
            [self addSubview:placeHolderLabel];
        }
        placeHolderLabel.text = self.placeholder;
        [placeHolderLabel sizeToFit];
        [self sendSubviewToBack:placeHolderLabel];
    }
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    [super drawRect:rect];
}



- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}
@end





