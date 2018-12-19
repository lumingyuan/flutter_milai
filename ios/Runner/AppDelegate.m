#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include <Flutter/Flutter.h>
#import "HttpService.h"
#include "UtilsChannel.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    
    //http请求
    [self registerHttpMethodChannel];
    
    [self registerUtilsMethodChannel];
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSString * urlStr = [url absoluteString];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"WeChat" object:nil userInfo:@{@"url":urlStr}];
    return YES;
}

// ios 9.0+
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
            options:(NSDictionary<NSString*, id> *)options
{
    NSString * urlStr = [url absoluteString];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"WeChat" object:nil userInfo:@{@"url":urlStr}];
    return YES;
}

// http请求
- (void)registerHttpMethodChannel {
    FlutterViewController* vc = (FlutterViewController*)self.window.rootViewController;
    
    FlutterMethodChannel* httpChannel = [FlutterMethodChannel methodChannelWithName:@"com.milai.flutter/http" binaryMessenger:vc];
    [httpChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult _Nonnull result) {
        if ([@"POST" isEqualToString:call.method]) {
            NSString* url = [call.arguments objectForKey:@"url"];
            NSDictionary* params = [call.arguments objectForKey:@"params"];
            if (url == nil && url.length == 0) {
                @throw [FlutterError errorWithCode:@"invaild url" message:@"无效URL" details:nil];
            } else {
                [[HttpService shareInstance] post:url params:params complete:^(Response * _Nonnull response) {
                    NSString* jsonString = [response toJsonString];
                    result(jsonString);
                }];
            }
        } else {
            @throw [FlutterError errorWithCode:@"invaild method" message:@"无效的函数" details:nil];
        }
    }];
}

//工具方法
- (void)registerUtilsMethodChannel {
    FlutterViewController* vc = (FlutterViewController*)self.window.rootViewController;
    
    FlutterMethodChannel* httpChannel = [FlutterMethodChannel methodChannelWithName:@"com.milai.flutter/utils" binaryMessenger:vc];
    [httpChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult _Nonnull result) {
        if ([@"encryptAES" isEqualToString:call.method]) {
            result([UtilsChannel AESEncrypt:[call.arguments objectForKey:@"source"] Key:[call.arguments objectForKey:@"key"]]);
        } else if ([@"decryptAES" isEqualToString:call.method]) {
            result([UtilsChannel AESDecrypt:[call.arguments objectForKey:@"source"] Key:[call.arguments objectForKey:@"key"]]);
        } else {
            @throw [FlutterError errorWithCode:@"invaild method" message:@"无效的函数" details:nil];
        }
    }];
}

@end
