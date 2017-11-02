//
//  YYBaseViewController.h
//  YouYi
//
//  Created by chenghao on 2017/10/26.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYBaseViewController : UIViewController<UINavigationControllerDelegate>
@property(nonatomic, strong)UIView *headerView;
@property(nonatomic, strong)UIView *contentView;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIButton *backBtn;
@property(nonatomic)BOOL hiddenTabBarWhenPushed;
@property(nonatomic)BOOL isLoading;
@property(nonatomic)BOOL commandKeyboard;//在base中控制放下键盘，默认是NO

- (instancetype)initWithTabBarTitle:(NSString*)titleString tabBarImageName:(NSString*)imageName;

- (void)popBack;

- (void)setHeaderViewHeight:(CGFloat)headerViewHeight;

- (void)showNullView:(BOOL)show tips:(NSString*)nullTips;
/**
 *  功能:显示loading
 */
- (void)showLoading;

/**
 *  功能:显示loading
 */
- (void)showLoadingWithMessage:(NSString *)message;

/**
 *  功能:显示loading
 */
- (void)showLoadingWithMessage:(NSString *)message hideAfter:(NSTimeInterval)second;

/**
 *  功能:显示loading
 */
- (void)showLoadingWithMessage:(NSString *)message onView:(UIView *)aView hideAfter:(NSTimeInterval)second;

/**
 *  功能:隐藏loading
 */
- (void)hideLoading;

/**
 *  功能:隐藏loading
 */
- (void)hideLoadingOnView:(UIView *)aView;
@end
