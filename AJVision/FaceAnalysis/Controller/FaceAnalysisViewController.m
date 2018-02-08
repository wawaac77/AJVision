//
//  FaceAnalysisViewController.m
//  AJVision
//
//  Created by Alice Jin on 8/2/2018.
//  Copyright © 2018 Alice Jin. All rights reserved.
//

#import "FaceAnalysisViewController.h"
#import "GFHTTPSessionManager.h"

@interface FaceAnalysisViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSString *imageBase64;
@property (strong, nonnull) UIImage *chosenImage;

@end

@implementation FaceAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLayout];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Layout
- (void)setUpLayout {
    self.photoButton.layer.cornerRadius = 4.0f;
    self.analyzeButton.layer.cornerRadius = 4.0f;
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
    self.chosenImage = chosenImage;
    self.imageView.image = chosenImage;
    self.imageBase64 = [self encodeToBase64String:chosenImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Base64
- (NSString *)encodeToBase64String:(UIImage *)image {
    NSData * data = [UIImagePNGRepresentation(image) base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return [NSString stringWithUTF8String:[data bytes]];
    //return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

#pragma mark - API
- (void)recongImage {
  
    NSString *attributesString = @"gender,age,beauty";
    NSMutableArray *attributesArray = [[NSMutableArray alloc] initWithObjects:@"gender", @"age", @"smiling", @"headpose", @"facequality", @"blur", @"eyestatus", @"emotion", @"ethnicity", @"beauty", @"mouthstatus", @"eyegaze", @"skinstatus", nil];
    NSDictionary *dic = @{
                          @"api_key" : @"hwMnzFXLOpPq79ZbzVnkveJQdMH_dZi9",
                          @"api_secret" : @"WGj7ODShnK7a2o-zXFSgmFnQbKnpP8bV",
                          @"image_base64" : _imageBase64,
                          @"return_landmark" : @2,
                          @"return_attributes" : attributesString,
                          };
    
    NSString *thisAPI = [NSString stringWithFormat:@"https://api-cn.faceplusplus.com/facepp/v3/detect"];
    [RequestTool requestWithType:POST URL:thisAPI parameter:dic successComplete:^(id responseObject) {
        NSLog(@"responseObject %@", responseObject);
     
    } failureComplete:^(NSError *error) {
        NSLog(@"error %@", error);
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

- (void)recongFace_two {
    NSLog(@"start to call API");
    NSString *attributesString = @"gender,age,beauty";
    NSString *apiKey = @"hwMnzFXLOpPq79ZbzVnkveJQdMH_dZi9";
    NSString *apiSecret = @"WGj7ODShnK7a2o-zXFSgmFnQbKnpP8bV";
    NSNumber *returnLandmark = @1;
  
    
    //NSString *imageURL = @"https://bslizon.github.io/gakkismile.jpg";
    NSData *imageData = UIImagePNGRepresentation(_chosenImage);
    
    //NSString *strPostValues = [NSString stringWithFormat:@"image_file=%@&return_landmark=%@&return_attributes=%@", imageData, returnLandmark, attributesString];
    NSString *strPostValues = [NSString stringWithFormat:@"image_base64=%@&return_landmark=%@&return_attributes=%@", _imageBase64, returnLandmark, attributesString];
    //NSString *strPostValues = [NSString stringWithFormat:@"return_landmark=%@&return_attributes=%@", returnLandmark, attributesString];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[strPostValues length]];
    NSData *postData = [strPostValues dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];

   
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://api-cn.faceplusplus.com/facepp/v3/detect?api_key=%@&api_secret=%@", apiKey, apiSecret]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //[req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //[request setValue:@"Multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    
    
    //NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://api-cn.faceplusplus.com/facepp/v3/detect"]];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];


    /*
    [req addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Accept"];
    [req addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    req.HTTPMethod = @"POST";
     */
    
//    NSDictionary *parameters = @{
//                                 @"image_base64" : _imageBase64,
//                                 @"return_landmark" : @2,
//                                 @"return_attributes" : attributesString,
//                                 };
//
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        NSLog(@"data %@", data);
        NSLog(@"response %@", response);
        if (data) {
            
            NSError *errorJson = nil;
            NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorJson];
            if (responseDict) {
                NSLog(@"responseDict %@", responseDict);
                
            } else {
                NSLog(@"responseDict empty");
            }
        } else {
            // Cant connect to server
            NSLog(@"cannot connect to server");
           
        }
    
    }];
    
    [dataTask resume];
}


- (void)recongImage_three {
    
    NSString *attributesString = @"gender,age,beauty";
    NSDictionary *dic = @{
                          @"api_key" : @"hwMnzFXLOpPq79ZbzVnkveJQdMH_dZi9",
                          @"api_secret" : @"WGj7ODShnK7a2o-zXFSgmFnQbKnpP8bV",
                          @"image_base64" : _imageBase64,
                          @"return_landmark" : @2,
                          @"return_attributes" : attributesString,
                          };
    
    //NSString *thisAPI = [NSString stringWithFormat:@"https://api-cn.faceplusplus.com/facepp/v3/detect"];
    NSString *thisAPI = @"https://api-cn.faceplusplus.com/facepp/v3/detect";
    
    [[GFHTTPSessionManager shareManager] POSTWithURLString:thisAPI parameters:dic success:^(id data) {
    
        NSLog(@"data %@", data);
        
    } failed:^(NSError *error) {
        NSLog(@"error %@", error);
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

#pragma mark - Recong 4
- (void)recongImage_four {
    
    NSString *attributesString = @"gender,age,beauty";
    NSString *apiKey = @"hwMnzFXLOpPq79ZbzVnkveJQdMH_dZi9";
    NSString *apiSecret = @"WGj7ODShnK7a2o-zXFSgmFnQbKnpP8bV";
    NSNumber *returnLandmark = @1;
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://api-cn.faceplusplus.com/facepp/v3/detect?api_key=%@&api_secret=%@&return_landmark=%@&return_attributes=%@", apiKey, apiSecret, returnLandmark, attributesString]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *imageData = UIImageJPEGRepresentation(_chosenImage, 1.0);
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"unique-consistent-string";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@\r\n\r\n", @"imageCaption"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", @"Some Caption"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // add image data
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@; filename=imageName.jpg\r\n", @"imageFormKey"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = @{
                                                   @"Authorization" : [@"Bearer " stringByAppendingString:@"Happy Authorization"],
                                                   @"Content-Type"  : [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary]
                                                   };
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:nil delegateQueue:nil];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"data %@", data);
        NSLog(@"response %@", response);

    }];
    [dataTask resume];
}

#pragma mark - Button Clicked
- (IBAction)photoButtonClicked:(id)sender {
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Photo"
                               message:NULL
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* album = [UIAlertAction actionWithTitle:@"Choose from Album" style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * action) {
                                                      [self pickFromAlbum];
                                                      [alert dismissViewControllerAnimated:YES completion:nil];
                                                  }];
    
    UIAlertAction* camera = [UIAlertAction actionWithTitle:@"Take a Photo" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [self pickFromCamera];
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    [alert addAction:album];
    [alert addAction:camera];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)analyzeButtonClicked:(id)sender {
    if (self.imageBase64 == nil || self.imageBase64 == NULL || [self.imageBase64 isEqualToString:@""]) {
        
    } else {
        [self recongFace_two];
    }
}
@end
