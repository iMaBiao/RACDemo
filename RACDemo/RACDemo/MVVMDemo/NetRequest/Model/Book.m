//
//  Book.m
//  RACDemo
//
//  Created by Telit on 2018/7/5.
//  Copyright © 2018年 iMaBiao. All rights reserved.
//

#import "Book.h"

@implementation Book


+ (instancetype)bookWithDict:(NSDictionary *)dict
{
    Book *book = [[Book alloc]init];
    
    [book setValuesForKeysWithDictionary:dict];
    
    return book;
}

@end
