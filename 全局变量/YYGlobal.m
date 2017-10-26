//
//  YYGlobal.m
//  YouYi
//
//  Created by chenghao on 2017/10/26.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "YYGlobal.h"


@implementation YYGlobal

static YYGlobal *sharedObj = nil;
+(instancetype)sharedInstance{
    static dispatch_once_t onece;
    dispatch_once(&onece, ^{
        if (sharedObj==nil) {
            sharedObj=[[self alloc] init];
            sharedObj.deviceInfo=[YYDeviceInfo new];
            sharedObj.clientInfo=[YYClientInfo new];
        }
    });
    return sharedObj;
}



@end
