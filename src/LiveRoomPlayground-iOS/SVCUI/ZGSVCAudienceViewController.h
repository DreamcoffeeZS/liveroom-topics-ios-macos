//
//  ZGSVCAudienceViewController.h
//  LiveRoomPlayground-iOS
//
//  Created by Sky on 2018/11/12.
//  Copyright © 2018 Zego. All rights reserved.
//

#ifdef _Module_ScalableVideoCoding

#import <UIKit/UIKit.h>

@class ZGRoomInfo;

NS_ASSUME_NONNULL_BEGIN

@interface ZGSVCAudienceViewController : UIViewController

@property (strong, nonatomic) ZGRoomInfo *roomInfo;

@end

NS_ASSUME_NONNULL_END

#endif
