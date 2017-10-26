//
//  UIVIew+create.m
//  OneStoreFramework
//
//

#import "UIView+create.h"

@implementation UIView (create)

+ (instancetype)viewWithFrame:(CGRect)frame
{
    UIView *view = [[self alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

+ (instancetype)autolayoutView
{
    UIView *view = [[self alloc] initWithFrame:CGRectZero];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}

+ (UIView *)duplicate:(UIView *)view
{
    NSData *tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

@end
