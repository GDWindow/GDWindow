//
//  ViewController.m
//  GDdemo
//
//  Created by pg on 16/4/21.
//  Copyright © 2016年 pg. All rights reserved.
//

//
//  ViewController.m
//  demo
//
//  Created by pg on 16/4/18.
//  Copyright © 2016年 pg. All rights reserved.
//

#import "ViewController.h"
#import "GDWindow/GDWindow.h"

#define  timerValue(value) [NSString stringWithFormat:@"showTimer: %.1f/s",value]


@interface ViewController ()
@property (nonatomic,strong) GDWindow *win;
//调节显示时间控件
@property (weak, nonatomic) IBOutlet UISlider *timeSlider;
//显示当前时间字符串
@property (weak, nonatomic) IBOutlet UILabel *timerString;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置当前显示时间字符串
    CGFloat timerValue = 1.5;
    self.timerString.text = timerValue(timerValue);
    self.timeSlider.maximumValue = 10; //设置最大时间
    
    
    self.win = [GDWindow SharedGDWindow];
    self.win.showAnimationTimer = timerValue;  //设置动画执行时间
    self.win.circleStartSize = 10;   //设置开始动画圈圈的大小
    self.win.circleOverSize = 150;   //设置结束动画圈圈的大小
}


//默认效果
- (IBAction)defaultButton:(id)sender {
    self.win.GDType = GDTypeDefault;
}
//渐变效果
- (IBAction)graduallyButton:(UIButton*)sender {
    self.win.GDType = GDTypeGradually;
}
//光晕效果
- (IBAction)LightDizzy:(id)sender {
    self.win.GDType =  GDTypeLightDizzy;
}

//气泡效果
- (IBAction)bubble:(id)sender {
    self.win.GDType = GDTypeBubble;
}



//设置当前时间
- (IBAction)timeView:(UISlider*)sender {
    self.win.showAnimationTimer = [sender value];
    self.timerString.text = timerValue([sender value]);
}



//放大动画样式   :默认
- (IBAction)enlarge:(id)sender {
    self.win.GDShowAnimationType = GDShowAnimationTypeEnlarge;
}

//上升动画样式
- (IBAction)moveUpward:(id)sender {
    self.win.GDShowAnimationType = GDShowAnimationTypeMoveUpward;
}


//设置触发方式
- (IBAction)trigger:(UISegmentedControl*)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.win.isOptimizeDraw = NO;
    }else{
        self.win.isOptimizeDraw = YES;
    }
}





- (IBAction)start:(id)sender {
    NSLog(@"开始");
    self.win.closeDrawUpEffect = NO;
}


- (IBAction)stop:(id)sender {
    NSLog(@"关闭");
    self.win.closeDrawUpEffect = YES;
}

/****************************************** 颜色可以根据自己喜欢的色彩调制 *********************************************/

//自定义的颜色
- (IBAction)qianlv:(id)sender {//浅绿
    UIColor *color1 = [UIColor colorWithRed:117/255.0f green:202/255.0f blue:141/255.0f alpha:1.0];
    UIColor *color2 = [UIColor colorWithRed:107/255.0f green:212/255.0f blue:151/255.0f alpha:1.0];
    UIColor *color3 = [UIColor colorWithRed:109/255.0f green:202/255.0f blue:147/255.0f alpha:1.0];
    self.win.circleColors = @[color1,color2,color3];
}

- (IBAction)qianlan:(id)sender {//浅蓝
    UIColor *color1 = [UIColor colorWithRed:222/255.0f green:234/255.0f blue:221/255.0f alpha:1.0];
    UIColor *color2 = [UIColor colorWithRed:220/255.0f green:237/255.0f blue:230/255.0f alpha:1.0];
    UIColor *color3 = [UIColor colorWithRed:216/255.0f green:231/255.0f blue:223/255.0f alpha:1.0];
    self.win.circleColors = @[color1,color2,color3];
}

- (IBAction)qiancheng:(id)sender {//浅橙
    UIColor *color1 = [UIColor colorWithRed:255/255.0f green:223/255.0f blue:182/255.0f alpha:1.0];
    UIColor *color2 = [UIColor colorWithRed:251/255.0f green:211/255.0f blue:164/255.0f alpha:1.0];
    UIColor *color3 = [UIColor colorWithRed:246/255.0f green:201/255.0f blue:145/255.0f alpha:1.0];
    self.win.circleColors = @[color1,color2,color3];
}

- (IBAction)qianhui:(id)sender {//浅灰
    UIColor *color1 = [UIColor colorWithRed:205/255.0f green:205/255.0f blue:205/255.0f alpha:1.0];
    UIColor *color2 = [UIColor colorWithRed:187/255.0f green:187/255.0f blue:187/255.0f alpha:1.0];
    UIColor *color3 = [UIColor colorWithRed:173/255.0f green:173/255.0f blue:173/255.0f alpha:1.0];
    self.win.circleColors = @[color1,color2,color3];
}

- (IBAction)wuyanliuse:(id)sender {//五颜六色
    UIColor *color1 = [UIColor redColor];
    UIColor *color2 = [UIColor blueColor];
    UIColor *color3 = [UIColor orangeColor];
    UIColor *color4 = [UIColor brownColor];
    UIColor *color5 = [UIColor yellowColor];
    self.win.circleColors = @[color1,color2,color3,color4,color5];
}

- (IBAction)huang:(id)sender {//单黄
    self.win.circleColor = [UIColor  yellowColor];
}


- (IBAction)lv:(id)sender {//单绿
    self.win.circleColor = [UIColor  greenColor];
}

- (IBAction)lan:(id)sender {//单蓝
    self.win.circleColor = [UIColor  blueColor];
}

- (IBAction)pink:(id)sender {//粉红
    self.win.circleColor = [UIColor colorWithRed:244/255.0f green:135/255.0f blue:168/255.0f alpha:1.0];
}


@end


