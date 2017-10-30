//
//  UIColor+extend.h
//  iZhongShang
//
//  Created by William Chen on 14-8-12.
//  Copyright (c) 2014年 whty. All rights reserved.

#import <Foundation/Foundation.h>

@interface UIColor(extend)

// 将十六进制的颜色值转为objective-c的颜色
+ (UIColor *)getColor:(NSString *) hexColor;
+ (UIColor *)getColor:(NSString *) hexColor alpha:(CGFloat)alpha;

@end
