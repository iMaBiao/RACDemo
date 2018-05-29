//
//  RedView.m
//  RACDemo
//
//  Created by Telit on 2018/5/29.
//  Copyright © 2018年 iMaBiao. All rights reserved.
//

#import "RedView.h"

@interface RedView()

@property(nonatomic ,strong) UIButton *redBtn;

@end

@implementation RedView

- (instancetype)init
{
    if (self = [super init]) {
        _redBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _redBtn.backgroundColor = [UIColor orangeColor];
        [self addSubview:_redBtn];
        [_redBtn addTarget:self action:@selector(redBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.redBtn.frame = self.bounds;
    self.redBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)redBtnClick:(UIButton *)btn
{
    NSLog(@"%s 点击了RedView的RedBtn", __FUNCTION__);
}
@end
