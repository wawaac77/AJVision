//
//  MMHomeViewController.h
//  FaceSDKDemo
//
//  Created by Alice Jin on 13/2/2018.
//  Copyright © 2018 Yang Yunxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMHomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *bgView_one;
@property (weak, nonatomic) IBOutlet UIView *bgView_two;
@property (weak, nonatomic) IBOutlet UIView *bgView_three;
@property (weak, nonatomic) IBOutlet UIView *bgView_four;
@property (weak, nonatomic) IBOutlet UIButton *button_one;
- (IBAction)buttonOneClicked:(id)sender;
- (IBAction)buttonTwoClicked:(id)sender;
- (IBAction)buttonThreeClicked:(id)sender;

- (IBAction)buttonFourClicked:(id)sender;

@end
