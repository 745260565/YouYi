//
//  NSMutableSet+safe.h
//  eDrive
//
//  Created by liuqiaoyi on 16/6/29.
//  Copyright © 2016年 carbit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableSet (safe)

- (void)safeAddObject:(id)object;

@end
