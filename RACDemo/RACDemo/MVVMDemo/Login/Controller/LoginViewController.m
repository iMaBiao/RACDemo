//
//  LoginViewController.m
//  RACDemo
//
//  Created by Telit on 2018/7/5.
//  Copyright © 2018年 iMaBiao. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"


@interface LoginViewController ()

@property(nonatomic ,strong) LoginViewModel *loginViewModel;

@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self bindModel];
}
// 视图模型绑定
- (void)bindModel
{
    //RAC(TARGET, [KEYPATH, [NIL_VALUE]]):用于给某个对象的某个属性绑定。
    // 给模型的属性绑定信号
    // 只要账号文本框一改变，就会给account赋值
    RAC(self.loginViewModel.account ,account) = _accountField.rac_textSignal;
    RAC(self.loginViewModel.account, pwd) = _pwdField.rac_textSignal;
    
    // 绑定登录按钮
    RAC(self.loginBtn,enabled) = self.loginViewModel.enableLoginSignal;
    
    // 监听登录按钮点击
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        // 执行登录事件
        [self.loginViewModel.loginCommand execute:nil];
    }];
    
}

- (LoginViewModel *)loginViewModel
{
    if(!_loginViewModel){
        _loginViewModel = [[LoginViewModel alloc]init];
    }
    return _loginViewModel;
}



@end
