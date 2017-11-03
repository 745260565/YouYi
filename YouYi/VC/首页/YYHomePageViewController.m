//
//  YYHomePageViewController.m
//  YouYi
//
//  Created by chenghao on 2017/10/26.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "YYHomePageViewController.h"
#import "YYInvestmentTableViewCell.h"
#import "MJRefresh.h"

@interface YYHomePageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *contentTableView;
@property(nonatomic) BOOL isNotice;//是否有公告
@end

@implementation YYHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"优易理财管家"];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initUI{
    self.headerView.layer.zPosition = 1;
    self.contentTableView = [[UITableView alloc] init];
    self.contentTableView.showsHorizontalScrollIndicator = NO;
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    [self.contentView addSubview:self.contentTableView];
    [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    UIView *contentTableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, LengthInIP6(240+240+80+(self.isNotice?20:0)-64))];
    contentTableHeaderView.backgroundColor = [UIColor grayColor];
    self.contentTableView.tableHeaderView = contentTableHeaderView;
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"personalCenterTableViewCell";
    YYInvestmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[YYInvestmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell refreshData:nil];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 145;
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
