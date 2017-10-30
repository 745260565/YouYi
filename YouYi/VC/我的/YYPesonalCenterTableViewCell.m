//
//  YYPesonalCenterTableViewCell.m
//  YouYi
//
//  Created by chenghao on 2017/10/30.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "YYPesonalCenterTableViewCell.h"

@interface YYPesonalCenterTableViewCell ()
@property (nonatomic, strong) UIImageView *backgoundImageView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation YYPesonalCenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
//        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.backgoundImageView = [[UIImageView alloc] init];
    self.iconImageView = [[UIImageView alloc] init];
    self.titleLabel = [[UILabel alloc] init];

    [self addSubview:self.backgoundImageView];
    [self.backgoundImageView addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];

    [self.backgoundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(24);
    }];

    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backgoundImageView.mas_right).mas_offset(LengthInIP6(10));
        make.centerY.mas_equalTo(0);
    }];
}

- (void)updateWithImage:(UIImage*)image backgroundColorString:(NSString*)backgroundColorString title:(NSString*)title{
    self.backgoundImageView.image = [UIImage createColorImg:backgroundColorString];
    self.iconImageView.image = image;
    self.titleLabel.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
