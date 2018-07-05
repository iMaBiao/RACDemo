//
//  RequestViewModel.m
//  RACDemo
//
//  Created by Telit on 2018/7/5.
//  Copyright © 2018年 iMaBiao. All rights reserved.
//

#import "RequestViewModel.h"

@implementation RequestViewModel

- (instancetype)init
{
    if(self = [super init]){
        [self initialBind];
    }
    return self;
}

- (void)initialBind
{
    _requestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            NSString *url = @"https://api.douban.com/v2/book/search";
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"q"] = @"基础";
            
            [[AFHTTPSessionManager manager]GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSLog(@"%@",responseObject);
                
                // 请求成功
                
                // 把数据用信号传递出去
                [subscriber sendNext:responseObject];
                
                [subscriber sendCompleted];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
            return nil;
        }];
        
         // 在返回数据信号时，把数据中的字典映射成模型信号，传递出去
        return [requestSignal map:^id _Nullable(id  _Nullable value) {
            NSMutableArray *dictArray = value[@"books"];
            
             // 字典转模型，遍历字典中的所有元素，全部映射成模型，并且生成数组
            NSArray *modelArr = [[dictArray.rac_sequence map:^id _Nullable(id  _Nullable value) {
                return [Book bookWithDict:value];
            }] array];
            
            return modelArr;
        }];

    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    Book *book = self.models[indexPath.row];
    cell.detailTextLabel.text = book.subtitle;
    cell.textLabel.text = book.title;
    
    return cell;
}
@end
