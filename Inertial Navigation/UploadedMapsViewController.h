//
//  UploadedMapsViewController.h
//  Inertial Navigation
//
//  Created by Kristen Kozmary on 10/3/16.
//  Copyright © 2016 koz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadedMapsViewController : UIViewController 
@property (nonatomic, strong) IBOutlet UIImageView *image;
@property (nonatomic, strong) UIImage *myImage;
@property (nonatomic, strong) IBOutlet UILabel *imageName;

@end
