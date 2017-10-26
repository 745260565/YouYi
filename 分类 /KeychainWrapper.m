//
//  KeychainWrapper.m
//  eDrive
//
//  Created by harbin6666 on 15/9/2.
//  Copyright (c) 2015年 carbit. All rights reserved.
//

#import "KeychainWrapper.h"
//static const UInt8 kKeychainItemIdentifier[]    = "com.apple.dts.KeychainUI\0";
static  NSString *vendorid=nil;
NSString *const VendroId4Keychain=@"vendorId";
@interface KeychainWrapper()

@end
@implementation KeychainWrapper

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,
            service, (__bridge
                      id)kSecAttrService,
            service, (__bridge id)kSecAttrAccount,
            (__bridge id)kSecAttrAccessibleAfterFirstUnlock,(__bridge id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        
    }else{
        //Add new object to search dictionary(Attention:the data format)
        [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id)kSecValueData];
        //Add item to keychain with the search dictionary
         SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
    }
    
}

+ (id)load:(NSString *)service {
    if (vendorid) {
        return vendorid;
    }
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (ret) {
        vendorid=ret;
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)deleteItem:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}  


@end
