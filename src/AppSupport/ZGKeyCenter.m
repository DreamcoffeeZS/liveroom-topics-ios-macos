//
//  ZGKeyCenter.m
//  LiveRoomPlayGround
//
//  Created by zego on 2019/7/2.
//  Copyright © 2019 Zego. All rights reserved.
//

#import "ZGKeyCenter.h"

@implementation ZGKeyCenter

+ (unsigned int)appID {
    return #appID#;
}

// 从即构主页申请
+ (NSData *)appSign {
    Byte signKey[] = #AppSign#;
    NSData* sign = [NSData dataWithBytes:signKey length:32];
    return sign;
}

@end