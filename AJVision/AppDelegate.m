//
//  AppDelegate.m
//  AJVision
//
//  Created by Alice Jin on 6/2/2018.
//  Copyright © 2018 Alice Jin. All rights reserved.
//

#import "AppDelegate.h"
#import "ImageRecongnitionViewController.h"
<<<<<<< HEAD
#import "MMHomeViewController.h"

=======
>>>>>>> parent of 7b65de9... tried a lot how to call api
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
<<<<<<< HEAD
    // Root View Controller
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.delegate = self;
    tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    tabBarController.tabBar.tintColor = [UIColor blackColor];

    ImageRecongnitionViewController *imageRecongVC = [[ImageRecongnitionViewController alloc] init];
    UINavigationController *imageNav = [[UINavigationController alloc] initWithRootViewController:imageRecongVC];
    imageRecongVC.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    imageRecongVC.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [imageRecongVC.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],  NSFontAttributeName:[UIFont fontWithName:@"Helvetica Neue" size:21]}];
    
    imageNav.navigationBar.translucent = NO;
    [imageNav.navigationBar setBackgroundImage:[[UIImage imageNamed:@"010_painting"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
    
    UITabBarItem *imageBarItem=[[UITabBarItem alloc]initWithTitle:@"Image" image:[UIImage imageNamed:@"010_painting"] selectedImage:[[UIImage imageNamed:@"010_painting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [imageBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
    [imageBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:1.0f green:0.847f blue:0.208f alpha:1.0f]} forState:UIControlStateSelected];
    imageNav.tabBarItem = imageBarItem;

    
    MMHomeViewController *faceVC = [[MMHomeViewController alloc] init];
    UINavigationController *faceNav = [[UINavigationController alloc] initWithRootViewController:faceVC];
    faceVC.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    faceVC.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [faceNav.navigationBar setBackgroundImage:[[UIImage imageNamed:@"004_dancer"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
    UITabBarItem *faceBarItem=[[UITabBarItem alloc]initWithTitle:@"Face" image:[UIImage imageNamed:@"004_dancer"] selectedImage:[[UIImage imageNamed:@"004_dancer"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [faceBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
    [faceBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:1.0f green:0.847f blue:0.208f alpha:1.0f]} forState:UIControlStateSelected];
    faceNav.tabBarItem = faceBarItem;
    
    NSArray *ncArr = @[imageNav, faceNav];
    tabBarController.viewControllers = ncArr;
     
    self.window.rootViewController = tabBarController;
=======
    UIViewController *imageRecongVC = [[ImageRecongnitionViewController alloc] init];
    imageRecongVC.view.frame = [UIScreen mainScreen].bounds;
    self.window.rootViewController = imageRecongVC;
>>>>>>> parent of 7b65de9... tried a lot how to call api
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
