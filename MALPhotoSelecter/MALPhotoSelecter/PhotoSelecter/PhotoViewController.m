//
//  PhotoViewController.m
//  MALPhotoSelecter
//
//  Created by mal on 16/9/18.
//  Copyright © 2016年 mal. All rights reserved.
//

#import "PhotoViewController.h"
#import "RSKImageCropper.h"
#import <Photos/Photos.h>

#define IOS_VERSION [UIDevice currentDevice].systemVersion.floatValue

@interface PhotoViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation PhotoViewController

+ (PhotoViewController *)photoVCWithType:(MPhotoType)type error:(NSError **)error
{
    PhotoViewController *photoVC = [[PhotoViewController alloc] init];
    if (type == M_Library)
    {
        if([self isPhotoLibraryAvailable])
        {
            photoVC.photoType = M_Library;
        }
        else
        {
           
        }
    }
    else if (type == M_Camera)
    {
        if ([self isCameraAvailable])
        {
            photoVC.photoType = M_Camera;
        }
        else
        {
            
        }
    }
    return photoVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)setPhotoType:(MPhotoType)photoType
{
    _photoType = photoType;
    if (photoType == M_Library)
    {
        self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else if (photoType == M_Camera)
    {
        self.sourceType = UIImagePickerControllerSourceTypeCamera;
        NSArray *temp_MediaTypes = @[@"public.image"];
        self.mediaTypes = temp_MediaTypes;
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"])
    {
        UIImage *image = (UIImage *)[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        if (self.selectPhotoBlock)
        {
            self.selectPhotoBlock(image);
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 相册是否可用
+ (BOOL)isPhotoLibraryAvailable
{
    BOOL available = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    if (IOS_VERSION >= 8.0 && available)
    {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)
        {
            available = NO;
        }
    }
    return available;
}

// 摄像头是否可用
+ (BOOL)isCameraAvailable
{
    BOOL available = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (available && IOS_VERSION >= 7.0)
    {
        AVAuthorizationStatus capStatue = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(capStatue == AVAuthorizationStatusDenied || capStatue == AVAuthorizationStatusRestricted)
        {
            available = NO;
        }
    }
    return available;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
