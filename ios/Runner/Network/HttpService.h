//
//  HttpService.h
//  Runner
//
//  Created by 米来 on 2018/12/5.
//  Copyright © 2018年 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Response.h"


NS_ASSUME_NONNULL_BEGIN

typedef void (^CompleteBlock)(Response* response);

@interface HttpService : NSObject

+(HttpService *) shareInstance;

- (void)test;

// 请求消息
- (void) post:(NSString*)url params:(NSDictionary*)params complete:(CompleteBlock)complete;

@end

NS_ASSUME_NONNULL_END
