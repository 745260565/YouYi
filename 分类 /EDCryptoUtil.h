//
//  EDCryptoUtil.h
//  eDrive
//
//  Created by harbin6666 on 15/5/12.
//  Copyright (c) 2015年 carbit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDCryptoUtil : NSObject
/**
 *  加密传输数据
 *
 *  @param data NSData类型入参
 *
 *  @return 如果data==nil，则返回nil，否则返回结果
 */
+(NSString*)encodeData:(NSData*)data;
/**
 *  加密传输数据
 *
 *  @param string NSString类型入参
 *
 *  @return 如果string==nil，则返回nil，否则返回结果
 */
+(NSString*)encodeString:(NSString*)string;

/**
 *  加密传输数据
 *
 *  @param jsonDic NSDictionary类型入参
 *  @param error   解析是否错误
 *
 *  @return 如果jsonDic==nil，则返回nil，否则返回结果
 */
+(NSString*)encodeDictionary:(NSDictionary*)jsonDic;
/**
 *  加密传输数据
 *
 *  @param jsonDic NSDictionary类型入参
 *  @param error   解析是否错误
 *
 *  @return 如果jsonDic==nil，则返回nil，否则返回NSData类型结果
 */
+(NSData*)encodeDic:(NSDictionary*)jsonDic;
@end
