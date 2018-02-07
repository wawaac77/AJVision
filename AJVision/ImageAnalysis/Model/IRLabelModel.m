//
//  IRLabelModel.m
//  AJVision
//
//  Created by Alice Jin on 7/2/2018.
//  Copyright © 2018 Alice Jin. All rights reserved.
//

#import "IRLabelModel.h"

@implementation IRLabelModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"labelDescription" : @"description",
             };
}

@end
