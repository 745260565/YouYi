//
//  YYSetPasswordViewController.m
//  YouYi
//
//  Created by chenghao on 2017/10/31.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "YYSetPasswordViewController.h"
#import "YYActionButton.h"

@interface YYSetPasswordViewController ()<UITextFieldDelegate>
@property(nonatomic, assign) SetPasswordType contentType;
@property(nonatomic, strong) UITextField *passwordTextField1;
@property(nonatomic, strong) UITextField *passwordTextField2;
@property(nonatomic, strong) YYActionButton *completeButton;
@end

@implementation YYSetPasswordViewController

- (instancetype)initWithType:(SetPasswordType)setPasswordType{
    self = [super init];
    if (self) {
        self.contentType = setPasswordType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.contentType?@"修改密码":@"设置密码";
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initUI{
    UIView *setPasswordView = [[UIView alloc] init];
    setPasswordView.backgroundColor = WhiteColor;
    [self.contentView addSubview:setPasswordView];
    [setPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(BaseInterval);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(CellHeight*2);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = BaseBackgroundColor;
    [setPasswordView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BaseInterval);
        make.right.mas_equalTo(-BaseInterval);
        make.height.mas_equalTo(1);
        make.centerY.mas_equalTo(0);
    }];
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.text = self.contentType?@"新密码":@"密码";
    passwordLabel.font = [UIFont systemFontOfSize:MFont];
    [setPasswordView addSubview:passwordLabel];
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BaseInterval);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(CellHeight);
    }];
    
    UILabel *verifyPasswordLabel = [[UILabel alloc] init];
    verifyPasswordLabel.text = @"重复密码";
    verifyPasswordLabel.font = [UIFont systemFontOfSize:MFont];
    [setPasswordView addSubview:verifyPasswordLabel];
    [verifyPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BaseInterval);
        make.top.mas_equalTo(CellHeight);
        make.height.mas_equalTo(CellHeight);
    }];
    
    UIButton *secureStateButton1 = [[UIButton alloc] init];
    secureStateButton1.tag = 1;
    [secureStateButton1 setImage:ICONFONT(@"\U0000e607", 24, BlackColor) forState:UIControlStateNormal];//正常闭眼，选中开眼
    [secureStateButton1 setImage:ICONFONT(@"\U0000e603", 24, BlackColor) forState:UIControlStateSelected];
    [secureStateButton1 addTarget:self action:@selector(secureStateChange:) forControlEvents:UIControlEventTouchUpInside];
    [setPasswordView addSubview:secureStateButton1];
    [secureStateButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-BaseInterval);
        make.centerY.mas_equalTo(-CellHeight/2);
    }];
    
    UIButton *secureStateButton2 = [[UIButton alloc] init];
    secureStateButton2.tag = 2;
    [secureStateButton2 setImage:ICONFONT(@"\U0000e607", 24, BlackColor) forState:UIControlStateNormal];//正常闭眼，选中开眼
    [secureStateButton2 setImage:ICONFONT(@"\U0000e603", 24, BlackColor) forState:UIControlStateSelected];
    [secureStateButton2 addTarget:self action:@selector(secureStateChange:) forControlEvents:UIControlEventTouchUpInside];
    [setPasswordView addSubview:secureStateButton2];
    [secureStateButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-BaseInterval);
        make.centerY.mas_equalTo(CellHeight/2);
    }];
    
    self.passwordTextField1 = [[UITextField alloc] init];
    self.passwordTextField1.placeholder = @"6-25位密码，包含字母和数字";
    self.passwordTextField1.font = [UIFont systemFontOfSize:MFont];
    self.passwordTextField1.secureTextEntry = YES;
    self.passwordTextField1.delegate = self;
    [setPasswordView addSubview:self.passwordTextField1];
    [self.passwordTextField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.right.mas_equalTo(-50);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(CellHeight);
    }];
    
    self.passwordTextField2 = [[UITextField alloc] init];
    self.passwordTextField2.placeholder = @"重复密码";
    self.passwordTextField2.font = [UIFont systemFontOfSize:MFont];
    self.passwordTextField2.secureTextEntry = YES;
    self.passwordTextField2.delegate = self;
    [setPasswordView addSubview:self.passwordTextField2];
    [self.passwordTextField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.right.mas_equalTo(-50);
        make.top.mas_equalTo(CellHeight);
        make.height.mas_equalTo(CellHeight);
    }];
    
    self.completeButton = [[YYActionButton alloc] init];
    [self.completeButton setTitle:self.contentType?@"确认修改":@"完成" forState:UIControlStateNormal];
    [self.completeButton addTarget:self action:@selector(completeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.completeButton];
    [self.completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BaseInterval);
        make.right.mas_equalTo(-BaseInterval);
        make.top.mas_equalTo(setPasswordView.mas_bottom).mas_offset(LengthInIP6(30));
        make.height.mas_equalTo(CellHeight);
    }];
}

- (void)secureStateChange:(UIButton*)sender{
    sender.selected = !sender.selected;
    if (sender.tag == 1) {
        self.passwordTextField1.secureTextEntry = !sender.selected;
    }else{
        self.passwordTextField2.secureTextEntry = !sender.selected;
    }
}

- (void)completeAction:(UIButton*)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)reloadTextFieldStatus{
    if (self.passwordTextField1.text.length>0 && self.passwordTextField2.text.length>0) {
        self.completeButton.enabled = YES;
    }else{
        self.completeButton.enabled = NO;
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
