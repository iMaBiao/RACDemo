//
//  Book.h
//  RACDemo
//
//  Created by Telit on 2018/7/5.
//  Copyright © 2018年 iMaBiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property(nonatomic ,strong) NSString *title;
@property(nonatomic ,strong) NSString *subtitle;

+ (instancetype)bookWithDict:(NSDictionary *)dict;

@end
