//
//  CalculateManager.m
//  RACDemo
//
//  Created by Telit on 2018/5/29.
//  Copyright © 2018年 iMaBiao. All rights reserved.
//

#import "CalculateManager.h"
#import "CalculateMaker.h"

@implementation CalculateManager

+ (int)makeCalculators: (void (^)(CalculateMaker *maker))block
{
    CalculateMaker *maker = [[CalculateMaker alloc]init];
    block(maker);
    return maker.result;
}

@end
