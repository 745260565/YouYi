//
//  YYSingUpViewController.m
//  YouYi
//
//  Created by chenghao on 2017/10/30.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "YYSingUpViewController.h"
#import "YYGetVerificationCodeButton.h"

@interface YYSingUpViewController ()
@property (nonatomic, strong) UITextField *phoneNumberTextField;
@property (nonatomic, strong) UITextField *verificationCodeTextField;
@property (nonatomic, strong) YYGetVerificationCodeButton *getVerficationCodeButton;
@property (nonatomic, strong) UIButton *userAgreementButton;
@end

@implementation YYSingUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initUI{
    UIView *signUpView = [[UIView alloc] init];
    signUpView.backgroundColor = WhiteColor;
    [self.contentView addSubview:signUpView];
    [signUpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(BaseInterval);
        make.height.mas_equalTo(CellHeight*2);
    }];
    
    UILabel *phoneNumberLabel = [[UILabel alloc] init];
    phoneNumberLabel.text = @"手机号";
    phoneNumberLabel.font = [UIFont systemFontOfSize:MFont];
    [signUpView addSubview:phoneNumberLabel];
    [phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BaseInterval);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(CellHeight);
        make.width.mas_equalTo(MFont*4);
    }];
    
    UILabel *verificationCodeLabel = [[UILabel alloc] init];
    verificationCodeLabel.text = @"验证码";
    verificationCodeLabel.font = [UIFont systemFontOfSize:MFont];
    [signUpView addSubview:verificationCodeLabel];
    [verificationCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BaseInterval);
        make.top.mas_equalTo(CellHeight);
        make.height.mas_equalTo(CellHeight);
        make.width.mas_equalTo(MFont*4);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = BaseBackgroundColor;
    [signUpView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BaseInterval);
        make.right.mas_equalTo(-BaseInterval);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    self.phoneNumberTextField = [[UITextField alloc] init];
    self.phoneNumberTextField.placeholder = @"请输入手机号";
    self.phoneNumberTextField.font = [UIFont systemFontOfSize:MFont];
    self.phoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [signUpView addSubview:self.phoneNumberTextField];
    [self.phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneNumberLabel.mas_right).mas_offset(LengthInIP6(30));
        make.right.mas_equalTo(-BaseInterval);
        make.height.mas_equalTo(CellHeight);
        make.top.mas_equalTo(0);
    }];
    
    self.getVerficationCodeButton = [[YYGetVerificationCodeButton alloc] init];
    [self.getVerficationCodeButton addTarget:self action:@selector(sendVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
    [signUpView addSubview:self.getVerficationCodeButton];
    [self.getVerficationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-BaseInterval);
        make.centerY.mas_equalTo(verificationCodeLabel.mas_centerY);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(MFont*6);
    }];
    
    self.verificationCodeTextField = [[UITextField alloc] init];
    self.verificationCodeTextField.placeholder = @"请输入验证码";
    self.verificationCodeTextField.font = [UIFont systemFontOfSize:MFont];
    [signUpView addSubview:self.verificationCodeTextField];
    [self.verificationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(verificationCodeLabel.mas_right).mas_offset(LengthInIP6(30));
        make.right.mas_equalTo(self.getVerficationCodeButton.mas_left).mas_offset(-BaseInterval);
        make.height.mas_equalTo(CellHeight);
        make.top.mas_equalTo(CellHeight);
    }];
    
    self.userAgreementButton = [[UIButton alloc] init];
    [self.userAgreementButton setImage:ICONFONT(@"\U0000e606", 20, MainColor) forState:UIControlStateNormal];
    [self.userAgreementButton setImage:ICONFONT(@"\U0000e63b", 20, MainColor) forState:UIControlStateSelected];
    [self.contentView addSubview:self.userAgreementButton];
    [self.userAgreementButton addTarget:self action:@selector(userAgreementAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.userAgreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BaseInterval);
        make.top.mas_equalTo(signUpView.mas_bottom).mas_offset(BaseInterval);
    }];
    
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.text = @"我已经阅读并同意";
    messageLabel.font = [UIFont systemFontOfSize:SFont];
    [self.contentView addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userAgreementButton.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self.userAgreementButton.mas_centerY);
    }];
    
    UIButton *userAgreementWordButton = [[UIButton alloc] init];
    [userAgreementWordButton setTitle:@"《优易网用户使用协议》" forState:UIControlStateNormal];
    [userAgreementWordButton setTitleColor:[UIColor getColor:@"3ab8fc"] forState:UIControlStateNormal];
    userAgreementWordButton.titleLabel.font = [UIFont systemFontOfSize:SFont];
    [self.contentView addSubview:userAgreementWordButton];
    [userAgreementWordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(messageLabel.mas_right);
        make.centerY.mas_equalTo(self.userAgreementButton.mas_centerY);
    }];
    
}

- (void)sendVerificationCode:(UIButton*)sender{
    
}

- (void)userAgreementAction:(UIButton*)sender{
    sender.selected = !sender.selected;
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
