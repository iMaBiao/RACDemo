//
//  LoginViewModel.h
//  RACDemo
//
//  Created by Telit on 2018/7/5.
//  Copyright © 2018年 iMaBiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "ReactiveObjC.h"
@interface LoginViewModel : NSObject

@property(nonatomic ,strong) Account *account;

// 是否允许登录的信号
@property(nonatomic ,strong , readonly) RACSignal *enableLoginSignal;
// 登录命令
@property(nonatomic ,strong , readonly) RACCommand *loginCommand;


@end
