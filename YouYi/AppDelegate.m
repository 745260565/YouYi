//
//  AppDelegate.m
//  YouYi
//
//  Created by chenghao on 2017/10/25.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import "AppDelegate.h"
#import "YYBaseNavigationController.h"
#import "YYHomePageViewController.h"
#import "YYInvestmentViewController.h"
#import "YYWithdrawDepositViewController.h"
#import "YYPesonalCenterViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [TBCityIconFont setFontName:@"iconfont"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = WhiteColor;
    UITabBarController *mainTabBarController = [[UITabBarController alloc] init];
    self.window.rootViewController = mainTabBarController;
    
    YYHomePageViewController *vc1 = [[YYHomePageViewController alloc] initWithTabBarTitle:@"首页" tabBarImageName:@"\U0000e65c"];
    YYInvestmentViewController *vc2 = [[YYInvestmentViewController alloc] initWithTabBarTitle:@"投资" tabBarImageName:@"\U0000e604"];
    YYWithdrawDepositViewController *vc3 = [[YYWithdrawDepositViewController alloc] initWithTabBarTitle:@"提现" tabBarImageName:@"\U0000e605"];
    YYPesonalCenterViewController *vc4 = [[YYPesonalCenterViewController alloc] initWithTabBarTitle:@"我的" tabBarImageName:@"\U0000e6a6"];
    
    YYBaseNavigationController *nav1 = [[YYBaseNavigationController alloc] initWithRootViewController:vc1];
    YYBaseNavigationController *nav2 = [[YYBaseNavigationController alloc] initWithRootViewController:vc2];
    YYBaseNavigationController *nav3 = [[YYBaseNavigationController alloc] initWithRootViewController:vc3];
    YYBaseNavigationController *nav4 = [[YYBaseNavigationController alloc] initWithRootViewController:vc4];
    
    mainTabBarController.viewControllers = @[nav1,nav2,nav3,nav4];

    
    mainTabBarController.selectedIndex = 0;
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
