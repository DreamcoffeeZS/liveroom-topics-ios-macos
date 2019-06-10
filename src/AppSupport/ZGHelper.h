//
//  ZGHelper.h
//  LiveRoomPlayground
//
//  Copyright © 2018年 Zego. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString* kZGTopicPublish;
extern NSString* kZGTopicPlay;
extern NSString* kZGTopicMediaPlayer;
extern NSString* kZGTopicMediaSideInfo;
extern NSString* kZGTopicSVC;
extern NSString* kZGTopicMediaRecord;
extern NSString* kZGTopicExternalVideoCapture;
extern NSString* kZGTopicExternalVideoRender;

@interface ZGHelper : NSObject

@property (class, copy ,nonatomic, readonly) NSString *userID;

+ (NSString *)getDeviceUUID;

@end

NS_ASSUME_NONNULL_END
