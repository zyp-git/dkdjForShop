//
//  AppDelegate.m
//  shopForiOS
//
//  Created by 张允鹏 on 16/7/17.
//  Copyright © 2016年 张允鹏. All rights reserved.
//

#import "AppDelegate.h"
#import "orderManageVC.h"
#import "searchOrderVC.h"
#import "shopManageVC.h"
#import "baseNavigationController.h"
#import "RHWebSocketChannel.h"

@interface AppDelegate () <SRWebSocketDelegate>

@property (nonatomic, strong) RHWebSocketChannel *webSocketChannel;
@property (strong,nonatomic) SRWebSocket * webSocket;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setTabBarController];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    baseNavigationController * navi=[[baseNavigationController alloc]initWithRootViewController:self.tabBarController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = navi;//这里必须的，否则sharesdk会有些问题
    
    //在显示窗口子视图加入ViewController视图
//    [window addSubview:tabBarController.view]@"ws://122.114.94.150:8888"
//        _webSocketChannel = [[RHWebSocketChannel alloc] initWithURL:@"ws://s-264268.gotocdn.com:8888"];
//        _webSocketChannel = [[RHWebSocketChannel alloc] initWithURL:@"ws://115.29.193.48:8088"];
//        _webSocketChannel = [[RHWebSocketChannel alloc] initWithURL:@"ws://122.114.94.150:8888"];
//    _webSocketChannel.delegate = self;
//    [_webSocketChannel openConnection];
    
    
    NSString * urlstr=@"ws://115.29.193.48:8088";
    urlstr=@"http://s-264268.gotocdn.com:8888";
//    urlstr=@"http://122.114.94.150:8888";
//ASP.NET_SessionId=xqtey7vinh5dwgb0ucbrvi0q; name=15042139998; password=202cb962ac59075b964b07152d234b70; type=2

    NSURL * url = [NSURL URLWithString:urlstr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request addValue:@"2" forHTTPHeaderField:@"type"];
    [request addValue:@"eyg40uvxhti0q7vicbvnh5dw" forHTTPHeaderField:@"ASP.NET_SessionId"];
    [request addValue:@"15042139998" forHTTPHeaderField:@"name"];
    [request addValue:@"202cb962ac59075b964b07152d234b70" forHTTPHeaderField:@"password"];
    
//    NSString * str = @"ASP.NET_SessionId=xqtey7vinh5dwgb0ucbrvi0q; name=15042139998; password=202cb962ac59075b964b07152d234b70; type=2";
//    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//    request.HTTPBody = data;
    _webSocket =[[SRWebSocket alloc]initWithURLRequest:request];
    _webSocket.delegate=self;
    [_webSocket open];
    NSLog(@"Websocket openConnection ...");

    
    return YES;
}
-(void)setTabBarController{
    
    
    self.tabBarController=[[baseTabBarController alloc]init];
    
    
    orderManageVC * orderManage=[[orderManageVC alloc]init];
    orderManage.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"订单处理" image:nil tag:0];
    
    searchOrderVC * searchOrder=[[searchOrderVC alloc]init];
    searchOrder.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"历史订单" image:nil tag:1];
    
    shopManageVC * shopManage=[[shopManageVC alloc]init];
    shopManage.tabBarItem= [[UITabBarItem alloc]initWithTitle:@"店铺管理" image:nil tag:2];
    
    [self.tabBarController setViewControllers:[NSArray arrayWithObjects:orderManage,searchOrder,shopManage, nil] animated:YES];
    
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBarController.tabBar.bounds];//下面修改背景色
    bgView.backgroundColor = [UIColor whiteColor];
    [self.tabBarController.tabBar insertSubview:bgView atIndex:0];
    self.tabBarController.tabBar.opaque = YES;
}
#pragma mark - SRWebSocketDelegate

// message will either be an NSString if the server is using text
// or NSData if the server is using binary.

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    NSLog(@"Received: %@", message);
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    
    NSLog(@"Websocket Connected ...");
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"Upgrade":@"websocket",@"Connection":@"Upgrade",@"Host":@"122.114.94.150:2222",@"Origin":@"122.114.94.150:2222",@"Sec-WebSocket-Key":@"VWWwMGPlzCcFaqR55jHrFgnC" ,@"Cookie":@"ASP.NET_SessionId=g3g038kzhrjea1hb7vk1szbf; name=15042139998; password=202CB962AC59075B964B07152D234B70; type=2",@"Sec-WebSocket-Version":@"13",@"Sec-WebSocket-Extensions":@"x-webkit-deflate-frame"} options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [_webSocketChannel.webSocket send:jsonString];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    NSLog(@":( Websocket Failed With Error %@", error);
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
    NSLog(@"WebSocket closed: code-[%ld], reason-[%@]", code, reason);
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload
{
    NSLog(@"Websocket received pong");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.dkdjia.iPhone.shopForiOS.shopForiOS" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"shopForiOS" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"shopForiOS.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
