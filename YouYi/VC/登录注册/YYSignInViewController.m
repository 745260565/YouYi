//
//  YYSignInViewController.m
//  YouYi
//
//  Created by chenghao on 2017/10/30.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "YYSignInViewController.h"
#import "HTHorizontalSelectionList.h"
#import "YYSingUpViewController.h"
#import "YYForgetPasswordViewController.h"
#import "YYGetVerificationCodeButton.h"
#import "YYActionButton.h"

@interface YYSignInViewController ()<HTHorizontalSelectionListDelegate,HTHorizontalSelectionListDataSource,UIScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) HTHorizontalSelectionList *signInTitle;
@property (nonatomic, strong) NSArray *signInTitleArray;
@property (nonatomic, strong) UIScrollView *contentScrollerView;
@property (nonatomic, strong) UITextField *accountTextField;//用户名
@property (nonatomic, strong) UITextField *passwordTextField;//密码
@property (nonatomic, strong) UITextField *phoneNumberTextField;//手机号
@property (nonatomic, strong) UITextField *verificationCodeTextField;//验诈码

@property (nonatomic, assign) BOOL secureState;
@property (nonatomic, strong) YYGetVerificationCodeButton *verificationCodeButton;
@property (nonatomic, strong) YYActionButton *signinButton1;
@property (nonatomic, strong) YYActionButton *signinButton2;
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
        make.height.mas_equalTo(CellHeight);
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
    
    self.contentScrollerView.contentSize = CGSizeMake(ScreenWidth*2, ScreenHeight-64-CellHeight);
    
    //登录框
    UIView *signInView = [[UIView alloc] init];
    signInView.backgroundColor = WhiteColor;
    [self.contentScrollerView addSubview:signInView];
    [signInView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth*2);
        make.top.mas_equalTo(BaseInterval);
        make.height.mas_equalTo(CellHeight*2);
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = BaseBackgroundColor;
    [signInView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BaseInterval);
        make.width.mas_equalTo(ScreenWidth-BaseInterval*2);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = BaseBackgroundColor;
    [signInView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ScreenWidth + BaseInterval);
        make.width.mas_equalTo(ScreenWidth-BaseInterval*2);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *accountLabel = [[UILabel alloc] init];
    accountLabel.text = @"账户";
    accountLabel.font = [UIFont systemFontOfSize:MFont];
    [signInView addSubview:accountLabel];
    [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BaseInterval);
        make.centerY.mas_equalTo(-22);
    }];
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.text = @"密码";
    passwordLabel.font = [UIFont systemFontOfSize:MFont];
    [signInView addSubview:passwordLabel];
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BaseInterval);
        make.centerY.mas_equalTo(22);
    }];
    
    UILabel *phoneNumberLabel = [[UILabel alloc] init];
    phoneNumberLabel.text = @"手机号";
    phoneNumberLabel.font = [UIFont systemFontOfSize:MFont];
    [signInView addSubview:phoneNumberLabel];
    [phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ScreenWidth + BaseInterval);
        make.centerY.mas_equalTo(-22);
    }];
    
    UILabel *verificationCodeLabel = [[UILabel alloc] init];
    verificationCodeLabel.text = @"验证码";
    verificationCodeLabel.font = [UIFont systemFontOfSize:MFont];
    [signInView addSubview:verificationCodeLabel];
    [verificationCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ScreenWidth + BaseInterval);
        make.centerY.mas_equalTo(22);
    }];
    
    //输入框
    self.accountTextField = [[UITextField alloc] init];
    self.accountTextField.placeholder = @"请输入优易网帐号";
    self.accountTextField.font = [UIFont systemFontOfSize:MFont];
    self.accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.accountTextField.tag = 1;
    self.accountTextField.delegate = self;
    [signInView addSubview:self.accountTextField];
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(accountLabel.mas_right).mas_offset(LengthInIP6(30));
        make.right.mas_equalTo(phoneNumberLabel.mas_left).mas_offset(-BaseInterval);
        make.centerY.mas_equalTo(accountLabel.mas_centerY);
        make.height.mas_equalTo(CellHeight);
    }];
    
    UIButton *secureStateButton = [[UIButton alloc] init];
    [secureStateButton setImage:ICONFONT(@"\U0000e607", 24, BlackColor) forState:UIControlStateNormal];
    [secureStateButton setImage:ICONFONT(@"\U0000e603", 24, BlackColor) forState:UIControlStateSelected];
    [secureStateButton addTarget:self action:@selector(secureStateTarget:) forControlEvents:UIControlEventTouchUpInside];
    [signInView addSubview:secureStateButton];
    [secureStateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(verificationCodeLabel.mas_left).mas_offset(-BaseInterval);
        make.width.height.mas_equalTo(CellHeight);
        make.centerY.mas_equalTo(passwordLabel.mas_centerY);
    }];
    
    self.passwordTextField = [[UITextField alloc] init];
    self.passwordTextField.placeholder = @"请输入密码";
    self.passwordTextField.font = [UIFont systemFontOfSize:MFont];
    self.passwordTextField.secureTextEntry = self.secureState;
    self.passwordTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.passwordTextField.tag = 2;
    self.passwordTextField.delegate = self;
    [signInView addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(passwordLabel.mas_right).mas_offset(LengthInIP6(30));
        make.right.mas_equalTo(secureStateButton.mas_left).mas_offset(-BaseInterval);
        make.centerY.mas_equalTo(passwordLabel.mas_centerY);
        make.height.mas_equalTo(CellHeight);
    }];
    
    self.phoneNumberTextField = [[UITextField alloc] init];
    self.phoneNumberTextField.font = [UIFont systemFontOfSize:MFont];
    self.phoneNumberTextField.placeholder = @"请输入手机号";
    self.phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumberTextField.tag = 3;
    self.phoneNumberTextField.delegate = self;
    self.phoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [signInView addSubview:self.phoneNumberTextField];
    [self.phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneNumberLabel.mas_right).mas_offset(LengthInIP6(30));
        make.right.mas_equalTo(-BaseInterval);
        make.centerY.mas_equalTo(phoneNumberLabel.mas_centerY);
        make.height.mas_equalTo(CellHeight);
    }];
    
    self.verificationCodeButton = [[YYGetVerificationCodeButton alloc] init];
    [self.verificationCodeButton addTarget:self action:@selector(sendVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
    [signInView addSubview:self.verificationCodeButton];
    [self.verificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-BaseInterval);
        make.centerY.mas_equalTo(verificationCodeLabel.mas_centerY);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(MFont*6);
    }];
    
    self.verificationCodeTextField = [[UITextField alloc] init];
    self.verificationCodeTextField.font = [UIFont systemFontOfSize:MFont];
    self.verificationCodeTextField.placeholder = @"请输入验证码";
    self.verificationCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.verificationCodeTextField.tag = 4;
    self.verificationCodeTextField.delegate = self;
    [signInView addSubview:self.verificationCodeTextField];
    [self.verificationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(verificationCodeLabel.mas_right).mas_offset(LengthInIP6(30));
        make.centerY.mas_equalTo(verificationCodeLabel.mas_centerY);
        make.right.mas_equalTo(self.verificationCodeButton.mas_left).mas_equalTo(-BaseInterval);
        make.height.mas_equalTo(CellHeight);
    }];
    
    //按钮
    self.signinButton1 = [[YYActionButton alloc] init];
    [self.signinButton1 setTitle:@"登录" forState:UIControlStateNormal];
    [self.signinButton1 addTarget:self action:@selector(signInAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentScrollerView addSubview:self.signinButton1];
    [self.signinButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BaseInterval);
        make.width.mas_equalTo(ScreenWidth-BaseInterval*2);
        make.top.mas_equalTo(signInView.mas_bottom).mas_offset(LengthInIP6(20));
        make.height.mas_equalTo(CellHeight);
    }];
    
    self.signinButton2 = [[YYActionButton alloc] init];
    [self.signinButton2 setTitle:@"登录" forState:UIControlStateNormal];
    [self.signinButton2 addTarget:self action:@selector(signInAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentScrollerView addSubview:self.signinButton2];
    [self.signinButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ScreenWidth + BaseInterval);
        make.width.mas_equalTo(ScreenWidth-BaseInterval*2);
        make.top.mas_equalTo(signInView.mas_bottom).mas_offset(LengthInIP6(20));
        make.height.mas_equalTo(CellHeight);
    }];
    
    UIButton *signUpButton1 = [[UIButton alloc] init];
    [signUpButton1 setTitle:@"10秒免费注册" forState:UIControlStateNormal];
    signUpButton1.titleLabel.font = [UIFont systemFontOfSize:SFont];
    [signUpButton1 setTitleColor:BlackColor forState:UIControlStateNormal];
    [signUpButton1 addTarget:self action:@selector(signUpAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentScrollerView addSubview:signUpButton1];
    [signUpButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.signinButton1.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.signinButton1.mas_left);
        make.width.mas_equalTo(SFont*7);
        make.height.mas_equalTo(MFont);
    }];
    
    UIButton *signUpButton2 = [[UIButton alloc] init];
    [signUpButton2 setTitle:@"10秒免费注册" forState:UIControlStateNormal];
    signUpButton2.titleLabel.font = [UIFont systemFontOfSize:SFont];
    [signUpButton2 setTitleColor:BlackColor forState:UIControlStateNormal];
    [signUpButton2 addTarget:self action:@selector(signUpAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentScrollerView addSubview:signUpButton2];
    [signUpButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.signinButton2.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.signinButton2.mas_left);
        make.width.mas_equalTo(SFont*7);
        make.height.mas_equalTo(MFont);
    }];
    
    UIButton *forgetPasswordButton = [[UIButton alloc] init];
    [forgetPasswordButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetPasswordButton setTitleColor:BlackColor forState:UIControlStateNormal];
    forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:SFont];
    [forgetPasswordButton addTarget:self action:@selector(forgetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentScrollerView addSubview:forgetPasswordButton];
    [forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.signinButton1.mas_right);
        make.top.mas_equalTo(self.signinButton1.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(SFont*6);
        make.height.mas_equalTo(MFont);
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
    NSLog(@"456");
}

- (void)signInAction:(UIButton*)sender{
    
}

- (void)signUpAction:(UIButton*)sender{
    YYSingUpViewController *signUpVC = [[YYSingUpViewController alloc] init];
    [self.navigationController pushViewController:signUpVC animated:YES];
}

- (void)forgetPasswordAction:(UIButton*)sender{
    YYForgetPasswordViewController *forgetPasswordVC = [[YYForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetPasswordVC animated:YES];
}

- (void)reloadTextFieldStatus{
    if (self.accountTextField.text.length>0 && self.passwordTextField.text.length>0) {
        self.signinButton1.enabled = YES;
    }else{
        self.signinButton1.enabled = NO;
    }
    if (self.phoneNumberTextField.text.length>0 && self.verificationCodeTextField.text.length>0) {
        self.signinButton2.enabled = YES;
    }else{
        self.signinButton2.enabled = NO;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reloadTextFieldStatus];
    });
    return YES;
}

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
