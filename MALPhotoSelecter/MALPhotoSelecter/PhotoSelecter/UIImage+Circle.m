//
//  UIImage+Circle.m
//  MusicPlayer
//
//  Created by tarena on 15/6/16.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "UIImage+Circle.h"

@implementation UIImage (Circle)

//根据指定的图片的文件名 获取一张圆形的图片对象 并加边框
//@param name是图片文件名
//@param
//
+ (UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    //1. 开启上下文
    UIImage *sourceImage = [UIImage imageNamed:name];
    return [self circleImageWithImage:sourceImage borderWidth:borderWidth borderColor:borderColor];
}


+ (UIImage *)circleImageWithImage:(UIImage *)sourceImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    CGFloat imageWidth = sourceImage.size.width +2*borderWidth;
    CGFloat imageHeight = sourceImage.size.height +2*borderWidth;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeight), NO, 0);
    
    //2.获取上下文
    UIGraphicsGetCurrentContext();
    
    //3.画图
    CGFloat radius = MIN(sourceImage.size.width, sourceImage.size.height)*0.5;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageWidth*0.5, imageHeight*0.5) radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    bezierPath.lineWidth = borderWidth;
    [borderColor setStroke];
    [bezierPath stroke];
    //4.使用BezierPath剪切
    [bezierPath addClip];
    //5.画图
    [sourceImage drawInRect:CGRectMake(borderWidth, borderWidth, sourceImage.size.width, sourceImage.size.height)];
    
    //6.从内存中创建图片对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //7.结束上下文
    UIGraphicsEndImageContext();
    return newImage;


}

+(UIImage *)scaleToSize:(UIImage *)image Size:(CGSize)size{

    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;

}

- (UIImage *)mal_circleImage
{
    // 开始图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 设置一个范围
    //CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGSize imSize = self.size;
    CGFloat minSize = MIN(self.size.width, self.size.height);
    CGRect clipRect = CGRectMake(imSize.width / 2 - minSize / 2, imSize.height / 2 - minSize / 2, minSize, minSize);
    // 根据一个rect创建一个椭圆
    CGContextAddEllipseInRect(ctx, clipRect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 将原照片画到图形上下文
    [self drawInRect:clipRect];
    
    // 从上下文上获取剪裁后的照片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
