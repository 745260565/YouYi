//
//  UIColor+extend
//  iZhongShang
//
//  Created by William Chen on 14-8-12.
//  Copyright (c) 2014年 whty. All rights reserved.
//

#import "UIColor+extend.h"

@implementation UIColor(extend)

+ (UIColor *)getColor:(NSString *) hexColor
{
    @synchronized(self)
    {
        if ([hexColor length] < 6) return [UIColor blackColor];
        if ([hexColor hasPrefix:@"#"]) hexColor = [hexColor substringFromIndex:1];
        if ([hexColor length] < 6) return [UIColor blackColor];
        unsigned int redInt_, greenInt_, blueInt_;
        NSRange rangeNSRange_;
        rangeNSRange_.length = 2;
        
        // 取红色的值
        rangeNSRange_.location = 0;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&redInt_];
        
        // 取绿色的值
        rangeNSRange_.location = 2;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&greenInt_];
        
        // 取蓝色的值
        rangeNSRange_.location = 4;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&blueInt_];
        
        return [UIColor colorWithRed:(float)(redInt_/255.0f) green:(float)(greenInt_/255.0f) blue:(float)(blueInt_/255.0f) alpha:1.0f];
    }
	
}

+ (UIColor *)getColor:(NSString *) hexColor alpha:(CGFloat)alpha
{
    @synchronized(self)
    {
        if ([hexColor length] < 6) return [UIColor blackColor];
        if ([hexColor hasPrefix:@"#"]) hexColor = [hexColor substringFromIndex:1];
        if ([hexColor length] < 6) return [UIColor blackColor];
        unsigned int redInt_, greenInt_, blueInt_;
        NSRange rangeNSRange_;
        rangeNSRange_.length = 2;
        
        // 取红色的值
        rangeNSRange_.location = 0;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&redInt_];
        
        // 取绿色的值
        rangeNSRange_.location = 2;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&greenInt_];
        
        // 取蓝色的值
        rangeNSRange_.location = 4;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&blueInt_];
        
        return [UIColor colorWithRed:(float)(redInt_/255.0f) green:(float)(greenInt_/255.0f) blue:(float)(blueInt_/255.0f) alpha:alpha];
    }
	
}

@end
