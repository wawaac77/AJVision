//
//  FaceAnalysisViewController.h
//  AJVision
//
//  Created by Alice Jin on 8/2/2018.
//  Copyright © 2018 Alice Jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaceAnalysisViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;
@property (weak, nonatomic) IBOutlet UIButton *analyzeButton;
- (IBAction)photoButtonClicked:(id)sender;
- (IBAction)analyzeButtonClicked:(id)sender;


@end
