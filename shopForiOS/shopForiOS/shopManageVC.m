//
//  shopManageVC.m
//  
//
//  Created by 张允鹏 on 16/7/17.
//
//

#import "shopManageVC.h"

@interface shopManageVC ()

@end

@implementation shopManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor grayColor];

}
-(void)goToBack{
    
}
-(void)segmentClick{
    UIBarButtonItem * backBtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(goToBack)];
    backBtn.tintColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backBtn;
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
