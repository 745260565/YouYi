//
//  YYGlobal.h
//  YouYi
//
//  Created by chenghao on 2017/10/26.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYDeviceInfo.h"
#import "YYClientInfo.h"

@interface YYGlobal : NSObject
@property(nonatomic, strong) NSString *token;
@property(nonatomic, strong) NSString *userId;
@property(nonatomic, strong) YYDeviceInfo *deviceInfo;
@property(nonatomic, strong) YYClientInfo *clientInfo;

//加一个登录后的对象
@property(nonatomic, assign) BOOL showWelcomePage;
+(instancetype)sharedInstance;
@end
