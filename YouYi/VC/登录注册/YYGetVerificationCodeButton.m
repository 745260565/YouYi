//
//  YYGetVerificationCodeButton.m
//  YouYi
//
//  Created by chenghao on 2017/10/31.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "YYGetVerificationCodeButton.h"

@interface YYGetVerificationCodeButton()
@property(nonatomic)NSInteger timeCount;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation YYGetVerificationCodeButton

- (instancetype)init {
    self = [super init];
    if (self) {
        self.timeCount = 0;
        [self initUI];
        [self addTarget:self action:@selector(getVerificationCodeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)initUI{
    self.titleLabel.font = [UIFont systemFontOfSize:MFont];
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 3;
    self.layer.borderWidth = 1;
    self.layer.borderColor = MainColor.CGColor;
    [self setTitleColor:MainColor forState:UIControlStateNormal];
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
}

- (void)getVerificationCodeAction{
    YYLog(@"123");
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(udateSelfTitle) userInfo:nil repeats:YES];
    self.enabled = NO;
}

- (void)udateSelfTitle{
    self.timeCount++;
    
    [self setTitle:[NSString stringWithFormat:@"%zds后重试",120-self.timeCount] forState:UIControlStateNormal];
    self.layer.borderColor = [UIColor getColor:@"090909"].CGColor;
    [self setTitleColor:[UIColor getColor:@"090909"] forState:UIControlStateNormal];
    self.backgroundColor = [UIColor getColor:@"f0f0f0"];
    
    if (self.timeCount==120) {
        self.enabled = YES;
        self.timeCount = 0;
        [self.timer invalidate];
        self.timer = nil;
        
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.layer.borderColor = MainColor.CGColor;
        [self setTitleColor:MainColor forState:UIControlStateNormal];
        self.backgroundColor = [UIColor clearColor];
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
