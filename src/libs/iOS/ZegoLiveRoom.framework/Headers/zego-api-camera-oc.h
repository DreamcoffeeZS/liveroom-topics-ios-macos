//
//  zego_camera_ios.h
//  zegoavkit
//
//  Created by summeryxia on 2018/04/11.
//  Copyright © 2018年 Zego. All rights reserved.
//

#ifndef zego_api_camera_oc_h
#define zego_api_camera_oc_h

#import <Foundation/Foundation.h>
#import "zego-api-defines-oc.h"

@interface ZegoCamera : NSObject

/**
 设置设备坐标中的曝光参考点
 
 @warning Deprecated 请使用 [setCamExposurePointInPreview:channelIndex:] 代替
 
 @param point 坐标点的 x 和 y 的取值范围均为 [0.0, 1.0]. 坐标是对应于设备的归一化的坐标, 左上角坐标为 (0.0, 0.0)，右下角坐标为(1.0, 1.0)
 @param index 推流通道
 @attention 必须在初始化 SDK 后调用
 */
+ (BOOL)setCamExposurePoint:(CGPoint)point channelIndex:(ZegoAPIPublishChannelIndex)index;

/**
 设置预览视图中的对焦点
 
 @param point 坐标点的 x 和 y 的取值范围均为 [0.0, 1.0]. 坐标是对应于视图的归一化的坐标，左上角是(0.0, 0.0), 右下角是 (1.0, 1.0)
 @param index 推流通道
 @return true 成功，false 失败
 @attention 每次摄像头重新启动采集，设置都会失效，需要重新设置.
 @attention 如果要使用对焦功能最好关闭人脸识别，目前 iOS 是默认开启的, 通过 setConfig 接口设置 "camera_detect_face=false" 关闭.
 */
+ (BOOL)setCamFocusPointInPreview:(CGPoint)point channelIndex:(ZegoAPIPublishChannelIndex)index;

/**
 设置预览视图中的曝光参考点
 
 @param point 坐标点的 x 和 y 的取值范围均为 [0.0, 1.0]. 坐标是对应于视图的归一化的坐标，左上角是(0.0, 0.0), 右下角是 (1.0, 1.0)
 @param index 推流通道
 @return true 成功，false 失败
 @attention 每次摄像头重新启动采集，设置都会失效，需要重新设置.
 */
+ (BOOL)setCamExposurePointInPreview:(CGPoint)point channelIndex:(ZegoAPIPublishChannelIndex)index;

/**
 设置摄像头变焦倍数
 
 @param zoomFactor 变焦倍数，最小值为1.0，最大值不能超过 getCamMaxZoomFactor: 的返回值
 @param index 推流通道
 @return true 成功，false 失败
 @attention 每次摄像头重新启动采集，设置都会失效，需要重新设置.
 */
+ (BOOL)setCamZoomFactor:(float)zoomFactor channelIndex:(ZegoAPIPublishChannelIndex)index;

/**
 获取摄像头最大变焦倍数
 
 @param index 推流通道
 @return 返回最大变焦倍数，1.0为不支持变焦
 */
+ (float)getCamMaxZoomFactor:(ZegoAPIPublishChannelIndex)index;

/**
 设置曝光补偿度
 
 @param value 曝光度，取值范围为[-1,1], -1变黑, 1变亮
 @param index 推流通道
 @return true 成功，false 失败
 @discussion 必须在初始化 SDK 后调用
 */
+ (BOOL)setCamExposureCompensation:(float)value channelIndex:(ZegoAPIPublishChannelIndex)index;
@end

#endif
