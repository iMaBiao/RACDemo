//
//  CalculateMaker.m
//  RACDemo
//
//  Created by Telit on 2018/5/28.
//  Copyright © 2018年 iMaBiao. All rights reserved.
//

#import "CalculateMaker.h"

@implementation CalculateMaker

- (CalculateMaker *(^)(int))add
{
    return ^CalculateMaker *(int value){
        self.result += value;
        return self;
    };
}
- (CalculateMaker *(^)(int))minus
{
    return ^CalculateMaker *(int value){
        self.result -= value;
        return self;
    };
}
- (CalculateMaker *(^)(int))mulity
{
    return ^CalculateMaker *(int value){
        self.result =  self->_result * value;
        return self;
    };
}
- (CalculateMaker *(^)(int))divide
{
    return ^CalculateMaker *(int value){
        self.result =  self->_result / value;
        return self;
    };
}



@end
