//
//  YYClientInfo.h
//  YouYi
//
//  Created by chenghao on 2017/10/26.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {
 "client": {
 "package_name": "com.carbi.easydrive" # 客户端包名称
 "version_name": "v2.0.1",             # 客户端版本名称
 "version_code": "32",                 # 客户端版本编号
 }
 }
 */

@interface YYClientInfo : NSObject
@property(nonatomic,strong)NSString *package_name;
@property(nonatomic,strong)NSString *version_name;
@property(nonatomic,strong)NSString *version_code;
@end
