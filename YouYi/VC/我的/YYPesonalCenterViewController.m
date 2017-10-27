//
//  YYPesonalCenterViewController.m
//  YouYi
//
//  Created by chenghao on 2017/10/26.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "YYPesonalCenterViewController.h"

@interface YYPesonalCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation YYPesonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHeaderViewHeight:LengthInIP6(140)];
    [self initWithHeaderView];
    [self initWithTableView];
    // Do any additional setup after loading the view.
}

- (void)initWithHeaderView{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户中心顶部背景"]];
    [self.headerView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    UIImageView *offlinePersonalCenterImageView = [[UIImageView alloc] initWithImage:ICONFONT(@"\U0000e6a6", LengthInIP6(60), MainColor)];
    offlinePersonalCenterImageView.backgroundColor = WhiteColor;
    offlinePersonalCenterImageView.layer.cornerRadius = LengthInIP6(30);
//    offlinePersonalCenterImageView.layer.borderColor = [UIColor getColor:@"fedf32"].CGColor;
//    offlinePersonalCenterImageView.layer.borderWidth = LengthInIP6(2);
    offlinePersonalCenterImageView.clipsToBounds = YES;
    [self.headerView addSubview:offlinePersonalCenterImageView];
    [offlinePersonalCenterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LengthInIP6(15));
        make.bottom.mas_equalTo(-LengthInIP6(15));
    }];
    offlinePersonalCenterImageView.layer.zPosition = 1;
    
    UIButton *loginButton = [[UIButton alloc] init];
    [loginButton setImage:ICONFONT(@"\U0000e6a6", LengthInIP6(20), [UIColor getColor:@"fedf32"]) forState:UIControlStateNormal];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.headerView addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(offlinePersonalCenterImageView.mas_centerY);
        make.left.mas_equalTo(offlinePersonalCenterImageView.mas_right).mas_offset(LengthInIP6(30));
    }];
    
    UIButton *registerButton = [[UIButton alloc] init];
    [registerButton setImage:ICONFONT(@"\U0000e697", LengthInIP6(20), [UIColor getColor:@"fedf32"]) forState:UIControlStateNormal];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.headerView addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(offlinePersonalCenterImageView.mas_centerY);
        make.left.mas_equalTo(loginButton.mas_right).mas_offset(LengthInIP6(30));
    }];
}

- (void)initWithTableView{
    UITableView *personalCenterTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.contentView addSubview:personalCenterTableView];
    [personalCenterTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    personalCenterTableView.backgroundColor = [UIColor grayColor];
    personalCenterTableView.delegate = self;
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"personalCenterTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"123";
    return cell;
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
