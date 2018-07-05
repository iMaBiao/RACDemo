//
//  BookViewController.m
//  RACDemo
//
//  Created by Telit on 2018/7/5.
//  Copyright © 2018年 iMaBiao. All rights reserved.
//

#import "BookViewController.h"
#import "RequestViewModel.h"

@interface BookViewController ()

@property(nonatomic ,strong) UITableView *tableView;

@property(nonatomic ,strong) RequestViewModel *requestViewModel;
@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self.requestViewModel;
    
    // 执行请求
    RACSignal *requestSignal = [self.requestViewModel.requestCommand execute:nil];
    
    // 获取请求的数据
    [requestSignal subscribeNext:^(NSArray  *x) {
        self.requestViewModel.models = x;
        [self.tableView reloadData];
        
    }];
}



@end
