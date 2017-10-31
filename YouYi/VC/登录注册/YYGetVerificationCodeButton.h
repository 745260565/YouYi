//
//  YYGetVerificationCodeButton.h
//  YouYi
//
//  Created by chenghao on 2017/10/31.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, VerificationCodeType) {
    VerificationCodeTypeSignUp = 0,              //注册
    VerificationCodeTypeForgetPassWord,          //忘记密码/修改密码
    VerificationCodeTypeMessageSignIn,           //短信登录
    VerificationCodeTypeResetPhoneNumber,        //修改手机号
    VerificationCodeTypeBindingNewPhoneNumber,   //新手机号绑定
    VerificationCodeTypeBindingAliPayOrBandCard, //绑定支付宝或银行卡
    VerificationCodeTypeWithdrawDeposit,         //提现
};

@interface YYGetVerificationCodeButton : UIButton

@end
