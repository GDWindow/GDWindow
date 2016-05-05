//
//  GDDrawUpView.m
//  demo
//
//  Created by pg on 16/4/20.
//  Copyright © 2016年 pg. All rights reserved.
//

#import "GDDrawUpView.h"
#import "GDShowView.h"

@interface GDDrawUpView()

@end

@implementation GDDrawUpView

- (instancetype)init{
    if (self == [super init]) {
        //设置默认属性
        self.showAnimationTimer = 1.5;
        self.circleStartSize = 10;
        self.circleOverSize = 150;
        self.circleColor = [UIColor orangeColor];
        self.GDType = 0;
        self.GDShowAnimationType = 0;
    }
    return self;
}

//开始绘制图案
- (void)startShowDrawUp{
    GDShowView *view = [[GDShowView alloc]init];
    view.GDType = self.GDType;
    view.touchPoint = self.touchPoint;
    //判断是否设置了颜色
    if (self.circleColors) {
        view.circleColors = self.circleColors;
    }else if(self.circleColor){
        view.circleColor = self.circleColor;
    }
    [self addSubview:view];
    view.frame = CGRectMake(self.touchPoint.x,self.touchPoint.y,self.circleStartSize,self.circleStartSize);
    //显示动画
    [self showAnimationWithView:view WithSize:self.circleOverSize];
}

//显示动画
- (void)showAnimationWithView:(UIView*)view WithSize:(CGFloat)viewOverSize{
    if (self.GDShowAnimationType == 0) {//放大样式
        [UIView animateWithDuration:self.showAnimationTimer animations:^{
            view.alpha = 0.0f;
            view.bounds = CGRectMake(0,0,viewOverSize,viewOverSize);
        }completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }else if (self.GDShowAnimationType == 1){//上升样式
        [UIView animateWithDuration:self.showAnimationTimer animations:^{
            view.alpha = 0.0f;
            view.bounds = CGRectMake(0, 0,viewOverSize,viewOverSize);
            CGFloat windowWidth = [[UIScreen mainScreen]bounds].size.width;
            view.frame = CGRectMake(arc4random_uniform(windowWidth),-view.frame.size.height,viewOverSize,viewOverSize);
        }completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
}


//接收传递的点击位置
- (void)setTouchPoint:(CGPoint)touchPoint{
    _touchPoint = touchPoint;
    [self startShowDrawUp];
}

//设置单层颜色
- (void)setCircleColor:(UIColor *)circleColor{
    _circleColor = circleColor;
    if (self.circleColors.count) {
        self.circleColors = nil;
    }
}

@end
