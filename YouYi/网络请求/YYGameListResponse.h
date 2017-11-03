//
//  YYGameListResponse.h
//  YouYi
//
//  Created by chenghao on 2017/11/2.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "YYBaseModel.h"

@protocol NSString @end
@protocol YYGameListContext@end
@interface YYGameListContext:YYBaseModel
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *qi;
@property(nonatomic, strong) NSString *endtime;
@property(nonatomic, strong) NSString *list_img;
@property(nonatomic, strong) NSString *credit;
@property(nonatomic, strong) NSString *subtitle;
@property(nonatomic, strong) NSString *product_feture;
@property(nonatomic, strong) NSString *nid;
@property(nonatomic, strong) NSString *num;
@property(nonatomic, strong) NSString *close;
@property(nonatomic, strong) NSString *online;
@property(nonatomic, strong) NSString *p2p_year_yield;
@property(nonatomic, strong) NSString *p2p_nvestment_time;
@property(nonatomic, strong) NSString *timely_prize;
@property(nonatomic, strong) NSArray<NSString> *label;
@end

@interface YYGameListData:YYBaseModel
@property(nonatomic, strong) NSArray<YYGameListContext> *data_list;
@end

@interface YYGameListResponse : YYBaseResponse
@property (nonatomic,strong) YYGameListData *result;
@end

