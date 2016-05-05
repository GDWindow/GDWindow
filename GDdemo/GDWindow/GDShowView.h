//
//  GDShowView.h
//  demo
//
//  Created by pg on 16/4/20.
//  Copyright © 2016年 pg. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface GDShowView : UIView
//设置圈圈的颜色
@property (nonatomic,strong) UIColor *circleColor;
//设置圈圈的颜色样式(第一个颜色为底层颜色)：默认单层效果
@property (nonatomic,strong) NSArray <UIColor*> *circleColors;
//设置圈圈的动画样式
@property (nonatomic,assign) NSInteger  GDType;
//记录点击的位置
@property (nonatomic,assign) CGPoint touchPoint;

@end
