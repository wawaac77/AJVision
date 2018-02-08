//
//  ImageRecongnitionViewController.m
//  AJVision
//
//  Created by Alice Jin on 7/2/2018.
//  Copyright © 2018 Alice Jin. All rights reserved.
//

#import "ImageRecongnitionViewController.h"
#import "IRLabelModel.h"

@interface ImageRecongnitionViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSString *imageBase64;
@property (strong, nonatomic) NSMutableArray<IRLabelModel *> *resultLabelArray;

@end

@implementation ImageRecongnitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpDisplay];
    self.resultLabelArray = [NSMutableArray new];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

- (void)setUpDisplay {
    self.imageView.clipsToBounds = YES;
    self.choosePhotoButton.layer.cornerRadius = 4.0f;
    self.recongButton.layer.cornerRadius = 4.0f;
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
    NSLog(@"start to call API");
    NSDictionary *contentDic = @{@"content" : _imageBase64};
    NSDictionary *typeDic = @{@"type" : @"LABEL_DETECTION"};
    NSMutableArray *featuresArray = [[NSMutableArray alloc] initWithObjects:typeDic, nil];
    NSDictionary *requestDic = @{@"image" : contentDic,
                                 @"features" : featuresArray,
                                 };
    NSMutableArray *requestsArray = [[NSMutableArray alloc] initWithObjects:requestDic, nil];
    NSDictionary *dic = @{@"requests" : requestsArray};

    NSString *thisAPI = [NSString stringWithFormat:@"https://vision.googleapis.com/v1/images:annotate?key=%@", @"AIzaSyB5NJSCikP1fRJpI0PGfholA5lzMIi6Llc"];
    [RequestTool requestWithType:POST URL:thisAPI parameter:dic successComplete:^(id responseObject) {
        NSLog(@"responseObject %@", responseObject);
        NSMutableArray *responses = [responseObject objectForKey:@"responses"];
        NSMutableArray *labelAnnotationsArray = [NSDictionary mj_objectArrayWithKeyValuesArray:responses];
        self.resultLabelArray = [IRLabelModel mj_objectArrayWithKeyValuesArray:[labelAnnotationsArray[0] objectForKey:@"labelAnnotations"]];
        [self displayResultLabels];
        
        
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

#pragma mark - Display Result
- (void)displayResultLabels {
    //self.ansView = [UIView new];
    UIView *ansView = [[UIView alloc] init];
    ansView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ansView];
    [ansView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.recongButton.mas_bottom).offset(10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
    }];
    
    float x = 0;
    float y = 0;
    float height = 30;
    float margin = 5;
    for (int i = 0; i < _resultLabelArray.count; i ++) {
        UILabel *label = [UILabel new];
        [ansView addSubview:label];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor groupTableViewBackgroundColor];
        label.clipsToBounds = YES;
        label.layer.cornerRadius = 4.0f;
        
        NSString *text = _resultLabelArray[i].labelDescription;
        label.text = text;
        float width = label.intrinsicContentSize.width + margin * 2;
        if (x + width >= ScreenW - 20) {
            x = 0;
            y = y + height + margin;
        }
        label.frame = CGRectMake(x, y, width, height);
        x = x + width + margin;
    }
}

#pragma mark - Calculate
- (CGFloat)getTextHeight:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
    CGSize textMaxSize = CGSizeMake(width, MAXFLOAT);
    CGSize textSize = [text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return textSize.height;
}

#pragma mark - Button Clicked
- (IBAction)choosePhotoButtonClicked:(id)sender {
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Choose Your Photo"
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
    [self pickFromAlbum];
}

- (IBAction)recongButtonClicked:(id)sender {
    if (self.imageBase64 == nil || self.imageBase64 == NULL || [self.imageBase64 isEqualToString:@""]) {
        
    } else {
        [self recongImage];
    }
}
@end
