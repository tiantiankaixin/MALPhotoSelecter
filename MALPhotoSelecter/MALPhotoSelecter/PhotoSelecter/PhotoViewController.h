//
//  PhotoViewController.h
//  MALPhotoSelecter
//
//  Created by mal on 16/9/18.
//  Copyright © 2016年 mal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MPhotoType) {
    
    M_Library,
    M_Camera
};

@interface PhotoViewController : UIImagePickerController

@property (nonatomic, assign) MPhotoType photoType;
@property (nonatomic, copy) void(^selectPhotoBlock)(UIImage *);

+ (PhotoViewController *)photoVCWithType:(MPhotoType)type error:(NSError **)error;

@end
