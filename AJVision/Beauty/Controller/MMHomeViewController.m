//
//  MMHomeViewController.m
//  FaceSDKDemo
//
//  Created by Alice Jin on 13/2/2018.
//  Copyright © 2018 Yang Yunxing. All rights reserved.
//

#import "MMHomeViewController.h"
#import "FCDetectViewController.h"

@interface MMHomeViewController ()

@end

@implementation MMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpLayout {
    _bgView_one.layer.cornerRadius = 10.0f;
    _bgView_two.layer.cornerRadius = 10.0f;
    _bgView_three.layer.cornerRadius = 10.0f;
    _bgView_four.layer.cornerRadius = 10.0f;
}

- (void)detectFace{
    NSLog(@"should push detect VC");
    
    FCDetectViewController *detectVC = [[FCDetectViewController alloc] init];
    detectVC.image = [UIImage imageNamed:@"detect_demo.jpg"];
    detectVC.view.frame = [UIScreen mainScreen].bounds;
    [self.navigationController pushViewController:detectVC animated:YES];
     
    
//    MMDetectViewController *detectVC = [[MMDetectViewController alloc] initWithNibName:@"MMDetectViewController" bundle:[NSBundle mainBundle]];
//    [detectVC.view setFrame:self.view.frame];
//    [self.navigationController presentViewController:detectVC animated:YES completion:nil];
}

#pragma mark - Button Clicked
- (IBAction)buttonOneClicked:(id)sender {
    NSLog(@"button one clicked");
    [self detectFace];
}
@end
