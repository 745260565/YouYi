//
//  YYDeviceInfo.m
//  YouYi
//
//  Created by chenghao on 2017/10/26.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "YYDeviceInfo.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "sys/utsname.h"
#import "KeychainWrapper.h"
#import "AFNetworkReachabilityManager.h"

@implementation YYDeviceInfo

-(NSString *)device_id{
    NSString *uuid = [KeychainWrapper load:VendroId4Keychain];
    return uuid;
    
}

-(NSString*)resolution{
    CGSize size=[UIScreen mainScreen].currentMode.size;
    return [NSString stringWithFormat:@"%.0fx%.0f",size.height,size.width];
}

-(NSString*)os{
    return [UIDevice currentDevice].systemVersion;
}


-(NSString*)network{
    return [self networkingStatesFromStatebar];
}

- (NSString *)networkingStatesFromStatebar {
    
    if (![AFNetworkReachabilityManager sharedManager].reachable) {
        return @"notReachable";
    }
    else if([AFNetworkReachabilityManager sharedManager].isReachableViaWWAN){
        
        CTTelephonyNetworkInfo *info=[CTTelephonyNetworkInfo new];
        
        NSString *mConnectType = [[NSString alloc] initWithFormat:@"%@",info.currentRadioAccessTechnology];
        if ([mConnectType isEqualToString:@"CTRadioAccessTechnologyGPRS"] || [mConnectType isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
            return @"2G";
        }
        else if ([mConnectType isEqualToString:@"CTRadioAccessTechnologyLTE"]) {
            return @"4G";
        }
        else {
            return @"3G";
        }
    }
    else if([AFNetworkReachabilityManager sharedManager].isReachableViaWiFi){
        return @"wifi";
    }
    return @"notReachable";
}


-(NSString*)model{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceString;
}
@end
