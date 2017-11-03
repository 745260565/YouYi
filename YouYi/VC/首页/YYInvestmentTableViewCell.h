//
//  YYInvestmentTableViewCell.h
//  YouYi
//
//  Created by chenghao on 2017/11/2.
//  Copyright © 2017年 com.72g.www. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYGameListResponse.h"

@interface YYInvestmentTableViewCell : UITableViewCell
- (void)refreshData:(YYGameListResponse*)response;
@end
