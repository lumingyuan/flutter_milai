//
//  UtilsChannel.m
//  Runner
//
//  Created by 米来 on 2018/12/14.
//  Copyright © 2018年 The Chromium Authors. All rights reserved.
//

#import "UtilsChannel.h"
#import "NSString+Encryption.h"
#import <UIKit/UIKit.h>

@implementation UtilsChannel

+ (NSString *)AESEncrypt:(NSString *)src Key:(NSString *)key {
    return [src AES256ParmEncryptWithKey:key];
}

+ (NSString *)AESDecrypt:(NSString *)src Key:(NSString *)key {
    return [src AES256ParmDecryptWithKey:key];
}


+ (NSString *)imageBase64:(NSString *)filepath {
    UIImage* img = [UIImage imageWithContentsOfFile:filepath];
    
    NSData *dataObj = UIImageJPEGRepresentation(img, 0.75);
    
    NSString* str = [dataObj base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return str;
}

@end
