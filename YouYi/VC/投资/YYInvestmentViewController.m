//
//  YYInvestmentViewController.m
//  YouYi
//
//  Created by chenghao on 2017/10/26.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "YYInvestmentViewController.h"
#import "HTHorizontalSelectionList.h"

@interface YYInvestmentViewController ()<HTHorizontalSelectionListDelegate,HTHorizontalSelectionListDataSource>
@property(nonatomic, strong)NSArray *titleArray;
@property(nonatomic, strong)HTHorizontalSelectionList *investmentListTitle;
@end

@implementation YYInvestmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投资";
    self.titleArray = @[@"综合推荐",@"收益高",@"标期短",@"稳健性"];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initUI{
    self.investmentListTitle = [[HTHorizontalSelectionList alloc] init];
    self.investmentListTitle.dataSource = self;
    self.investmentListTitle.delegate = self;
    self.investmentListTitle.selectionIndicatorColor = MainColor;
    self.investmentListTitle.backgroundColor = WhiteColor;
    self.investmentListTitle.selectionTitleColor = MainColor;
    self.investmentListTitle.nomalTitleColor = BlackColor;
    [self.contentView addSubview:self.investmentListTitle];
    [self.investmentListTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(CellHeight);
    }];
}

#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return self.titleArray.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    return self.titleArray[index];
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    [UIView animateWithDuration:0.2 animations:^{
    }];
    //    [self.contentScrollerView setContentOffset:CGPointMake(ScreenWidth*index, 0)];
    // update the view for the corresponding index
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
