//
//  YYBaseModel.h
//  YouYi
//
//  Created by chenghao on 2017/11/2.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface YYBaseModel : JSONModel

@end

@interface YYBaseResponse: YYBaseModel
@property(nonatomic, strong) NSString *status;
@property(nonatomic, strong) NSString *msg;
@end
