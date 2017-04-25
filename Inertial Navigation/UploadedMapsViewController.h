//
//  UploadedMapsViewController.h
//  Inertial Navigation
//
//  Created by Kristen Kozmary on 10/3/16.
//  Copyright © 2016 koz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailCell.h"

@interface UploadedMapsViewController : UIViewController

@property (nonatomic, strong) IBOutlet DetailCell *detailCell;
@property (nonatomic, strong) UIImage *image;

@end
