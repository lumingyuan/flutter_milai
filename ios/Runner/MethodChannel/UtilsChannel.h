//
//  UtilsChannel.h
//  Runner
//
//  Created by 米来 on 2018/12/14.
//  Copyright © 2018年 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UtilsChannel : NSObject

+ (NSString*)AESEncrypt:(NSString*)src Key:(NSString*)key;

+ (NSString*)AESDecrypt:(NSString*)src Key:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
