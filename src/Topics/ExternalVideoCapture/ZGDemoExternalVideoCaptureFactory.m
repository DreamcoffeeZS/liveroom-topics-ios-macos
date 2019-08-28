//
//  ZGDemoExternalVideoCaptureFactory.m
//  LiveRoomPlayGround
//
//  Created by jeffreypeng on 2019/8/15.
//  Copyright © 2019 Zego. All rights reserved.
//
#ifdef _Module_ExternalVideoCapture

#import "ZGDemoExternalVideoCaptureFactory.h"

@interface ZGDemoExternalVideoCaptureFactory () <ZegoVideoCaptureDevice>
{
    dispatch_queue_t _postDataQueue;
}

@property (nonatomic) id<ZegoVideoCaptureClientDelegate> client;
@property (nonatomic) BOOL isPreview;
@property (nonatomic) BOOL isCapture;

@end

@implementation ZGDemoExternalVideoCaptureFactory

- (instancetype)init {
    if (self = [super init]) {
        _postDataQueue = dispatch_queue_create("com.doudong.ZGDemoExternalVideoCaptureFactory.postDataQueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)postCapturedData:(CVImageBufferRef)image withPresentationTimeStamp:(CMTime)time {
    if (!image) return;
    CVBufferRetain(image);
    dispatch_async(_postDataQueue, ^{
        if (self.isCapture) {
            [self.client onIncomingCapturedData:image withPresentationTimeStamp:time];
        }
        CVBufferRelease(image);
    });
}

#pragma mark - private methods

- (void)stopCapture {
    if (self.onStopCapture) {
        self.onStopCapture();
    }
    self.isCapture = NO;
    self.isPreview = NO;
}

- (void)destoryResource {
    [self stopCapture];
    [self.client destroy];
    self.client = nil;
}

#pragma mark - ZegoVideoCaptureFactory

- (nonnull id<ZegoVideoCaptureDevice>)zego_create:(nonnull NSString*)deviceId {
    NSLog(NSLocalizedString(@"%s", nil), __func__);
    return self;
}

- (void)zego_destroy:(nonnull id<ZegoVideoCaptureDevice>)device {
    NSLog(NSLocalizedString(@"%s", nil), __func__);
    [self destoryResource];
}

#pragma mark - ZegoVideoCaptureDevice

- (void)zego_allocateAndStart:(nonnull id<ZegoVideoCaptureClientDelegate>)client {
    NSLog(NSLocalizedString(@"%s", nil), __func__);
    
    self.client = client;
    [self.client setFillMode:ZegoVideoFillModeCrop];
}

- (void)zego_stopAndDeAllocate {
    NSLog(NSLocalizedString(@"%s", nil), __func__);
    [self destoryResource];
}

- (int)zego_startPreview {
    NSLog(NSLocalizedString(@"%s", nil), __func__);
    
    BOOL r = NO;
    if (self.onStartPreview) {
        r = self.onStartPreview();
    }
    if (r) {
        self.isPreview = YES;
    }
    return r?0:-1;
}

- (int)zego_stopPreview {
    NSLog(NSLocalizedString(@"%s", nil), __func__);
    
    if (self.onStopPreview) {
        self.onStopPreview();
    }
    self.isPreview = NO;
    return 0;
}

- (int)zego_startCapture {
    NSLog(NSLocalizedString(@"%s", nil), __func__);
    
    BOOL r = NO;
    if (self.onStartCapture) {
        r = self.onStartCapture();
    }
    if (r) {
        self.isCapture = YES;
    }
    return r?0:-1;
}

- (int)zego_stopCapture {
    NSLog(NSLocalizedString(@"%s", nil), __func__);
    
    [self stopCapture];
    return 0;
}

@end

#endif
