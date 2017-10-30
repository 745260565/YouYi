//
//  UIImage+Color.h
//  eDrive
//
//  Created by liuqiaoyi on 16/1/27.
//  Copyright © 2016年 carbit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)imageWithScale:(CGFloat)scale;

//创建纯色图片
+(UIImage *)createColorImg:(NSString *)hexColor alpha:(CGFloat)alpha;
+(UIImage *)createColorImg:(NSString *)hexColor;

@end
