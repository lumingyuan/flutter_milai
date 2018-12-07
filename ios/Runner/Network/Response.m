//
//  Response.m
//  Runner
//
//  Created by 米来 on 2018/12/5.
//  Copyright © 2018年 The Chromium Authors. All rights reserved.
//

#import "Response.h"

@implementation Response

- (instancetype)initWithCode:(NSInteger)code Message:(NSString *)msg {
    if (self = [super init]) {
        self.code = code;
        self.message = msg;
        self.encrypt = NO;
    }
    return self;
}

- (NSString *)toJsonString {
    NSError* error = nil;
    NSData* result = [NSJSONSerialization dataWithJSONObject:[self toDictionary] options:kNilOptions error:&error];
    if (error != nil) {
        return nil;
    }
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];

}

@end
