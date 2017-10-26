//
//  UIImage+Circle.h
//  eDrive
//
//  Created by ch on 16/6/1.
//  Copyright © 2016年 carbit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Circle)
//根据指定图片的文件名获取一张贺型的图片对象,并加边框
//name 图片文件名
+ (UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  将指定的图片变圆
 *
 *  @param image       指定的图片
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 返回一张图片
 */
+ (UIImage *)circleImageWithImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 * 将一张图片变成指定的大小
 * @param image 原图片
 * @param size 指定的大小
 * @return 指定大小的图片
 */
+ (UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size;
/**
 *  将彩色图片变灰
 *
 *  @param anImage 原始图片
 *  @param type 灰度
 *
 *  @return
 */
+ (UIImage*)grayscale:(UIImage*)anImage type:(int)type;
/**
 *  将彩色图片变灰
 *
 *  @param sourceImage 原始图片
 *
 *  @return 返回一张图片
 */
+ (UIImage *)grayImage:(UIImage *)sourceImage;
@end
