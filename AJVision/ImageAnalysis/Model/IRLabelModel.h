//
//  IRLabelModel.h
//  AJVision
//
//  Created by Alice Jin on 7/2/2018.
//  Copyright © 2018 Alice Jin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IRLabelModel : NSObject

@property (strong, nonatomic) NSString *mid;
@property (strong, nonatomic) NSString *labelDescription;
@property (strong, nonatomic) NSString *score;
@property (strong, nonatomic) NSString *topicality;

@end
