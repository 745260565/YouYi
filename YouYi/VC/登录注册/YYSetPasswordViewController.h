//
//  YYSetPasswordViewController.h
//  YouYi
//
//  Created by chenghao on 2017/10/31.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "YYBaseViewController.h"

typedef NS_OPTIONS(NSInteger, SetPasswordType) {
    SetPasswordTypeSignUp = 0,             //注册设置密码
    SetPasswordTypeRestPassword,          //忘记密码/修改密码
};

@interface YYSetPasswordViewController : YYBaseViewController

- (instancetype)initWithType:(SetPasswordType)setPasswordType;

@end
