//
//  orderManageCell.m
//  shopForiOS
//
//  Created by 张允鹏 on 16/7/18.
//  Copyright © 2016年 张允鹏. All rights reserved.
//

#import "orderManageCell.h"

@implementation orderManageCell

+(orderManageCell *)cellWithTableView:(UITableView *)tableView{
    
    orderManageCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[orderManageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel * label=[[UILabel alloc]initWithFrame:RectMake_LFL(10, 10, 200, 20)];
        label.text=@"name";
        [self.contentView addSubview:label];
        
        UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.moreInfoBtn=btn;
        [btn setTitle: @"收起" forState:UIControlStateNormal] ;
        [btn setTitle: @"展开" forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(moreInfoBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }
    return self;
}
-(void)moreInfoBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(moreInfoBtnClickedWithCell:)]) {
        [self.delegate moreInfoBtnClickedWithCell:self];
    }
}
-(void)setModel:(orderModel *)model{
    
}
@end
