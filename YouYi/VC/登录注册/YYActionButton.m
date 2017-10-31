//
//  YYActionButton.m
//  YouYi
//
//  Created by chenghao on 2017/10/31.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "YYActionButton.h"

@implementation YYActionButton

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 3;
    [self setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.backgroundColor = [UIColor grayColor];
    self.enabled = NO;
}

- (void)setEnabled:(BOOL)enabled{
    YYLog(@"actionButtonEnable");
    if (enabled) {
        self.backgroundColor = MainColor;
    }else{
        self.backgroundColor = [UIColor grayColor];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
