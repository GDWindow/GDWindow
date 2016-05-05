//
//  GDWindow.h
//  demo
//
//  Created by pg on 16/4/18.
//  Copyright © 2016年 pg. All rights reserved.
//

#import <UIKit/UIKit.h>



/************************
  ＊＊＊＊＊ GDWindow 1.0 ＊＊＊＊＊
 
   GDWindow 使用步骤：
 
 1. 在AppDelegate 文件中导入GDWindow.h  如: #import "GDWindow/GDWindow.h"
 
 2. 替换掉默认的Window  如: self.window = [GDWindow SharedGDWindow];
 
 3. 设置选择的效果样式 如: 在全局APP中获取GDWindow唯一对象设置属性，只需要调用 SharedGDWindow 类方法。
 
 
 **************************/



//定义圈圈的样式
typedef enum{
    GDTypeDefault         = 0,  //默认
    GDTypeGradually       = 1,  //中心渐变
    GDTypeLightDizzy      = 2,  //光晕渐变
    GDTypeBubble          = 3,  //气泡效果
}GDType;


//定义显示动画的样式
typedef enum {
    GDShowAnimationTypeEnlarge        = 0,  //放大 (默认)
    GDShowAnimationTypeMoveUpward     = 1,  //上升
}GDShowAnimationType;



@interface GDWindow : UIWindow
//共享单列构造函数
+ (instancetype)SharedGDWindow;

//设置绘制的方式 (由于过度绘制会极大的消耗系统性能，建议设置此属性：YES 单击屏幕时才触发绘制效果)
@property (nonatomic,assign) BOOL isOptimizeDraw;

//关闭绘制效果 (默认开启：NO)
@property (nonatomic,assign) BOOL closeDrawUpEffect;

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

//设置圈圈的样式 ：默认样式：GDTypeDefault
@property (nonatomic,assign) GDType GDType;

//设置圈圈的动画样式 :默认样式：GDShowAnimationTypeEnlarge
@property (nonatomic,assign)GDShowAnimationType GDShowAnimationType;



@end
