//
//  Response.h
//  Runner
//
//  Created by 米来 on 2018/12/5.
//  Copyright © 2018年 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

NS_ASSUME_NONNULL_BEGIN

@interface Response : Jastor
@property (assign, nonatomic) NSInteger code;
@property (strong, nonatomic) NSString *message;
@property (assign, nonatomic) BOOL encrypt;
@property (strong, nonatomic) id result;

- (instancetype)initWithCode:(NSInteger)code Message:(NSString*)msg;

- (NSString*)toJsonString;

@end

NS_ASSUME_NONNULL_END
