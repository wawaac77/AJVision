//
//  MMHomeViewController.m
//  FaceSDKDemo
//
//  Created by Alice Jin on 13/2/2018.
//  Copyright © 2018 Yang Yunxing. All rights reserved.
//

#import "MMHomeViewController.h"
#import "FCDetectViewController.h"
#import "FCmergefaceViewController.h"
#import "FCCompareViewController.h"
#import "FCBodySegmentViewController.h"

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
    self.navigationItem.title = @"魔镜魔镜";
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_background.png"] forBarMetrics:UIBarMetricsDefault];
    //[self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;

    _bgView_one.layer.cornerRadius = 10.0f;
    _bgView_two.layer.cornerRadius = 10.0f;
    _bgView_three.layer.cornerRadius = 10.0f;
    _bgView_four.layer.cornerRadius = 10.0f;
}

#pragma mark - Functions
- (void)detectFace{
    FCDetectViewController *detectVC = [[FCDetectViewController alloc] init];
    detectVC.image = [UIImage imageNamed:@"detect_demo.jpg"];
    detectVC.view.frame = [UIScreen mainScreen].bounds;
    [self.navigationController pushViewController:detectVC animated:YES];
}

-(void)mergeface{
    FCmergefaceViewController* mergefaceVC = [[FCmergefaceViewController alloc]init];
    [self.navigationController pushViewController:mergefaceVC animated:YES];
}

- (void)compareFace{
    FCCompareViewController *comapareVC = [[FCCompareViewController alloc] init];
    [self.navigationController pushViewController:comapareVC animated:YES];
}

- (void)bodySegment{
    FCBodySegmentViewController *bodyVC = [[FCBodySegmentViewController alloc] init];
    bodyVC.image = [UIImage imageNamed:@"body.jpg"];
    [self.navigationController pushViewController:bodyVC animated:YES];
}

#pragma mark - Button Clicked
- (IBAction)buttonOneClicked:(id)sender {
    [self detectFace];
}

- (IBAction)buttonTwoClicked:(id)sender {
    [self mergeface];
}

- (IBAction)buttonThreeClicked:(id)sender {
    [self compareFace];
}
- (IBAction)buttonFourClicked:(id)sender {
    [self bodySegment];
}
@end
