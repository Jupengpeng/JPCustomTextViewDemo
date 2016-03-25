//
//  UIView+util.m
//  BY_iphone
//
//  Created by 鞠鹏 on 15/11/3.
//  Copyright © 2015年 wuxinyi. All rights reserved.
//

#import "UIView+util.h"
#import <objc/runtime.h>

@implementation UIView (util)

static char  NSObject_key_toolImageView = 'a';
static char  NSObject_key_customTextView = 'b';


//@dynamic toolImageView;
- (UIImageView *)toolImageView{
    return  objc_getAssociatedObject(self,&NSObject_key_toolImageView);
}

- (UIPlaceHolderTextView *)customTextView{
    return  objc_getAssociatedObject(self,&NSObject_key_customTextView);

}


- (void)setToolImageView:(UIImageView *)toolImageView{
    
  objc_setAssociatedObject(self, &NSObject_key_toolImageView, toolImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setCustomTextView:(UIPlaceHolderTextView *)customTextView{
    objc_setAssociatedObject(self, &NSObject_key_customTextView, customTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//将textView加上
- (UIView *)addTextView:(UIPlaceHolderTextView *)textView  font:(UIFont *)font rightArrowisHidden:(BOOL)isArrowHidden  bolderisHidden:(BOOL)isBolderHidden originStr:(NSString *)originStr{
    if (!textView) {
        self.customTextView = [[UIPlaceHolderTextView alloc]init];
        textView = self.customTextView;
    }else{
        self.customTextView = textView;
    }
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    textView.frame = CGRectMake(0, 0, width- 20, 25);
    textView.font = font;
    textView.showsVerticalScrollIndicator = NO;
    textView.backgroundColor = [UIColor clearColor];
    textView.text = originStr;
    
    
    [textView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];//也可以监听contentSize属性
    
    self.clipsToBounds = YES;
    
    if (isBolderHidden == NO) {
        self.layer.borderWidth = 1.0f ;
        self.layer.borderColor = [UIColorFromRGB(0xd4e2e9) CGColor];
    }
    
    
    if (isArrowHidden == NO) {
        self.toolImageView=  [[UIImageView alloc]initWithFrame:CGRectMake(width - 20, height/2 - 5, 10, 10)];
        self.toolImageView.image = [UIImage imageNamed:@"btn_down.png"];
        [self addSubview:self.toolImageView];
        
    }
    [self addSubview:textView];
    //设置显示在中间
    CGFloat topCorrect = ([textView bounds].size.height - [textView contentSize].height * [textView zoomScale])/2.0;
    
    topCorrect = ( topCorrect > 0.0 ? 0.0 : topCorrect );
    
    textView.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};

    return self;
}

- (UIView *)changeHeightWithcontentStr:(NSString *)contentStr andTextView:(UIPlaceHolderTextView *)textView withSize:(CGFloat)size{
    
    if (!textView) {
        textView = self.customTextView;
    }
    
    CGFloat height = [self textHeightFromTextString:contentStr width:self.frame.size.width -20 fontSize:size] + 7;
    CGFloat originY = self.center.y;

//    self.frame = CGRectMake(self.frame.origin.x, originY - height/2.0, self.frame.size.width, height);
        self.frame = CGRectMake(self.frame.origin.x,0, self.frame.size.width, height);
    CGFloat subOriginY = self.frame.size.height/2.0;
    //设置图片的尺寸
    self.toolImageView.frame = CGRectMake(self.toolImageView.frame.origin.x, subOriginY - 5, 10, 10);
    
    textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width, height);
    textView.text  = contentStr;

    
    //设置显示在中间
    CGFloat topCorrect = ([textView bounds].size.height - [textView contentSize].height * [textView zoomScale])/2.0;
    
    topCorrect = ( topCorrect > 0.0 ? 0.0 : topCorrect );
    
    textView.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
    
    
    return self;
}

- (UIView *)changeUnEditableHeightWithcontentStr:(NSString *)contentStr andTextView:(UIPlaceHolderTextView *)textView withSize:(CGFloat)size{
    textView.editable = NO;
    
    CGFloat height = [self textHeightFromTextString:contentStr width:self.frame.size.width -20 fontSize:size] + 7;
    CGFloat originY = self.center.y;

    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
//    CGFloat subOriginY = self.frame.size.height/2.0;
//    //设置图片的尺寸
//    self.toolImageView.frame = CGRectMake(self.toolImageView.frame.origin.x, subOriginY - 5, 10, 10);
    
    textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width, height);
    textView.text  = contentStr;
    
    
    
    //设置显示在中间
    CGFloat topCorrect = ([textView bounds].size.height - [textView contentSize].height * [textView zoomScale])/2.0;
    
    topCorrect = ( topCorrect > 0.0 ? 0.0 : topCorrect );
    
    textView.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
    
    
    return self;
}

#pragma mark - KVO
// contentSize变化时，显示的文本动态居中
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context

{

    UIPlaceHolderTextView *tv = object;
    // Center vertical alignment
    
    CGFloat topCorrect = ([tv bounds].size.height - [tv contentSize].height * [tv zoomScale])/2.0;
    
    topCorrect = ( topCorrect > 0.0 ? 0.0 : topCorrect );
    
    tv.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
    
    
}


//动态 计算行高
//根据字符串的实际内容的多少 在固定的宽度和字体的大小，动态的计算出实际的高度
- (CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size{

    //iOS7之后
    /*
     第一个参数: 预设空间 宽度固定  高度预设 一个最大值
     第二个参数: 行间距 如果超出范围是否截断
     第三个参数: 属性字典 可以设置字体大小
     */
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    //返回计算出的行高
    return rect.size.height;

}


@end
