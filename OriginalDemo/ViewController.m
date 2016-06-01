//
//  ViewController.m
//  OriginalDemo
//
//  Created by 曹杰 on 16/3/16.
//  Copyright © 2016年 曹杰. All rights reserved.
//
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *cycleView;
@property (strong, nonatomic)CAShapeLayer *ovalSShapeLayer;
@property (strong, nonatomic)CAShapeLayer *redShapeLayer;



@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self creatLayer];
}
-(void)creatLayer{

  //添加底层白色圆环
  self.ovalSShapeLayer = [[CAShapeLayer alloc]init];
  //圆环颜色
  self.ovalSShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
  //内部填充颜色
  self.ovalSShapeLayer.fillColor = [UIColor clearColor].CGColor;
  //线宽
  self.ovalSShapeLayer.lineWidth = 10;
  //半径
  CGFloat ovalRadius = self.cycleView.frame.size.height/2*0.8;
  self.ovalSShapeLayer.path =[UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.cycleView.frame.size.width/2 - ovalRadius, self.cycleView.frame.size.height/2 - ovalRadius, ovalRadius * 2, ovalRadius * 2)].CGPath;
  self.ovalSShapeLayer.lineCap = kCALineCapRound;
  [self.cycleView.layer addSublayer:self.ovalSShapeLayer];
  
  //添加填充圆环
  self.redShapeLayer = [[CAShapeLayer alloc]init];
  self.redShapeLayer.strokeColor = [UIColor greenColor].CGColor;
  self.redShapeLayer.fillColor = [UIColor clearColor].CGColor;
  self.redShapeLayer.lineWidth = 10;
  
  self.redShapeLayer.path =[UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.cycleView.frame.size.width/2 - ovalRadius, self.cycleView.frame.size.height/2 - ovalRadius, ovalRadius * 2, ovalRadius * 2)].CGPath;
    self.redShapeLayer.strokeStart = 0;
    self.redShapeLayer.strokeEnd = 0.35;
  
  [self.cycleView.layer addSublayer:self.redShapeLayer];
  //strokeStart为0时是从3点钟方向开始，故将其旋转270度从12点钟方向开始
  self.cycleView.transform = CGAffineTransformMakeRotation((M_PI * 2) / 4 * 3);
  
  
  
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (IBAction)didClickBtn:(id)sender {
  
  
  [self addAnimation];
}
-(void)addAnimation{
  
  CABasicAnimation * strokeEndAnimate = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
  strokeEndAnimate.fromValue = [NSNumber numberWithFloat:0.0];
  strokeEndAnimate.toValue = [NSNumber numberWithFloat:0.35];
  
  CAAnimationGroup *strokeAnimateGroup = [CAAnimationGroup animation];
  strokeAnimateGroup.duration = 1.5;
  strokeAnimateGroup.repeatCount = 1;
  strokeAnimateGroup.animations = @[strokeEndAnimate];
  
  [self.redShapeLayer addAnimation:strokeAnimateGroup forKey:nil];

  
}
@end
