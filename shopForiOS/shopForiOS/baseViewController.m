//
//  baseViewController.m
//  shopForiOS
//
//  Created by 张允鹏 on 16/7/17.
//  Copyright © 2016年 张允鹏. All rights reserved.
//

#import "baseViewController.h"
#import "RHWebSocketChannel.h"


@interface baseViewController () <SRWebSocketDelegate>

@property (nonatomic, strong) RHWebSocketChannel *webSocketChannel;

@end

@implementation baseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webSocketChannel = [[RHWebSocketChannel alloc] initWithURL:@"http://s-264268.gotocdn.com"];
    _webSocketChannel.delegate = self;
    [_webSocketChannel openConnection];
}

#pragma mark - SRWebSocketDelegate

// message will either be an NSString if the server is using text
// or NSData if the server is using binary.
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    NSLog(@"Received: %@", message);
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    NSLog(@"Websocket Connected ...");
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

@end