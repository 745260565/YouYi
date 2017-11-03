//
//  YYBaseModel.m
//  YouYi
//
//  Created by chenghao on 2017/11/2.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "YYBaseModel.h"

@implementation YYBaseModel
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"id":@"nid",@"description":@"descriptions"}];
}
@end

@implementation YYBaseResponse

@end
