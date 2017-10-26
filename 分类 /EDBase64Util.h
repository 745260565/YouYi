//
//  EDBase64Util.h
//  eDrive
//
//  Created by harbin6666 on 15/5/11.
//  Copyright (c) 2015年 carbit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64Addition)
+(NSString *)stringFromBase64String:(NSString *)base64String;
-(NSString *)base64String;
@end

@interface NSData (Base64Addition)
+(NSData *)dataWithBase64String:(NSString *)base64String;
-(NSString *)base64String;
@end

@interface Base64Codec : NSObject
+(NSData *)dataFromBase64String:(NSString *)base64String;
+(NSString *)base64StringFromData:(NSData *)data;
@end
