//
//  YYBaseViewController.m
//  YouYi
//
//  Created by chenghao on 2017/10/26.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "YYBaseViewController.h"

#define HEADER_HEIGHT 44.0
#define NULLLABELTAG 99

@interface YYBaseViewController ()
@property(nonatomic, strong) UIView *nullView;
@end

@implementation YYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"LFC: viewDidLoad: %@", self);
    self.navigationController.delegate = self;
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(HEADER_HEIGHT);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@(LengthInIP6(69)));
    }];
    [self.headerView addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [_backBtn setImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
    _backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _backBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [self.headerView addSubview:_backBtn];
    _backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(60);
        make.centerY.mas_equalTo(0);
    }];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:LengthInIP6(25)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:self.titleLabel];
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 60, 0, 60);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.headerView).with.insets(padding);
    }];
    
    
    self.contentView = [UIView new];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HEADER_HEIGHT);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.equalTo(self.headerView.mas_bottom);
    }];
    
    self.view.clipsToBounds = YES;
    
    // Do any additional setup after loading the view.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSLog(@"%@", change);
    if (object == self.headerView && [keyPath isEqualToString:@"hidden"]) {
        BOOL hidden = [change[@"new"] boolValue];
        if (hidden) {
            [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_top);
            }];
        }else{
            [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.headerView.mas_bottom);
            }];
        }
    }
}

- (UIView*)nullView {
    if (!_nullView) {
        _nullView = [UIView new];
        _nullView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"null_icon"]];
        [_nullView addSubview:imgV];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.bottom.equalTo(_nullView.mas_centerY).offset(20);
        }];
        
        UILabel *textLabel = [UILabel new];
        textLabel.tag = NULLLABELTAG;
        textLabel.textColor = [UIColor blackColor];
        textLabel.font = [UIFont boldSystemFontOfSize:17.f];
        textLabel.textAlignment = NSTextAlignmentCenter;
        [_nullView addSubview:textLabel];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imgV);
            make.top.equalTo(imgV.mas_bottom).offset(8);
        }];
    }
    return _nullView;
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    self.titleLabel.text = title;
}

- (void)popBack
{
    NSLog(@"EDbaseVC popback");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showNullView:(BOOL)show tips:(NSString*)nullTips {
    if (show) {
        UILabel *tipsLab = (UILabel*)[self.nullView viewWithTag:NULLLABELTAG];
        tipsLab.text = nullTips;
        [self.contentView addSubview:self.nullView];
        [self.nullView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }else{
        [self.nullView removeFromSuperview];
    }
}

- (void)showLoading
{
    [self showLoadingWithMessage:nil];
}

- (void)showLoadingWithMessage:(NSString *)message
{
    [self showLoadingWithMessage:message hideAfter:0];
}

- (void)showLoadingWithMessage:(NSString *)message hideAfter:(NSTimeInterval)second
{
    [self showLoadingWithMessage:message onView:self.view hideAfter:second];
}

- (void)showLoadingWithMessage:(NSString *)message onView:(UIView *)aView hideAfter:(NSTimeInterval)second
{
    self.isLoading = YES;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    
    if (message) {
        hud.labelText = message;
        hud.mode = MBProgressHUDModeText;
    }
    else {
        hud.mode = MBProgressHUDModeIndeterminate;
    }
    
    if (second > 0) {
        [hud hide:YES afterDelay:second];
    }
}

- (void)hideLoading
{
    [self hideLoadingOnView:self.view];
}

- (void)hideLoadingOnView:(UIView *)aView
{
    self.isLoading = NO;
    [MBProgressHUD hideAllHUDsForView:aView animated:YES];
}

- (void)dealloc {
    NSLog(@"LFC: dealloc: %@", self);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.headerView removeObserver:self forKeyPath:@"hidden" ];
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
