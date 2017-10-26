//
//  UIViewController+runtime.m
//  eDrive
//
//  Created by harbin6666 on 15/5/29.
//  Copyright (c) 2015年 carbit. All rights reserved.
//

#import "UIViewController+runtime.h"
#import <objc/runtime.h>
@interface UIViewController_runtime ()

@end

@implementation UIViewController_runtime
+ (void)load {
    [self swizzleViewDidLoad];
    [self swizzleDealloc];
}

+ (void)swizzleViewDidLoad{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(custom_viewDidLoad);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,originalSelector,method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}
- (void)custom_viewDidLoad {
    [self custom_viewDidLoad];
    NSLog(@"custom_viewDidLoad: %@", self);
}
//-(void)dealloc{
//    NSLog(@"dealloc %@",self);
//}
-(void)custom_dealloc{
//    [self custom_dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"custom_dealloc %@",self);
}

+ (void)swizzleDealloc{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        
        SEL originalSelector = NSSelectorFromString(@"dealloc");
        SEL swizzledSelector = @selector(custom_dealloc);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,originalSelector,method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
