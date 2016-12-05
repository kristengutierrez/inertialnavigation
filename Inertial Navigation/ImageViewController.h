//
//  ImageViewController.h
//  Inertial Navigation
//
//  Created by Kristen Kozmary on 11/17/16.
//  Copyright © 2016 koz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UploadedMapsViewController.h"

@interface ImageViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UploadedMapsViewController *uploadedMapsView;

//-(IBAction)sendImage:(id)sender;
@end
