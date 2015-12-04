//
//  CXProgress.h
//  CXProgressViewDemo
//
//  Created by fizz on 15/12/2.
//  Copyright © 2015年 chaox. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CXProgressType)
{
    CXProgressTypeFullPoint,
    CXProgressTypeFullTurn,
    CXProgressTypeFullCatch,
    CXProgressTypeBasicPoint = 10,
    CXProgressTypeBasicTurn,
    CXProgressTypeBasicCatch
};

@interface CXProgress : UIView

/**
 *  显示等待框
 *
 *  @param view 需要加载的视图
 *  @param type 加载视图类型
 */
+ (void)showProgressIn:(UIView *)view type:(CXProgressType )type;

/**
 *  消除等待框
 *
 *  @param superView 需要消除的等待框
 */
+ (void)disMissProgress: (UIView *)superView;

@end
