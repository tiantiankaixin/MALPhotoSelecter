//
//  ViewController.m
//  MALPhotoSelecter
//
//  Created by mal on 16/9/18.
//  Copyright © 2016年 mal. All rights reserved.
//

#import "ViewController.h"
#import "PhotoViewController.h"
#import "RSKImageCropper.h"
#import "UIImage+Circle.h"

@interface ViewController ()<RSKImageCropViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *showIM;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)btnClick:(UIButton *)sender
{
    PhotoViewController *photoVC = [[PhotoViewController alloc] init];
    photoVC.selectPhotoBlock = ^(UIImage *image){
        
        RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image];
        imageCropVC.delegate = self;
        [self.navigationController pushViewController:imageCropVC animated:YES];
    };
    if (sender.tag == 0)
    {
        photoVC.photoType = M_Library;
    }
    else if (sender.tag == 1)
    {
        photoVC.photoType = M_Camera;
    }
    [self presentViewController:photoVC animated:YES completion:nil];
}

// Crop image has been canceled.
- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}

// The original image has been cropped.
- (void)imageCropViewController:(RSKImageCropViewController *)controller
                   didCropImage:(UIImage *)croppedImage
                  usingCropRect:(CGRect)cropRect
{
    dispatch_async(dispatch_get_main_queue(), ^{
       
        self.showIM.image = [croppedImage mal_circleImage];
    });
    [self.navigationController popViewControllerAnimated:YES];
}

// The original image has been cropped. Additionally provides a rotation angle used to produce image.
- (void)imageCropViewController:(RSKImageCropViewController *)controller
                   didCropImage:(UIImage *)croppedImage
                  usingCropRect:(CGRect)cropRect
                  rotationAngle:(CGFloat)rotationAngle
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.showIM.image = [croppedImage mal_circleImage];
    });
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
