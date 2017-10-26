//
//  KeychainWrapper.h
//  eDrive
//
//  Created by harbin6666 on 15/9/2.
//  Copyright (c) 2015年 carbit. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString *const VendroId4Keychain;
@interface KeychainWrapper : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteItem:(NSString *)service;

@end
