//
//  YYInvestmentTableViewCell.m
//  YouYi
//
//  Created by chenghao on 2017/11/2.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "YYInvestmentTableViewCell.h"
#import "YYGameListResponse.h"

@interface YYInvestmentTableViewCell()
@property(nonatomic, strong) UIImageView *titleImageView;//
@property(nonatomic, strong) UILabel *qiLabel;//期数
@property(nonatomic, strong) UILabel *typeLabel;//p2p性质
@property(nonatomic, strong) UILabel *detailLabel;//p2p介绍
@property(nonatomic, strong) UILabel *p2p_nvestment_timeLabel;//p2p投资期限
@property(nonatomic, strong) UILabel *p2p_year_yieldLabel;//p2p年化利率
@property(nonatomic, strong) UILabel *p2p_earinigs;//最高收益
@property(nonatomic, strong) UILabel *numberLabel;//投资人数
@end

@implementation YYInvestmentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    UIView *cellHeaderView = [[UIView alloc] init];
    cellHeaderView.backgroundColor = BaseBackgroundColor;
    [self addSubview:cellHeaderView];
    [cellHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(BaseInterval);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = BaseBackgroundColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BaseInterval);
        make.right.mas_equalTo(-BaseInterval);
        make.top.mas_equalTo(cellHeaderView.mas_bottom).mas_equalTo(LengthInIP6(62));
        make.height.mas_equalTo(1);
    }];
    
    self.titleImageView = [[UIImageView alloc] init];
    [self addSubview:self.titleImageView];
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BaseInterval);
        make.top.mas_equalTo(BaseInterval);
        make.height.mas_equalTo(LengthInIP6(45));
        make.width.mas_equalTo(LengthInIP6(100));
    }];
}

- (void)refreshData:(YYGameListResponse*)response{
//    self.titleImageView.image = [UIImage imageNamed:@"用户中心顶部背景"];
    self.titleImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://i2.265g.com/images/201609/201609221020301492.jpg"]]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
