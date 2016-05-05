//
//  GDDrawUpView.h
//  demo
//
//  Created by pg on 16/4/20.
//  Copyright © 2016年 pg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDDrawUpView : UIView
//记录点击的位置
@property (nonatomic,assign) CGPoint touchPoint;
//设置执行动画的时间
@property (nonatomic,assign) CGFloat showAnimationTimer;
//设置圈圈起始的大小
@property (nonatomic,assign) CGFloat circleStartSize;
//设置圈圈动画后的大小
@property (nonatomic,assign) CGFloat circleOverSize;
//设置圈圈的颜色 ：默认为橙色
@property (nonatomic,strong) UIColor *circleColor;
//设置圈圈的颜色样式(第一个颜色为底层颜色)：默认单层效果
@property (nonatomic,strong) NSArray <UIColor*> *circleColors;
//设置圈圈的样式
@property (nonatomic,assign) NSInteger GDType;
//设置圈圈动画样式
@property (nonatomic,assign) NSInteger GDShowAnimationType;
@end
