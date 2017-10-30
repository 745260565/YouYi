//
//  YYSignInViewController.m
//  YouYi
//
//  Created by chenghao on 2017/10/30.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "YYSignInViewController.h"
#import "HTHorizontalSelectionList.h"

@interface YYSignInViewController ()<HTHorizontalSelectionListDelegate,HTHorizontalSelectionListDataSource,UIScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) HTHorizontalSelectionList *signInTitle;
@property (nonatomic, strong) NSArray *signInTitleArray;
@property (nonatomic, strong) UIScrollView *contentScrollerView;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, assign) BOOL secureState;
@property (nonatomic, strong) UIButton *verificationCodeButton;
@end

@implementation YYSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.signInTitleArray = @[@"账号密码登录",@"手机号快捷登录"];
    self.secureState = YES;
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initUI{
    self.signInTitle = [[HTHorizontalSelectionList alloc] init];
    self.signInTitle.dataSource = self;
    self.signInTitle.delegate = self;
    self.signInTitle.selectionIndicatorColor = MainColor;
    self.signInTitle.backgroundColor = WhiteColor;
    self.signInTitle.selectionTitleColor = MainColor;
    self.signInTitle.nomalTitleColor = BlackColor;
    [self.contentView addSubview:self.signInTitle];
    [self.signInTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth*2);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    //主scrollView
    self.contentScrollerView = [[UIScrollView alloc] init];
    self.contentScrollerView.scrollEnabled = YES;
    self.contentScrollerView.bounces = NO;
    self.contentScrollerView.pagingEnabled = YES;
    self.contentScrollerView.showsHorizontalScrollIndicator = NO;
    self.contentScrollerView.delegate = self;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTap)];
    [self.contentScrollerView addGestureRecognizer:tapGes];
    [self.contentView addSubview:self.contentScrollerView];
    [self.contentScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.signInTitle.mas_bottom);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    self.contentScrollerView.contentSize = CGSizeMake(ScreenWidth*2, ScreenHeight-64-44);
    
    //登录框
    UIView *signInView = [[UIView alloc] init];
    signInView.backgroundColor = WhiteColor;
    [self.contentScrollerView addSubview:signInView];
    [signInView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth*2);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(44*2);
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor getColor:@"eeeeee"];
    [signInView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(ScreenWidth-20);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor getColor:@"eeeeee"];
    [signInView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ScreenWidth + 10);
        make.width.mas_equalTo(ScreenWidth-20);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *accountLabel = [[UILabel alloc] init];
    accountLabel.text = @"账户";
    accountLabel.font = [UIFont systemFontOfSize:LengthInIP6(14)];
    [signInView addSubview:accountLabel];
    [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(-22);
    }];
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.text = @"密码";
    passwordLabel.font = [UIFont systemFontOfSize:LengthInIP6(14)];
    [signInView addSubview:passwordLabel];
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(22);
    }];
    
    UILabel *phoneNumberLabel = [[UILabel alloc] init];
    phoneNumberLabel.text = @"手机号";
    phoneNumberLabel.font = [UIFont systemFontOfSize:LengthInIP6(14)];
    [signInView addSubview:phoneNumberLabel];
    [phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ScreenWidth + 10);
        make.centerY.mas_equalTo(-22);
    }];
    
    UILabel *verificationCodeLabel = [[UILabel alloc] init];
    verificationCodeLabel.text = @"验证码";
    verificationCodeLabel.font = [UIFont systemFontOfSize:LengthInIP6(14)];
    [signInView addSubview:verificationCodeLabel];
    [verificationCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ScreenWidth + 10);
        make.centerY.mas_equalTo(22);
    }];
    
    //输入框
    UITextField *accountTextField = [[UITextField alloc] init];
    accountTextField.placeholder = @"请输入优易网帐号";
    accountTextField.font = [UIFont systemFontOfSize:LengthInIP6(14)];
    accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    accountTextField.tag = 1;
    [signInView addSubview:accountTextField];
    [accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(accountLabel.mas_right).mas_offset(LengthInIP6(30));
        make.right.mas_equalTo(phoneNumberLabel.mas_left).mas_offset(-10);
        make.centerY.mas_equalTo(accountLabel.mas_centerY);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *secureStateButton = [[UIButton alloc] init];
    [secureStateButton setImage:ICONFONT(@"\U0000e607", 24, BlackColor) forState:UIControlStateNormal];
    [secureStateButton setImage:ICONFONT(@"\U0000e603", 24, BlackColor) forState:UIControlStateSelected];
    [secureStateButton addTarget:self action:@selector(secureStateTarget:) forControlEvents:UIControlEventTouchUpInside];
    [signInView addSubview:secureStateButton];
    [secureStateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(verificationCodeLabel.mas_left).mas_offset(-10);
        make.width.height.mas_equalTo(44);
        make.centerY.mas_equalTo(passwordLabel.mas_centerY);
    }];
    
    self.passwordTextField = [[UITextField alloc] init];
    self.passwordTextField.placeholder = @"请输入密码";
    self.passwordTextField.font = [UIFont systemFontOfSize:LengthInIP6(14)];
    self.passwordTextField.secureTextEntry = self.secureState;
    self.passwordTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.passwordTextField.tag = 2;
    [signInView addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(passwordLabel.mas_right).mas_offset(LengthInIP6(30));
        make.right.mas_equalTo(secureStateButton.mas_left).mas_offset(-10);
        make.centerY.mas_equalTo(passwordLabel.mas_centerY);
        make.height.mas_equalTo(44);
    }];
    
    UITextField *phoneNumberTextField = [[UITextField alloc] init];
    phoneNumberTextField.font = [UIFont systemFontOfSize:LengthInIP6(14)];
    phoneNumberTextField.placeholder = @"请输入手机号";
    phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumberTextField.tag = 3;
    phoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [signInView addSubview:phoneNumberTextField];
    [phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneNumberLabel.mas_right).mas_offset(LengthInIP6(30));
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(phoneNumberLabel.mas_centerY);
        make.height.mas_equalTo(44);
    }];
    
    self.verificationCodeButton = [[UIButton alloc] init];
    [self.verificationCodeButton addTarget:self action:@selector(sendVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.verificationCodeButton setTitleColor:MainColor forState:UIControlStateNormal];
    self.verificationCodeButton.titleLabel.font = [UIFont systemFontOfSize:LengthInIP6(14)];
    self.verificationCodeButton.layer.masksToBounds = YES;
    self.verificationCodeButton.clipsToBounds = YES;
    self.verificationCodeButton.layer.cornerRadius = 3;
    self.verificationCodeButton.layer.borderWidth = 1;
    self.verificationCodeButton.layer.borderColor = MainColor.CGColor;
    [self.verificationCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [signInView addSubview:self.verificationCodeButton];
    [self.verificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-LengthInIP6(5));
        make.centerY.mas_equalTo(verificationCodeLabel.mas_centerY);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(LengthInIP6(14)*6);
    }];
    
    UITextField *verificationCodeTextField = [[UITextField alloc] init];
    verificationCodeTextField.font = [UIFont systemFontOfSize:LengthInIP6(14)];
    verificationCodeTextField.placeholder = @"请输入验证码";
    verificationCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    verificationCodeTextField.tag = 4;
    [signInView addSubview:verificationCodeTextField];
    [verificationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(verificationCodeLabel.mas_right).mas_offset(LengthInIP6(30));
        make.centerY.mas_equalTo(verificationCodeLabel.mas_centerY);
        make.right.mas_equalTo(self.verificationCodeButton.mas_left).mas_equalTo(-LengthInIP6(10));
        make.height.mas_equalTo(44);
    }];
    
    //按钮
    UIButton *signinButton1 = [[UIButton alloc] init];
    [signinButton1 setTitleColor:MainColor forState:UIControlStateNormal];
    [signinButton1 setTitle:@"登录" forState:UIControlStateNormal];
    signinButton1.backgroundColor = MainColor;
    [signinButton1 setTitleColor:WhiteColor forState:UIControlStateNormal];
    [signinButton1 addTarget:self action:@selector(signInAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentScrollerView addSubview:signinButton1];
    [signinButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(ScreenWidth-20);
        make.top.mas_equalTo(signInView.mas_bottom).mas_offset(LengthInIP6(20));
        make.height.mas_equalTo(44);
    }];
    
    UIButton *signinButton2 = [[UIButton alloc] init];
    [signinButton2 setTitleColor:MainColor forState:UIControlStateNormal];
    [signinButton2 setTitle:@"登录" forState:UIControlStateNormal];
    signinButton2.backgroundColor = MainColor;
    [signinButton2 setTitleColor:WhiteColor forState:UIControlStateNormal];
    [signinButton2 addTarget:self action:@selector(signInAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentScrollerView addSubview:signinButton2];
    [signinButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ScreenWidth + 10);
        make.width.mas_equalTo(ScreenWidth-20);
        make.top.mas_equalTo(signInView.mas_bottom).mas_offset(LengthInIP6(20));
        make.height.mas_equalTo(44);
    }];
    
    UIButton *signUpButton1 = [[UIButton alloc] init];
    [signUpButton1 setTitle:@"10秒免费注册" forState:UIControlStateNormal];
    signUpButton1.titleLabel.font = [UIFont systemFontOfSize:LengthInIP6(12)];
    [signUpButton1 setTitleColor:BlackColor forState:UIControlStateNormal];
    [signUpButton1 addTarget:self action:@selector(signUpAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentScrollerView addSubview:signUpButton1];
    [signUpButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(signinButton1.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(signinButton1.mas_left);
        make.width.mas_equalTo(LengthInIP6(12)*7);
        make.height.mas_equalTo(LengthInIP6(14));
    }];
    
    UIButton *signUpButton2 = [[UIButton alloc] init];
    [signUpButton2 setTitle:@"10秒免费注册" forState:UIControlStateNormal];
    signUpButton2.titleLabel.font = [UIFont systemFontOfSize:LengthInIP6(12)];
    [signUpButton2 setTitleColor:BlackColor forState:UIControlStateNormal];
    [signUpButton2 addTarget:self action:@selector(signUpAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentScrollerView addSubview:signUpButton2];
    [signUpButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(signinButton2.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(signinButton2.mas_left);
        make.width.mas_equalTo(LengthInIP6(12)*7);
        make.height.mas_equalTo(LengthInIP6(14));
    }];
    
    UIButton *forgetPasswordButton = [[UIButton alloc] init];
    [forgetPasswordButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetPasswordButton setTitleColor:BlackColor forState:UIControlStateNormal];
    forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:LengthInIP6(12)];
    [forgetPasswordButton addTarget:self action:@selector(forgetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentScrollerView addSubview:forgetPasswordButton];
    [forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(signinButton1.mas_right);
        make.top.mas_equalTo(signinButton1.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(LengthInIP6(12)*6);
        make.height.mas_equalTo(LengthInIP6(14));
    }];
}

- (void)scrollViewTap{
    [self.view endEditing:YES];
}

- (void)secureStateTarget:(UIButton*)sender{
    sender.selected = !sender.selected;
    self.passwordTextField.secureTextEntry = !sender.selected;
}

- (void)sendVerificationCode:(UIButton*)sender{
    
}

- (void)signInAction:(UIButton*)sender{
    
}

- (void)signUpAction:(UIButton*)sender{
    
}

- (void)forgetPasswordAction:(UIButton*)sender{
    
}

#pragma mark - UITextFieldDelegate


#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return self.signInTitleArray.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    return self.signInTitleArray[index];
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    [UIView animateWithDuration:0.2 animations:^{
        [self.contentScrollerView setContentOffset:CGPointMake(ScreenWidth*index, 0)];
    }];
//    [self.contentScrollerView setContentOffset:CGPointMake(ScreenWidth*index, 0)];
    // update the view for the corresponding index
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x>ScreenWidth/2) {
        [self.signInTitle selectIndex:1];
    }else{
        [self.signInTitle selectIndex:0];
    }
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
