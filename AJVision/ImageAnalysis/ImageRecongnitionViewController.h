//
//  ImageRecongnitionViewController.h
//  AJVision
//
//  Created by Alice Jin on 7/2/2018.
//  Copyright © 2018 Alice Jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageRecongnitionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *choosePhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *recongButton;
@property (weak, nonatomic) IBOutlet UIView *ansView;

- (IBAction)choosePhotoButtonClicked:(id)sender;
- (IBAction)recongButtonClicked:(id)sender;

@end
