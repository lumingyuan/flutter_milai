//
//  NSString+AES.h
//  WebService
//
//  Created by 凌洛寒 on 15/11/12.
//  Copyright © 2015年 凌洛寒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encryption)

- (NSString *)AES256ParmEncryptWithKey:(NSString *)key;//加密
- (NSString *)AES256ParmDecryptWithKey:(NSString *)key;//解密
- (NSData *)AES256DataParmDecryptWithKey:(NSString *)key;//解密
@end
