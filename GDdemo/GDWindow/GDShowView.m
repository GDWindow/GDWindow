//
//  GDShowView.m
//  demo
//
//  Created by pg on 16/4/20.
//  Copyright © 2016年 pg. All rights reserved.
//

#import "GDShowView.h"



@implementation GDShowView

- (instancetype)init{
    if (self == [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//绘制圆型
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if (self.circleColors) {//如果是颜色数组
        //遍历颜色
        for (int i = 0; i < self.circleColors.count; i++) {
            UIColor *color = self.circleColors[i];
            //设置范围大小
            CGFloat rectW = rect.size.width - ((rect.size.width / (self.circleColors.count)) * i);
            CGFloat rectX = rect.origin.x + (i * (rect.size.width / self.circleColors.count) * 0.5);
            CGFloat rectY = rect.origin.y + (i * (rect.size.width / self.circleColors.count) * 0.5);
            CGRect rectValue =  CGRectMake(rectX,rectY,rectW,rectW);
            if (self.GDType == 0) {//默认效果
                [self drawCircleWithRect:rectValue Color:color alpha:0.4 + (i * 0.2)];
            }
        }
        if (self.GDType == 1 || self.GDType == 2){//渐变效果 光晕效果
            [self drawGraduallyCircleWithRect:rect WithColors:[self gradientColorArraySetUpMethod]];
        }else if (self.GDType == 3){//气泡效果
            [self drawBubbleCircleWithRect:rect WithColors:[self gradientColorArraySetUpMethod]];
        }
    }else if (self.circleColor) {//否则是单层颜色
        //画渐变圈圈  :后面的颜色设置结束颜色为白色
        NSArray *colorsArray = @[(__bridge id)self.circleColor.CGColor,(__bridge id)[UIColor whiteColor].CGColor];
        if (self.GDType == 0) {//默认效果
            [self drawCircleWithRect:rect Color:self.circleColor alpha:1.0];
        }else if (self.GDType == 1 || self.GDType == 2){// 渐变效果 光晕效果 气泡效果
            [self drawGraduallyCircleWithRect:rect WithColors:colorsArray];
        }else if (self.GDType == 3){//气泡效果
            [self drawBubbleCircleWithRect:rect WithColors:colorsArray];
        }
    }
}



//绘制默认圈圈效果
- (void)drawCircleWithRect:(CGRect)rect Color:(UIColor*)color alpha:(CGFloat)alpha{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context,rect);
    CGContextSetAlpha(context,alpha);
    [color set];
    CGContextFillPath(context);
}


//绘制渐变、光晕效果样式
- (void)drawGraduallyCircleWithRect:(CGRect)rect WithColors:(NSArray*)colorsArray{
    //获取图像上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //获取渐变工具
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    //设置渐变参数
    
    //计算绘制图像的X，Y
    CGFloat drawX = self.bounds.size.width * 0.5;
    CGFloat drawY = self.bounds.size.height * 0.5;
    //设置渐变圈的起始、结束的半径、渐变开始位置
    CGFloat startRadius = rect.size.width * 0.5;
    CGFloat endRadius  = 1;
    CGFloat locations[2];
    
    if(self.GDType == 1){//渐变效果
        locations[0] = 0.01;
        locations[1] = 0.99;
    }else if(self.GDType == 2){//光晕效果
        locations[0] = 0.99;
        locations[1] = 0.01;
    }
    
    /*
     1.ColorSpaceRef 颜色工具
     2.colorsArray： 颜色数组
     3.locations:  表示渐变的开始位置
     */
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpaceRef,(CFArrayRef)colorsArray,locations);
    /*
     参数：
     一 context
     二 gradient
     三 statCenter 起始中心点
     四 sartRadius 起始半径 指定为0  从圆心渐变  否则  中心位置不渐变
     五 endCenter  结束中心点（通常与起始专心点重合）
     六 endRadius  结束半径
     七 渐变填充方式
     */
    CGContextDrawRadialGradient(context,gradient,CGPointMake(drawX,drawY),startRadius, CGPointMake(drawX,drawY),endRadius, kCGGradientDrawsAfterEndLocation);
    
    //释放渐变工具对象
    CGColorSpaceRelease(colorSpaceRef);
    CGGradientRelease(gradient);
}



//绘制气泡效果
- (void)drawBubbleCircleWithRect:(CGRect)rect WithColors:(NSArray*)colorsArray{
    //获取图像上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //获取渐变工具
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    //计算绘制图像的X，Y
    CGFloat drawX = self.bounds.size.width * 0.5;
    CGFloat drawY = self.bounds.size.height * 0.5;
    //设置渐变圈的起始、结束的半径、渐变开始位置
    CGFloat startRadius = rect.size.width * 0.5;
    CGFloat endRadius  = 5;
    CGFloat locations1[2] = {0.01,0.99};
    
    //设置颜色
    UIColor *color1 = [[UIColor colorWithCGColor:(CGColorRef)colorsArray[0]] colorWithAlphaComponent:0.8];
    NSArray *colors = @[(__bridge id)color1.CGColor,(__bridge id)[UIColor whiteColor].CGColor];
    /*
     1.ColorSpaceRef 颜色工具
     2.colorsArray： 颜色数组
     3.locations:  表示渐变的开始位置
     */
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpaceRef,(CFArrayRef)colors,locations1);
    /*
     参数：
     一 context
     二 gradient
     三 statCenter 起始中心点
     四 sartRadius 起始半径 指定为0  从圆心渐变  否则  中心位置不渐变
     五 endCenter  结束中心点（通常与起始专心点重合）
     六 endRadius  结束半径
     七 渐变填充方式
     */
    CGContextDrawRadialGradient(context,gradient,CGPointMake(drawX,drawY),startRadius, CGPointMake(drawX,drawY),endRadius, kCGGradientDrawsAfterEndLocation);
    
    
    // 绘制光彩圆
    CGFloat aW = rect.size.width - 40;
    CGFloat aH = rect.size.width * 0.5;
    CGFloat aX = drawX - (aW * 0.5);
    CGFloat aY = drawY - (rect.size.height * 0.5) + 5;
    CGRect aRect = CGRectMake(aX, aY, aW, aH);
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 0.5);//设置颜色
    CGContextAddEllipseInRect(context, aRect); //椭圆
    CGContextDrawPath(context, kCGPathFill);// 绘制
    
    
    //绘制阴影圆
    CGFloat bH = rect.size.width * 0.3;
    CGFloat bX = drawX + bH * 0.3;
    CGFloat bY = drawY + (rect.size.height * 0.5 - bH);
    CGFloat blocations[2] = {0.01,0.99};
    
    //设置阴影颜色
    NSArray *BcolorsArray = @[(__bridge id)[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3].CGColor,(__bridge id)[UIColor clearColor].CGColor];
    
    CGGradientRef Bgradient = CGGradientCreateWithColors(colorSpaceRef,(CFArrayRef)BcolorsArray,blocations);
    CGContextDrawRadialGradient(context,Bgradient,CGPointMake(bX,bY),0.01, CGPointMake(bX,bY),bH, kCGGradientDrawsAfterEndLocation);

    //绘制白心圆
    CGFloat whiteX = drawX - (rect.size.width * 0.75);
    CGFloat whiteY = drawY - (rect.size.height * 0.5) * 0.4;
    CGFloat whiteW = (rect.size.width * 0.5) * 0.5;
    CGFloat whiteH = (rect.size.width * 0.5) * 0.3;
    CGRect whiteRect = CGRectMake(whiteX, whiteY, whiteW, whiteH);
    CGContextRotateCTM(context,-(50 * M_PI/180)); //旋转
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextAddEllipseInRect(context, whiteRect); //椭圆
    CGContextDrawPath(context, kCGPathFill);
    
    
    //释放渐变工具对象
    CGColorSpaceRelease(colorSpaceRef);
    CGGradientRelease(gradient);
    CGGradientRelease(Bgradient);
}







//将UIColor转换为RGB值
- (NSArray *) changeUIColorToRGB:(UIColor *)color{
    if (color == nil) {
        return nil;
    }
    //获得RGB值描述
    NSString *RGBValue = [NSString stringWithFormat:@"%@",color];
    NSMutableArray *rgbArray = (NSMutableArray*)[RGBValue componentsSeparatedByString:@" "];
    [rgbArray removeObjectAtIndex:0];
    return rgbArray;
}



//处理颜色数组
- (NSArray *)gradientColorArraySetUpMethod{
    //存储颜色的数组
    NSMutableArray *colorsArray = [[NSMutableArray alloc]init];
    //由于多层颜色会导致没有渐变效果：这里采用平均颜色作为主要颜色
    CGFloat  R  = 0, G = 0, B = 0;
    for (int i = 0; i < self.circleColors.count; i++) {
        NSArray *rgbArray = [self changeUIColorToRGB:self.circleColors[i]];
        R += [rgbArray[0] floatValue];
        G += [rgbArray[1] floatValue];
        B += [rgbArray[2] floatValue];
    }
    CGFloat sizeCount = self.circleColors.count;
    R = R/sizeCount; G = G/sizeCount; B = B/sizeCount;
    [colorsArray addObject:(__bridge id)[UIColor colorWithRed:R green:G blue:B alpha:1.0].CGColor];
    //添加白色背景
    [colorsArray addObject:(__bridge id)[UIColor whiteColor].CGColor];
    return (NSArray *)colorsArray;
}

@end
