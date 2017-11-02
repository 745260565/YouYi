//
//  YYForgetPasswordViewController.m
//  YouYi
//
//  Created by chenghao on 2017/11/1.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "YYForgetPasswordViewController.h"
#import "YYGetVerificationCodeButton.h"
#import "YYSetPasswordViewController.h"
#import "YYActionButton.h"

@interface YYForgetPasswordViewController ()<UITextFieldDelegate>
@property(nonatomic, strong) UITextField *phoneNumberTextField;
@property(nonatomic, strong) UITextField *verficationCodeTextField;
@property(nonatomic, strong) YYActionButton *affirmButton;
@end

@implementation YYForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    self.commandKeyboard = YES;
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initUI{
    UIView *forgetPasswordView = [[UIView alloc] init];
    forgetPasswordView.backgroundColor = WhiteColor;
    [self.contentView addSubview:forgetPasswordView];
    [forgetPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(BaseInterval);
        make.height.mas_equalTo(CellHeight*2);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = BaseBackgroundColor;
    [forgetPasswordView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BaseInterval);
        make.right.mas_equalTo(-BaseInterval);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *phoneNumberLabel = [[UILabel alloc] init];
    phoneNumberLabel.font = [UIFont systemFontOfSize:MFont];
    phoneNumberLabel.text = @"手机号";
    [forgetPasswordView addSubview:phoneNumberLabel];
    [phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BaseInterval);
        make.right.mas_equalTo(-BaseInterval);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(CellHeight);
    }];
    
    UILabel *verficationCodeLabel = [[UILabel alloc] init];
    verficationCodeLabel.font = [UIFont systemFontOfSize:MFont];
    verficationCodeLabel.text = @"验证码";
    [forgetPasswordView addSubview:verficationCodeLabel];
    [verficationCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BaseInterval);
        make.right.mas_equalTo(-BaseInterval);
        make.top.mas_equalTo(CellHeight);
        make.height.mas_equalTo(CellHeight);
    }];
    
    self.phoneNumberTextField = [[UITextField alloc] init];
    self.phoneNumberTextField.placeholder = @"请输入手机号";
    self.phoneNumberTextField.font = [UIFont systemFontOfSize:MFont];
    self.phoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumberTextField.delegate = self;
    [forgetPasswordView addSubview:self.phoneNumberTextField];
    [self.phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.right.mas_equalTo(-BaseInterval);
        make.centerY.mas_equalTo(phoneNumberLabel.mas_centerY);
        make.height.mas_equalTo(CellHeight);
    }];
    
    YYGetVerificationCodeButton *getVerificationCodeButton = [[YYGetVerificationCodeButton alloc] init];
    [getVerificationCodeButton addTarget:self action:@selector(sendVerficationCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [forgetPasswordView addSubview:getVerificationCodeButton];
    [getVerificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-BaseInterval);
        make.centerY.mas_equalTo(verficationCodeLabel.mas_centerY);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(MFont*6);
    }];
    
    self.verficationCodeTextField = [[UITextField alloc] init];
    self.verficationCodeTextField.placeholder = @"请输入验证码";
    self.verficationCodeTextField.font = [UIFont systemFontOfSize:MFont];
    self.verficationCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.verficationCodeTextField.delegate = self;
    [forgetPasswordView addSubview:self.verficationCodeTextField];
    [self.verficationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.right.mas_equalTo(getVerificationCodeButton.mas_left).mas_equalTo(-BaseInterval);
        make.centerY.mas_equalTo(verficationCodeLabel.mas_centerY);
        make.height.mas_equalTo(CellHeight);
    }];
    
    self.affirmButton = [[YYActionButton alloc] init];
    [self.affirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [self.affirmButton addTarget:self action:@selector(completeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.affirmButton];
    [self.affirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BaseInterval);
        make.right.mas_equalTo(-BaseInterval);
        make.top.mas_equalTo(forgetPasswordView.mas_bottom).mas_offset(LengthInIP6(30));
        make.height.mas_equalTo(CellHeight);
    }];
}

- (void)sendVerficationCodeAction{
    //发送难证码
}

- (void)completeAction:(UIButton*)sender{
    YYSetPasswordViewController *spVC = [[YYSetPasswordViewController alloc] initWithType:SetPasswordTypeRestPassword];
    [self.navigationController pushViewController:spVC animated:YES];
}

- (void)reloadTextFieldStatus{
    if (self.phoneNumberTextField.text.length>0 && self.verficationCodeTextField.text.length>0) {
        self.affirmButton.enabled = YES;
    }else{
        self.affirmButton.enabled = NO;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reloadTextFieldStatus];
    });
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
