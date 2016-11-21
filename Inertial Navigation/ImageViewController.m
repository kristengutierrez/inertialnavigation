//
//  ImageViewController.m
//  Inertial Navigation
//
//  Created by Kristen Kozmary on 11/17/16.
//  Copyright © 2016 koz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>


@interface ImageViewController ()



@end

@implementation ImageViewController


- (void)viewDidLoad {
  [super viewDidLoad];

  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
  {
    UIImagePickerController *imagePicker =
    [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType =
    UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.mediaTypes = [NSArray arrayWithObjects:
                              (NSString *) kUTTypeImage,
                              nil];
    
    imagePicker.allowsEditing = YES;
    
    //imagePicker.wantsFullScreenLayout = YES;
    

    [self presentViewController:imagePicker animated:YES completion:nil];
    //newMedia = YES;
    //iscamera = 0;
  }
  
  
  
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (IBAction)selectPhoto:(id)sender {
  
  
  UIAlertController *namePhoto = [UIAlertController alertControllerWithTitle:nil message:@"Please name this photo" preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    [namePhoto dismissViewControllerAnimated:YES completion:nil];
    [[self navigationController] popViewControllerAnimated:YES];
  }];
  [namePhoto addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
  }];
  
  UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    [namePhoto dismissViewControllerAnimated:YES completion:nil];
  }];
  [namePhoto addAction:ok];
  [namePhoto addAction:cancel];
  [self presentViewController:namePhoto animated:YES completion:nil];
  

  UIImagePickerController *picker = [[UIImagePickerController alloc] init];
  picker.delegate = self;
  picker.allowsEditing = YES;
  picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
  self.imageView.image = selectedImage;
  [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [picker dismissViewControllerAnimated:YES completion:NULL];
}









@end
