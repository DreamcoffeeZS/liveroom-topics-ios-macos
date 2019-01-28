//
//  ZGExternalVideoCapturePreviewHelper.m
//  LiveRoomPlayground-iOS
//
//  Created by Sky on 2019/1/23.
//  Copyright © 2019 Zego. All rights reserved.
//

#import "ZGExternalVideoCapturePreviewHelper.h"

@implementation ZGExternalVideoCapturePreviewHelper

+ (void)showCaptureData:(CVImageBufferRef)image inView:(ZGView *)view viewMode:(ZegoVideoViewMode)viewMode {
    CGImageRef cgImage = [self getCGImageFromCVImageBuffer:image inView:view viewMode:viewMode];
    CGImageRetain(cgImage);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        view.layer.contents = CFBridgingRelease(cgImage);
        CGImageRelease(cgImage);
        
        CALayerContentsGravity contentViewMode = nil;
        switch (viewMode) {
            case ZegoVideoViewModeScaleToFill:{
                contentViewMode = kCAGravityResize;
                break;
            }
            case ZegoVideoViewModeScaleAspectFit:{
                contentViewMode = kCAGravityResizeAspect;
                break;
            }
            case ZegoVideoViewModeScaleAspectFill:{
                contentViewMode = kCAGravityResizeAspectFill;
                break;
            }
        }
        view.layer.contentsGravity = contentViewMode;
    });
    
}

+ (void)removeCaptureDataInView:(ZGView *)view {
    dispatch_async(dispatch_get_main_queue(), ^{
        view.layer.contents = nil;
    });
}

+ (CGImageRef)getCGImageFromCVImageBuffer:(CVImageBufferRef)imageBuffer inView:(ZGView *)view viewMode:(ZegoVideoViewMode)viewMode {
    CVPixelBufferLockBaseAddress(imageBuffer, kCVPixelBufferLock_ReadOnly);
    
    CIImage *ciImage = [CIImage imageWithCVPixelBuffer:imageBuffer];
    CIContext *temporaryContext = [CIContext contextWithOptions:nil];
    CGImageRef videoImage = [temporaryContext createCGImage:ciImage fromRect:CGRectMake(0, 0, CVPixelBufferGetWidth(imageBuffer), CVPixelBufferGetHeight(imageBuffer))];
    
    CVPixelBufferUnlockBaseAddress(imageBuffer, kCVPixelBufferLock_ReadOnly);
    
    return videoImage;
}

@end
