//
//  YYBaseTabBarController.m
//  YouYi
//
//  Created by chenghao on 2017/10/26.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "YYBaseTabBarController.h"
#import "YYBaseViewController.h"

@interface YYBaseTabBarController ()

@end

@implementation YYBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setControllersWithNames:(NSArray *)controllerNames{
    NSMutableArray *array = [NSMutableArray new];
    for (NSString *name in controllerNames)
    {
        YYBaseViewController *controller = [[NSClassFromString(name) alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        [array addObject:nav];
    }
    [self setViewControllers:array];
}

-(void)setImages:(NSArray *)images selectImages:(NSArray *)selectImages{
    
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
