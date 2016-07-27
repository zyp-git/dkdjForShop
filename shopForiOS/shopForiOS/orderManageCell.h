//
//  orderManageCell.h
//  shopForiOS
//
//  Created by 张允鹏 on 16/7/18.
//  Copyright © 2016年 张允鹏. All rights reserved.
//
#import "orderModel.h"
#import <UIKit/UIKit.h>
@class orderManageCell;
@protocol orderManageCellDelegate <NSObject>

-(void)moreInfoBtnClickedWithCell:(orderManageCell *)cell;

@end
@interface orderManageCell : UITableViewCell

@property (nonatomic,strong) orderModel * model;
@property (weak,nonatomic) UIButton * moreInfoBtn;

@property (weak,nonatomic) id<orderManageCellDelegate> delegate;
+(orderManageCell *)cellWithTableView:(UITableView *)tableView;

@end
