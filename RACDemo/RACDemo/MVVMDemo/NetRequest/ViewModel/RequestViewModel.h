//
//  RequestViewModel.h
//  RACDemo
//
//  Created by Telit on 2018/7/5.
//  Copyright © 2018年 iMaBiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"
#import "AFNetworking.h"
#import "Book.h"

@interface RequestViewModel : NSObject<UITableViewDataSource>

// 请求命令
@property(nonatomic ,strong) RACCommand *requestCommand;
//模型数组
@property(nonatomic ,strong) NSArray *models;


@end
