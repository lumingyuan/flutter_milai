#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include <Flutter/Flutter.h>
#import "HttpService.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    
    //http请求
    [self registerHttpMethodChannel];
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

// http请求
- (void)registerHttpMethodChannel {
    FlutterViewController* vc = (FlutterViewController*)self.window.rootViewController;
    
    FlutterMethodChannel* httpChannel = [FlutterMethodChannel methodChannelWithName:@"com.milai.flutter/http" binaryMessenger:vc];
    [httpChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult _Nonnull result) {
        if ([@"GET" isEqualToString:call.method]) {
            NSString* url = [call.arguments objectForKey:@"url"];
            NSDictionary* params = [call.arguments objectForKey:@"params"];
            if (url == nil && url.length == 0) {
                @throw [FlutterError errorWithCode:@"invaild url" message:@"无效URL" details:nil];
            } else {
                [[HttpService shareInstance] post:url params:params complete:^(Response * _Nonnull response) {
                    NSString* jsonString = [response toJsonString];
                    NSLog(@"%@", [response toJsonString]);
                    result(jsonString);
                }];
            }
        } else {
            @throw [FlutterError errorWithCode:@"invaild method" message:@"无效的函数" details:nil];
        }
    }];
}

@end
