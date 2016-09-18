//
//  UIImage+Circle.h
//  MusicPlayer
//
//  Created by tarena on 15/6/16.
//  Copyright (c) 2015年 tarena. All rights reserved.
//


//将图片切成圆形返回
#import <UIKit/UIKit.h>

@interface UIImage (Circle)

+(UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (UIImage *)circleImageWithImage:(UIImage *)sourceImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;


- (UIImage *)mal_circleImage;

//将一张图片变成指定的大小
//
//
//
+(UIImage *)scaleToSize:(UIImage *)image Size:(CGSize)size;

@end
