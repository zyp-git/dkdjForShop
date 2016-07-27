//
//  orderManageVC.m
//  shopForiOS
//
//  Created by 张允鹏 on 16/7/17.
//  Copyright © 2016年 张允鹏. All rights reserved.
//

#import "orderManageVC.h"
#import "MJRefresh.h"
#import "orderManageCell.h"
@interface orderManageVC ()

@end

@implementation orderManageVC

- (void)viewDidLoad {
    [super viewDidLoad];

    NSTimer *timer=[[NSTimer alloc]init];
    timer=[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(getOrder) userInfo:nil repeats:YES];
    
    UITableView * tableView=[[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView=tableView;
    [self.view addSubview:self.tableView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [self getOrder];
    }];
//    [self.tableView.mj_header beginRefreshing];
    
}
-(void)getOrder{
    
}
-(NSMutableArray *)dataArray{
    NSDictionary *dic = @{@"Cell": @"MainCell",@"isAttached":@(NO)};
    if (_dataArray==nil) {
        _dataArray=[NSMutableArray arrayWithObjects:dic,dic,dic,dic,dic,dic,dic,dic,dic,dic,dic,dic,dic, nil];
    }
    return _dataArray;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"%@",self.dataArray);
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[self.dataArray[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"MainCell"]){
        orderManageCell * cell=[orderManageCell cellWithTableView:tableView];
        return cell;
    }else if([[self.dataArray[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"AttachedCell"]){
        orderManageCell * cell=[orderManageCell cellWithTableView:tableView];
        return cell;
    }else{
        return nil;
    }

    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[self.dataArray[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"MainCell"])
    {
        return 80;
    }else{
        return 50;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *path = nil;
    
    if ([[self.dataArray[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"MainCell"]) {
        path = [NSIndexPath indexPathForItem:(indexPath.row+1) inSection:indexPath.section];
    }else{
        path = indexPath;
    }
    
    if ([[self.dataArray[indexPath.row] objectForKey:@"isAttached"] boolValue]) {
        // 关闭附加cell
        NSDictionary * dic = @{@"Cell": @"MainCell",@"isAttached":@(NO)};
        self.dataArray[(path.row-1)] = dic;
        [self.dataArray removeObjectAtIndex:path.row];
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[path]  withRowAnimation:UITableViewRowAnimationMiddle];
        [self.tableView endUpdates];
        
    }else{
        // 打开附加cell
        NSDictionary * dic = @{@"Cell": @"MainCell",@"isAttached":@(YES)};
        self.dataArray[(path.row-1)] = dic;
        NSDictionary * addDic = @{@"Cell": @"AttachedCell",@"isAttached":@(YES)};
        [self.dataArray insertObject:addDic atIndex:path.row];
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
        [self.tableView endUpdates];
        
    }
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
