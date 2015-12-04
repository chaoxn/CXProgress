//
//  CXProgress.m
//  CXProgressViewDemo
//
//  Created by fizz on 15/12/2.
//  Copyright © 2015年 chaox. All rights reserved.
//

#import "CXProgress.h"

#define PERFECT 0.618
#define BASICTYPE 10

@interface CXProgress()

@end

@implementation CXProgress

+ (CXProgress *)shareInstance
{
    static dispatch_once_t once = 0;
    static CXProgress *cxProgress;
    
    dispatch_once(&once, ^{ cxProgress = [[CXProgress alloc] init]; });
    
    return cxProgress;
}

- (instancetype)initWithFrame:(CGRect)frame type:(CXProgressType )type
{
    if (self = [super initWithFrame:frame]) {
        
        switch (type) {
            case CXProgressTypeFullPoint:
                [self beginPointAnimation:YES];
                break;
            case CXProgressTypeFullTurn:
                [self beiginSimpleAnimation:YES];
                break;
            case CXProgressTypeFullCatch:
                [self beginCatchAnimation:YES];
                break;
            case CXProgressTypeBasicCatch:
                [self beginCatchAnimation:NO];
                break;
            case CXProgressTypeBasicPoint:
                [self beginPointAnimation:NO];
                break;
            case CXProgressTypeBasicTurn:
                [self beiginSimpleAnimation:NO];
                break;
            default:
                break;
        }
    }
    return self;
}

- (void)beginPointAnimation: (BOOL)isFull
{
    UIView  *pointMaskView = ({
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
        view.center = CGPointMake(self.center.x, self.center.y);
        view;
    });
    
    [self addSubview:pointMaskView];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = CGRectMake(0, 0, pointMaskView.frame.size.width, pointMaskView.frame.size.height);
    replicatorLayer.position = CGPointMake(pointMaskView.frame.size.width/2, pointMaskView.frame.size.height/2);
    replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    [pointMaskView.layer addSublayer:replicatorLayer];
    
    CALayer *circle = [CALayer layer];
    circle.bounds = CGRectMake(0, 0, 8, 8);
    circle.position = CGPointMake(pointMaskView.frame.size.width/2, pointMaskView.frame.size.height/2 - 25);
    circle.cornerRadius = 4;
    circle.backgroundColor = isFull ?   [UIColor blackColor].CGColor : [UIColor whiteColor].CGColor;
    
    [replicatorLayer addSublayer:circle];
    
    replicatorLayer.instanceCount = 15;
    CGFloat angle = 2*M_PI / 15;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = [NSNumber numberWithFloat:1];
    scale.toValue = [NSNumber numberWithFloat:0.1];
    scale.duration = 1;
    scale.repeatCount = HUGE;
    [circle addAnimation:scale forKey:nil];
    
    replicatorLayer.instanceDelay =0.06666667;
    circle.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
}


- (void)beiginSimpleAnimation:(BOOL)isFull
{
    
    UIView *turnMaskView = ({
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
        view.backgroundColor = [UIColor clearColor];
        view.center = CGPointMake(self.center.x, self.center.y);
        view;
    });
    
    [self addSubview:turnMaskView];
    
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotate.duration = 1 + PERFECT;
    rotate.fromValue = 0;
    rotate.toValue =[NSNumber numberWithFloat:2 * M_PI];
    rotate.repeatCount = HUGE;
    [turnMaskView.layer addAnimation:rotate forKey:nil];
    
    CAShapeLayer *ovalShapeLayer = [CAShapeLayer layer];
    ovalShapeLayer.strokeColor = isFull ? [UIColor darkGrayColor].CGColor:[UIColor whiteColor].CGColor;
    ovalShapeLayer.fillColor = [UIColor clearColor].CGColor;
    ovalShapeLayer.lineWidth = 2;
    
    CGFloat ovalRadius = isFull ? turnMaskView.frame.size.height/2 * 0.55 : turnMaskView.frame.size.height/2 * (1-PERFECT);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(turnMaskView.frame.size.width/2-ovalRadius, turnMaskView.frame.size.width/2-ovalRadius, ovalRadius*2, ovalRadius*2)];
    
    ovalShapeLayer.path =path.CGPath;
    ovalShapeLayer.strokeEnd = 0.7;
    ovalShapeLayer.lineCap = kCALineCapRound; // 两头圆
    
    [turnMaskView.layer addSublayer:ovalShapeLayer];
}

- (void)beginCatchAnimation:(BOOL)isFull
{
    UIView *catchMaskView = ({
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
        view.backgroundColor = [UIColor clearColor];
        view.center = CGPointMake(self.center.x, self.center.y);
        view;
    });
    
    [self addSubview:catchMaskView];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 2;
    shapeLayer.strokeColor = isFull ? [UIColor darkGrayColor].CGColor:[UIColor whiteColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    CGFloat radius = isFull ? catchMaskView.frame.size.height/2 * 0.55 : catchMaskView.frame.size.height/2 * (1-PERFECT);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(catchMaskView.frame.size.width/2 - radius, catchMaskView.frame.size.width/2 - radius, radius*2, radius*2)];
    shapeLayer.path =path.CGPath;
    
    [catchMaskView.layer addSublayer:shapeLayer];
    
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnimation.fromValue = [NSNumber numberWithFloat:-1.25];
    startAnimation.toValue = [NSNumber numberWithFloat:1.0];
    
    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    endAnimation.toValue = [NSNumber numberWithFloat:1.0];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = 1 + PERFECT;
    groupAnimation.repeatCount = HUGE;
    groupAnimation.animations = @[startAnimation, endAnimation];
    
    [shapeLayer addAnimation:groupAnimation forKey:nil];
}

+ (void)showProgressIn:(UIView *)view type:(CXProgressType )type
{
    CXProgress *cxPV;
    
    if (type < BASICTYPE) {
        
        cxPV  = [[CXProgress alloc]initWithFrame:view.bounds type:type];
        cxPV.backgroundColor = [UIColor whiteColor];
    }else{
        
        cxPV = [[CXProgress alloc]initWithFrame:CGRectMake(0, 0, 130, 100) type:type];
        cxPV.layer.cornerRadius = 10;
        cxPV.backgroundColor = [UIColor blackColor];
        cxPV.alpha = PERFECT;
    }
    
    cxPV.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2);
    
    [view addSubview:cxPV];
}

+ (void)disMissProgress:(UIView *)superView
{
    for (UIView *view in superView.subviews) {
        
        if ([view isKindOfClass:[self class]]) {
            
            [UIView animateWithDuration:1 animations:^{
                
                view.alpha = 0;
            } completion:^(BOOL finished) {
                
                [view removeFromSuperview];
            }];
        }
    }
}

@end
