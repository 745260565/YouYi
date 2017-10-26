//
//  UIImage+Color.m
//  eDrive
//
//  Created by liuqiaoyi on 16/1/27.
//  Copyright © 2016年 carbit. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGSize imageSize = CGSizeMake(50, 50);
    CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)imageWithScale:(CGFloat)scale {

    CGFloat scaledWidth = self.size.width * scale;
    CGFloat scaledHeight = self.size.height * scale;
    
    UIGraphicsBeginImageContext(CGSizeMake(scaledWidth, scaledHeight));
    [self drawInRect:CGRectMake(0, 0, scaledWidth, scaledHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
