//
//  YYBaseTabBarController.h
//  YouYi
//
//  Created by chenghao on 2017/10/26.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYBaseTabBarController : UITabBarController

-(void)setControllersWithNames:(NSArray *)controllerNames;

-(void)setImages:(NSArray *)images selectImages:(NSArray *)selectImages;

@end
