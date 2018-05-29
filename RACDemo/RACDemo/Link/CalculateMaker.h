//
//  CalculateMaker.h
//  RACDemo
//
//  Created by Telit on 2018/5/28.
//  Copyright © 2018年 iMaBiao. All rights reserved.


#import <Foundation/Foundation.h>

@interface CalculateMaker : NSObject

@property(nonatomic ,assign) int  result;

//  链式编程
///  +  -  *  /
- (CalculateMaker *(^)(int))add;
- (CalculateMaker *(^)(int))minus;
- (CalculateMaker *(^)(int))mulity;
- (CalculateMaker *(^)(int))divide;



//函数式
@property(nonatomic ,assign) BOOL isEqual;

- (CalculateMaker *)calculator: (int (^)(int result))calculator;
                                 
- (CalculateMaker *)equal:(BOOL (^)(int result))operation;
@end
