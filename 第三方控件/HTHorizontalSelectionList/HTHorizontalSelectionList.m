//
//  HTHorizontalSelectionList.m
//  Hightower
//
//  Created by Erik Ackermann on 7/31/14.
//  Copyright (c) 2014 Hightower Inc. All rights reserved.
//

#import "HTHorizontalSelectionList.h"
#import "HTHorizontalSelectionListScrollView.h"

@interface HTHorizontalSelectionList ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView *selectionIndicatorBar;

@property (nonatomic, strong) NSLayoutConstraint *leftSelectionIndicatorConstraint, *rightSelectionIndicatorConstraint;

@property (nonatomic, strong) UIView *bottomTrim;

@property (nonatomic, strong) NSMutableDictionary *buttonColorsByState;

@end

#define kHTHorizontalSelectionListHorizontalMargin 0
#define kHTHorizontalSelectionListInternalPadding 0

#define kHTHorizontalSelectionListSelectionIndicatorHeight 5

#define kHTHorizontalSelectionListTrimHeight 0.5

@implementation HTHorizontalSelectionList

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
      //  self.backgroundColor = [UIColor whiteColor];

        _scrollView = [[HTHorizontalSelectionListScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.canCancelContentTouches = YES;
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_scrollView];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollView]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_scrollView)]];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_scrollView)]];

        _contentView = [[UIView alloc] init];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [_scrollView addSubview:_contentView];

        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0
                                                          constant:0.0]];

        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:0.0]];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentView]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_contentView)]];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentView]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_contentView)]];

        _bottomTrim = [[UIView alloc] init];
        _bottomTrim.backgroundColor = [UIColor clearColor];
        _bottomTrim.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_bottomTrim];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_bottomTrim]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_bottomTrim)]];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomTrim(height)]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:@{@"height" : @(kHTHorizontalSelectionListTrimHeight)}
                                                                       views:NSDictionaryOfVariableBindings(_bottomTrim)]];

        self.buttonInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.selectionIndicatorStyle = HTHorizontalSelectionIndicatorStyleBottomBar;

        _buttons = [NSMutableArray array];

        _selectionIndicatorBar = [[UIView alloc] init];
        _selectionIndicatorBar.translatesAutoresizingMaskIntoConstraints = NO;

        _buttonColorsByState = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - Custom Getters and Setters

- (void)setSelectionIndicatorColor:(UIColor *)selectionIndicatorColor {
    _selectionIndicatorBar.backgroundColor = selectionIndicatorColor;
}

- (UIColor *)selectionIndicatorColor {
    return _selectionIndicatorBar.backgroundColor;
}

- (void)setBottomTrimColor:(UIColor *)bottomTrimColor {
    _bottomTrim.backgroundColor = bottomTrimColor;
}

- (void)setSelectionTitleColor:(UIColor *)selectionTitleColor
{
    if (!_buttonColorsByState[@(UIControlStateSelected)]) {
        _buttonColorsByState[@(UIControlStateSelected)] = selectionTitleColor;
    }
}

- (void)setNomalTitleColor:(UIColor *)nomalTitleColor
{
    if (!_buttonColorsByState[@(UIControlStateNormal)]) {
        _buttonColorsByState[@(UIControlStateNormal)] = nomalTitleColor;
    }
}

- (UIColor *)bottomTrimColor {
    return _bottomTrim.backgroundColor;
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state {
    _buttonColorsByState[@(state)] = color;
}

#pragma mark - Public Methods

- (void)reloadData {
    for (UIButton *button in self.buttons) {
        [button removeFromSuperview];
    }

    [self.selectionIndicatorBar removeFromSuperview];
    [self.buttons removeAllObjects];

    NSInteger totalButtons = [self.dataSource numberOfItemsInSelectionList:self];

    if (totalButtons < 1) {
        return;
    }

    UIButton *previousButton;

    for (NSInteger index = 0; index < totalButtons; index++) {
        NSString *buttonTitle = [self.dataSource selectionList:self titleForItemWithIndex:index];

        UIButton *button = [self selectionListButtonWithTitle:buttonTitle];
        [self.contentView addSubview:button];

        if (previousButton) {
//            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[previousButton]-padding-[button]"
//                                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
//                                                                                     metrics:@{@"padding" : @(kHTHorizontalSelectionListInternalPadding),}
//                                                                                       views:NSDictionaryOfVariableBindings(previousButton, button)]];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(previousButton.mas_right);
                make.width.equalTo(self).multipliedBy(0.25);
            }];
        } else {
//            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[button]"
//                                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
//                                                                                     metrics:@{@"margin" : @(kHTHorizontalSelectionListHorizontalMargin)}
//                                                                                       views:NSDictionaryOfVariableBindings(button)]];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@0);
                make.width.equalTo(self).multipliedBy(0.25);
            }];
        }

        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                                     attribute:NSLayoutAttributeCenterY
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1.0
                                                                      constant:0.0]];

        previousButton = button;

        [self.buttons addObject:button];
    }

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[previousButton]-margin-|"
                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                                                             metrics:@{@"margin" : @(kHTHorizontalSelectionListHorizontalMargin)}
                                                                               views:NSDictionaryOfVariableBindings(previousButton)]];

    if (totalButtons > 0) {
        if(self.selectedButtonIndex > self.buttons.count - 1)return;
        UIButton *selectedButton = self.buttons[self.selectedButtonIndex];
        selectedButton.selected = YES;

        switch (self.selectionIndicatorStyle) {
            case HTHorizontalSelectionIndicatorStyleBottomBar: {
                [self.contentView addSubview:self.selectionIndicatorBar];

                [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_selectionIndicatorBar(height)]|"
                                                                                         options:NSLayoutFormatDirectionLeadingToTrailing
                                                                                         metrics:@{@"height" : @(kHTHorizontalSelectionListSelectionIndicatorHeight)}
                                                                                           views:NSDictionaryOfVariableBindings(_selectionIndicatorBar)]];

                [self alignSelectionIndicatorWithButton:selectedButton];
                break;
            }

            case HTHorizontalSelectionIndicatorStyleButtonBorder: {
                selectedButton.layer.borderColor = self.selectionIndicatorColor.CGColor;
                break;
            }
        }
    }

    [self sendSubviewToBack:self.bottomTrim];

    [self updateConstraintsIfNeeded];
}

- (void)layoutSubviews {
    if (!self.buttons.count) {
        [self reloadData];
    }

    [super layoutSubviews];
}

-(UIButton *)titleButton:(NSInteger)index
{
    return [self.buttons safeObjectAtIndex:index];
}

-(void)dotUpdateForIndex:(NSInteger)index hidden:(BOOL)isHidden{
    UIButton *button=[self titleButton:index];
    if(!isHidden){
        for(UIView* view in [button subviews]){
            if(view.tag == 100+index){
                if(view.hidden){
                    view.hidden=NO;
                }
                return;
            }
        }
        UIImageView *updateView = [[UIImageView alloc] init];
        updateView.image = [UIImage imageNamed:@"dot_update"];
        updateView.tag=100+index;
        updateView.hidden=NO;
        [button addSubview:updateView];
        [updateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(LengthInIP6(3)));
            make.right.equalTo(@(-LengthInIP6(3)));
        }];
    }else{
        for(UIView* view in [button subviews]){
            if(view.tag == 100+index){
                if(!view.hidden){
                    view.hidden=YES;
                }
            }
        }

    }
}

#pragma mark - Private Methods

- (UIButton *)selectionListButtonWithTitle:(NSString *)buttonTitle {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.contentEdgeInsets = self.buttonInsets;
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    for (NSNumber *controlState in [self.buttonColorsByState allKeys]) {
        [button setTitleColor:self.buttonColorsByState[controlState] forState:controlState.integerValue];
    }

    button.titleLabel.font = [UIFont systemFontOfSize:20];
 //   button.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    [button sizeToFit];
 //   button.width = 48;

    if (self.selectionIndicatorStyle == HTHorizontalSelectionIndicatorStyleButtonBorder) {
        button.layer.borderWidth = 1.0;
        button.layer.cornerRadius = 3.0;
        button.layer.borderColor = [UIColor clearColor].CGColor;
        button.layer.masksToBounds = YES;
    }

    [button addTarget:self
               action:@selector(buttonWasTapped:)
     forControlEvents:UIControlEventTouchUpInside];

    button.translatesAutoresizingMaskIntoConstraints = NO;
    return button;
}

- (void)setupSelectedButton:(UIButton *)selectedButton oldSelectedButton:(UIButton *)oldSelectedButton {
    switch (self.selectionIndicatorStyle) {
        case HTHorizontalSelectionIndicatorStyleBottomBar: {
            [self.contentView removeConstraint:self.leftSelectionIndicatorConstraint];
            [self.contentView removeConstraint:self.rightSelectionIndicatorConstraint];

            [self alignSelectionIndicatorWithButton:selectedButton];
            [self layoutIfNeeded];
            break;
        }

        case HTHorizontalSelectionIndicatorStyleButtonBorder: {
            selectedButton.layer.borderColor = self.selectionIndicatorColor.CGColor;
            oldSelectedButton.layer.borderColor = [UIColor clearColor].CGColor;
            break;
        }
    }
}

- (void)alignSelectionIndicatorWithButton:(UIButton *)button {
    self.leftSelectionIndicatorConstraint = [NSLayoutConstraint constraintWithItem:self.selectionIndicatorBar
                                                                         attribute:NSLayoutAttributeLeft
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:button
                                                                         attribute:NSLayoutAttributeLeft
                                                                        multiplier:1.0
                                                                          constant:0.0];
    [self.contentView addConstraint:self.leftSelectionIndicatorConstraint];

    self.rightSelectionIndicatorConstraint = [NSLayoutConstraint constraintWithItem:self.selectionIndicatorBar
                                                                          attribute:NSLayoutAttributeRight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:button
                                                                          attribute:NSLayoutAttributeRight
                                                                         multiplier:1.0
                                                                           constant:0.0];
    [self.contentView addConstraint:self.rightSelectionIndicatorConstraint];
}

#pragma mark - Action Handlers

- (void)buttonWasTapped:(id)sender {
    NSInteger index = [self.buttons indexOfObject:sender];
    if (index != NSNotFound) {
        if (index == self.selectedButtonIndex) {
            return;
        }

        UIButton *oldSelectedButton = self.buttons[self.selectedButtonIndex];
        oldSelectedButton.selected = NO;
        self.selectedButtonIndex = index;

        UIButton *tappedButton = (UIButton *)sender;
        tappedButton.selected = YES;

        [self layoutIfNeeded];
        [UIView animateWithDuration:0.4
                              delay:0
             usingSpringWithDamping:0.5
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             [self setupSelectedButton:tappedButton oldSelectedButton:oldSelectedButton];
                         }
                         completion:nil];

        [self.scrollView scrollRectToVisible:CGRectInset(tappedButton.frame, -kHTHorizontalSelectionListHorizontalMargin, 0)
                                    animated:YES];

        if ([self.delegate respondsToSelector:@selector(selectionList:didSelectButtonWithIndex:)]) {
            [self.delegate selectionList:self didSelectButtonWithIndex:index];
        }
    }
}

-(void)selectIndex:(NSInteger)index
{
//    if (index == self.selectedButtonIndex) {
//        return;
//    }
    if(index > self.buttons.count - 1 || self.selectedButtonIndex > self.buttons.count - 1)return;
    UIButton *oldSelectedButton = self.buttons[self.selectedButtonIndex];
    oldSelectedButton.selected = NO;
    self.selectedButtonIndex = index;
    
    UIButton *tappedButton = self.buttons[self.selectedButtonIndex];
    tappedButton.selected = YES;
    
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.4
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self setupSelectedButton:tappedButton oldSelectedButton:oldSelectedButton];
                     }
                     completion:nil];
    
    [self.scrollView scrollRectToVisible:CGRectInset(tappedButton.frame, -kHTHorizontalSelectionListHorizontalMargin, 0)
                                animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(selectionList:didSelectButtonWithIndex:)]) {
        [self.delegate selectionList:self didSelectButtonWithIndex:index];
    }


}

@end

