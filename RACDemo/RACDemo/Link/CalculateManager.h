//
//  CalculateManager.h
//  RACDemo
//
//  Created by Telit on 2018/5/29.
//  Copyright © 2018年 iMaBiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CalculateMaker;

@interface CalculateManager : NSObject

+ (int)makeCalculators: (void (^)(CalculateMaker *maker))block;

@end
