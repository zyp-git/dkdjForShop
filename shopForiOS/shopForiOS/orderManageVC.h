//
//  orderManageVC.h
//  shopForiOS
//
//  Created by 张允鹏 on 16/7/17.
//  Copyright © 2016年 张允鹏. All rights reserved.
//

#import "baseTabBarController.h"

@interface orderManageVC : baseTabBarController<UITableViewDelegate,UITableViewDataSource>

@property (weak,nonatomic) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@end
