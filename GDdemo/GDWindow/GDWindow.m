//
//  GDWindow.m
//  demo
//
//  Created by pg on 16/4/18.
//  Copyright © 2016年 pg. All rights reserved.
//

#import "GDWindow.h"
#import "GDDrawUpView.h"
#import "AppDelegate.h"


@interface GDWindow()
//记录绘制位置
@property (nonatomic,assign) CGPoint touchPoint;

//防止系统调用两次绘制效果(相当于开关功能)
@property (nonatomic,assign) BOOL drawSwitch;

//判断是否第一次进入
@property (nonatomic,assign) BOOL isFirstDraw;

//绘制图像的view
@property (nonatomic,strong) GDDrawUpView *drawUpView;
@end
@implementation GDWindow

//单列构造函数
+ (instancetype)SharedGDWindow{
    static GDWindow *GDWin = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        GDWin = [[GDWindow alloc]init];
    });
    return GDWin;
}

//懒加载绘制view
- (GDDrawUpView *)drawUpView{
    if (_drawUpView == nil) {
        _drawUpView = [[GDDrawUpView alloc]init];
        _drawUpView.backgroundColor = [UIColor whiteColor];
        _drawUpView.frame = CGRectMake(0,0,1,1);
    }
    return _drawUpView;
}

//拦截用户的点击事件
- (void)sendEvent:(UIEvent *)event{
    [super sendEvent:event];
    
    //判断是否开启了绘制效果
    if (!self.closeDrawUpEffect) {
        //如果是单击触发
        if (self.isOptimizeDraw) {
            NSSet *set = event.allTouches;
            UITouch *touch = [set anyObject];
            if (touch.phase == UITouchPhaseBegan) {
                //获取点击的位置
                UITouch *touch = [[event allTouches]anyObject];
                CGPoint point = [touch locationInView:[[UIApplication sharedApplication]keyWindow]];
                if (point.x && point.y) {
                    self.touchPoint = point;
                }
            }
        }else{//allTouchs
            //获取点击的位置
            UITouch *touch = [[event allTouches]anyObject];
            CGPoint point = [touch locationInView:[[UIApplication sharedApplication]keyWindow]];
            if (point.x && point.y) {
                self.touchPoint = point;
            }
        }
    }
}



//接收点击位置，开始绘制图案
- (void)setTouchPoint:(CGPoint)touchPoint{
    _touchPoint = touchPoint;
    //调用绘制函数
    self.drawSwitch = !self.drawSwitch;
    if (self.drawSwitch || self.isOptimizeDraw) {
        //为防止覆盖在底层
        [self addSubview:self.drawUpView];
        self.drawUpView.touchPoint = touchPoint;
    }
}


//设置动画执行时间
- (void)setShowAnimationTimer:(CGFloat)showAnimationTimer{
    _showAnimationTimer = showAnimationTimer;
    self.drawUpView.showAnimationTimer = showAnimationTimer;
}
//设置圈圈起始的大小
- (void)setCircleStartSize:(CGFloat)circleStartSize{
    _circleStartSize = circleStartSize;
    self.drawUpView.circleStartSize = circleStartSize;
}
//设置圈圈动画后的大小
- (void)setCircleOverSize:(CGFloat)circleOverSize{
    _circleOverSize = circleOverSize;
    self.drawUpView.circleOverSize = circleOverSize;
}
//设置圈圈的颜色 ：默认为橙色
- (void)setCircleColor:(UIColor *)circleColor{
    _circleColor = circleColor;
    self.drawUpView.circleColor = circleColor;
}
//设置圈圈的颜色样式(第一个颜色为底层颜色)：默认单层效果
- (void)setCircleColors:(NSArray<UIColor *> *)circleColors{
    _circleColors = circleColors;
    self.drawUpView.circleColors = circleColors;
}
//设置圈圈样式
- (void)setGDType:(GDType)GDType{
    _GDType = GDType;
    self.drawUpView.GDType = GDType;
}
//设置圈圈的动画样式
- (void)setGDShowAnimationType:(GDShowAnimationType)GDShowAnimationType{
    _GDShowAnimationType = GDShowAnimationType;
    self.drawUpView.GDShowAnimationType = GDShowAnimationType;
}

@end




