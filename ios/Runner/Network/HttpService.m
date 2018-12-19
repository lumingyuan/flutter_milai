//
//  HttpService.m
//  Runner
//
//  Created by 米来 on 2018/12/5.
//  Copyright © 2018年 The Chromium Authors. All rights reserved.
//

#import "HttpService.h"
#import <AFNetworking.h>
#import <CommonCrypto/CommonDigest.h>
#import "NSString+Encryption.h"

static NSString *const kCode = @"Code";//状态码
static NSString *const kMessage = @"Message";//描述信息
static NSString *const kResult = @"Result";//成功时返回的数据
static NSString *const kEncrypt = @"Encrypt";//是否加密
static NSString* const kHmacKey = @"574584H38Msx80980026QKzbX588Zv0xh95ph8ZG67dj7x69k5091xvm0013";

@interface HttpService()
@property(nonatomic, strong) AFHTTPSessionManager* sessionManager;

@property(nonatomic, strong) NSString* aesKey; //加密key

@end

static HttpService* g_service = nil;
@implementation HttpService

+(HttpService *) shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_service = [[HttpService alloc] init];
    });
    return g_service;
}

- (instancetype) init {
    if (self = [super init]) {
        [self initHttpSessionManager];
    }
    return self;
}

- (NSString *)aesKey {
    if (_aesKey == nil) {
        _aesKey = [kHmacKey substringToIndex:16];
    }
    return _aesKey;
}

- (AFURLSessionManager *)sessionManager {
    return _sessionManager;
}

- (void) initHttpSessionManager {
    _sessionManager = [[AFHTTPSessionManager manager] init];
    
    _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //请求参数为json
    _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
}

#pragma mark 获取加密参数的字符串
- (NSString*)getEncryptParams:(NSString*)paramsJson {
    const char *cKey  = [kHmacKey cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [paramsJson cStringUsingEncoding:NSUTF8StringEncoding];
    const unsigned int blockSize = 64;
    char ipad[blockSize];
    char opad[blockSize];
    char keypad[blockSize];
    
    unsigned int keyLen = (int)strlen(cKey);
    CC_MD5_CTX ctxt;
    if (keyLen > blockSize) {
        CC_MD5_Init(&ctxt);
        CC_MD5_Update(&ctxt, cKey, keyLen);
        CC_MD5_Final((unsigned char *)keypad, &ctxt);
        keyLen = CC_MD5_DIGEST_LENGTH;
    }
    else {
        memcpy(keypad, cKey, keyLen);
    }
    
    memset(ipad, 0x36, blockSize);
    memset(opad, 0x5c, blockSize);
    
    int i;
    for (i = 0; i < keyLen; i++) {
        ipad[i] ^= keypad[i];
        opad[i] ^= keypad[i];
    }
    
    CC_MD5_Init(&ctxt);
    CC_MD5_Update(&ctxt, ipad, blockSize);
    CC_MD5_Update(&ctxt, cData, (int)strlen(cData));
    unsigned char md5[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(md5, &ctxt);
    
    CC_MD5_Init(&ctxt);
    CC_MD5_Update(&ctxt, opad, blockSize);
    CC_MD5_Update(&ctxt, md5, CC_MD5_DIGEST_LENGTH);
    CC_MD5_Final(md5, &ctxt);
    
    const unsigned int hex_len = CC_MD5_DIGEST_LENGTH*2+2;
    char hex[hex_len];
    for(i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        snprintf(&hex[i*2], hex_len-i*2, "%02x", md5[i]);
    }
    
    NSData *HMAC = [[NSData alloc] initWithBytes:hex length:strlen(hex)];
    NSString *hash = [[NSString alloc] initWithData:HMAC encoding:NSUTF8StringEncoding];
    return hash;
}

- (NSString*)jsonWithDictionary:(NSDictionary*)dict {
    NSError *error = nil;
    if (dict == nil) {
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    if ([jsonData length] > 0 && error == nil){
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else{
        return @"";
    }
}

- (NSDictionary*)dictionaryWithJson:(NSData*)data {
    if (!data) {
        return nil;
    }
    NSError *error;
    id result = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments | NSJSONReadingMutableContainers) error:&error];
    if (error != nil)
        return nil;
    return result;
}

// 封装成接口需要的数据
- (NSDictionary*)packParams:(NSDictionary*)params {
    NSString* userId = [params objectForKey:@"userId"];
    if (userId.length == 0) {
        userId = @"0";
    }
    
    NSMutableDictionary* realParams = [NSMutableDictionary dictionaryWithDictionary:params];
    [realParams removeObjectForKey:@"userId"];
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMddHHmmss"];
    [realParams setValue:[df stringFromDate:[NSDate date]] forKey:@"Times"];
    
    //字典转JSON字符串
    NSString* json = [self jsonWithDictionary:realParams];
    
    NSMutableDictionary* result = [NSMutableDictionary dictionary];
    //版本号
    [result setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"Version"];
    //Mac字符串
    
    [result setValue:[self getEncryptParams:json] forKey:@"Mac"];
    [result setValue:@"1001" forKey:@"ActionType"];
    [result setValue:[json AES256ParmEncryptWithKey:self.aesKey] forKey:@"Data"];
    [result setValue:userId forKey:@"UserID"];
    
    return @{@"JsonString":result};
}

- (void) post:(NSString *)url params:(NSDictionary *)params complete:(CompleteBlock)complete {
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSLog(@"[IOS-POST]:%@", url);
    // POST请求
    [_sessionManager POST:url parameters:[self packParams:params] progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        Response* ret = nil;
        if (obj != nil && [obj isKindOfClass:[NSDictionary class]]) {
            ret = [[Response alloc] initWithCode:[[obj objectForKey:kCode] integerValue] Message:[obj objectForKey:kMessage]];
            ret.encrypt = [[obj objectForKey:kEncrypt] boolValue];
            ret.result = [obj objectForKey:kResult];
        } else {
            ret = [[Response alloc] initWithCode:-1 Message:@"返回数据为空"];
        }
        
        //解密
        if (ret.encrypt && ret.result) {
            ret.result = [NSJSONSerialization JSONObjectWithData:[ret.result AES256DataParmDecryptWithKey:self.aesKey] options:NSJSONReadingAllowFragments error:nil];
        }
        
        if (complete) {
            complete(ret);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (complete) {
            complete([[Response alloc] initWithCode:-2 Message:@"服务器被火星人劫持了"]);
        }
    }];
}

@end
