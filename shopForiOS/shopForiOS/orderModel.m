//
//  orderModel.m
//  shopForiOS
//
//  Created by 张允鹏 on 16/7/18.
//  Copyright © 2016年 张允鹏. All rights reserved.
//

#import "orderModel.h"

@implementation orderModel
+(orderModel* )modelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
