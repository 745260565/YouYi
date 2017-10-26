//
//  NSMutableSet+safe.m
//  eDrive
//
//  Created by liuqiaoyi on 16/6/29.
//  Copyright © 2016年 carbit. All rights reserved.
//

#import "NSMutableSet+safe.h"

@implementation NSMutableSet (safe)

- (void)safeAddObject:(id)object
{
    if (object == nil) {
        return;
    } else {
        [self addObject:object];
    }
}

@end
