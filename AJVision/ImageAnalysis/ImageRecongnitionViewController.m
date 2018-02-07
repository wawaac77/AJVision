//
//  ImageRecongnitionViewController.m
//  AJVision
//
//  Created by Alice Jin on 7/2/2018.
//  Copyright © 2018 Alice Jin. All rights reserved.
//

#import "ImageRecongnitionViewController.h"
#import "RequestTool.h"
#import "Macros.h"

@interface ImageRecongnitionViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSString *imageBase64;

@end

@implementation ImageRecongnitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

#pragma mark - ImagePicker
- (void)pickFromCamera {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)pickFromAlbum {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    self.imageBase64 = [self encodeToBase64String:chosenImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Base64
- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

#pragma mark - API
- (void)recongImage {
    NSDictionary *contentDic = @{@"content" : _imageBase64};
    NSDictionary *typeDic = @{@"type" : @"LABEL_DETECTION"};
    NSMutableArray *featuresArray = [[NSMutableArray alloc] initWithObjects:typeDic, nil];
    NSDictionary *requestDic = @{@"image" : contentDic,
                                 @"features" : featuresArray,
                                 };
    NSMutableArray *requestsArray = [[NSMutableArray alloc] initWithObjects:requestDic, nil];
    NSDictionary *dic = @{@"requests" : requestsArray};

    NSString *thisAPI = [NSString stringWithFormat:@"https://vision.googleapis.com/v1/images:annotate?key=%@", @"AIzaSyB5NJSCikP1fRJpI0PGfholA5lzMIi6Llc"];
    [RequestTool requestWithType:GET URL:thisAPI parameter:dic successComplete:^(id responseObject) {
        NSLog(@"responseObject %@", responseObject);
        NSString *result = [[[[responseObject objectAtIndex:0] objectForKey:@"labelAnnotations"] objectAtIndex:0] objectForKey:@"description"];
        NSLog(@"result %@", result);
        
    } failureComplete:^(NSError *error) {
    
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"400 fail"
                                   message:@"400 fail"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
}

#pragma mark - Button Clicked
- (IBAction)choosePhotoButtonClicked:(id)sender {
    [self pickFromAlbum];
}

- (IBAction)recongButtonClicked:(id)sender {
    if (self.imageBase64 == nil || self.imageBase64 == NULL || [self.imageBase64 isEqualToString:@""]) {
        
    } else {
        [self recongImage];
    }
}
@end
