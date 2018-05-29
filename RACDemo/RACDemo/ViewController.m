//
//  ViewController.m
//  RACDemo
//
//  Created by Telit on 2018/5/28.
//  Copyright © 2018年 iMaBiao. All rights reserved.
//

#import "ViewController.h"
#import "CalculateManager.h"
#import "CalculateMaker.h"
#import "ReactiveObjC.h"
#import "RedView.h"

@interface ViewController ()

@property(nonatomic ,strong) RedView *redView;

@property(nonatomic ,assign) int num;

@property(nonatomic ,strong) UITextField *textField;

@property(nonatomic ,strong) UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self testLink];
    
//    [self testFunction];
    
    //RAC Demo
//    [self testRACSignal];
    
    /// RAC代替Delegate
//    [self racReplaceDelegate];
    
    /// RAC代替KVO
//    [self racReplaceKVO];
    
    ///RAC监听事件
//    [self racObserveEvent];
   
    ///RAC代替通知
//    [self racReplaceNotification];
    
    /// 监听文本框文字改变
//    [self racObserveTextField];
//    [self racObserveTextView];
}

#pragma mark - 监听文本框文字改变
- (void)racObserveTextField
{
    _textField = [[UITextField alloc]init];
    _textField.frame = CGRectMake(50, 200, 300, 50);
    _textField.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_textField];
    
    [[_textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%s 监听到textField文字改变", __FUNCTION__);    //相当于发出了 UITextFieldTextDidChangeNotification
        NSLog(@"%s x = %@", __FUNCTION__, x);
    }];
}
- (void)racObserveTextView
{
    _textView = [[UITextView alloc]init];
    _textView.frame = CGRectMake(50, 200, 300, 50);
    _textView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_textView];
    
    [[_textView rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%s 监听到textView文字改变", __FUNCTION__);    //相当于发出了  UITextViewTextDidChangeNotification
        NSLog(@"%s x = %@", __FUNCTION__, x);
    }];
}

#pragma mark - RAC代替通知
- (void)racReplaceNotification
{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UITextViewTextDidChangeNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"%s 接收到通知，x = %@", __FUNCTION__, x);
    }];
}

#pragma mark - RAC监听事件
- (void)racObserveEvent
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(100, 100, 100, 100);
    btn2.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn2];
    
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"%s RAC监听到了btn---UIControlEventTouchUpInside事件", __FUNCTION__);
        NSLog(@"%s x = %@", __FUNCTION__, x);
    }];
    [[btn2 rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"%s RAC监听到了btn2---UIControlEventTouchDown事件", __FUNCTION__);
        NSLog(@"%s x = %@", __FUNCTION__, x);
    }];
}

#pragma mark - RAC代替KVO
- (void)racReplaceKVO
{
    // 监听哪个对象的属性改变
    // 方法调用者:就是被监听的对象
    // KeyPath:监听的属性
    // 把监听到内容转换成信号
    [[self rac_valuesForKeyPath:@"num" observer:self] subscribeNext:^(id  _Nullable x) {
        // block:只要属性改变就会调用,并且把改变的值传递给你
        NSLog(@"%s x = %@", __FUNCTION__, x);
    }];
}
/// 改变num
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.num++;
}

#pragma mark - RAC代替Delegate
- (void)racReplaceDelegate
{
    _redView = [[RedView alloc]init];
    _redView.frame = CGRectMake(100, 100, 100, 100);
    _redView.center = self.view.center;
    _redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_redView];
    
    // RAC:判断下一个方法有没有调用,如果调用了就会自动发送一个信号给你
    // 只要self调用viewDidLoad就会转换成一个信号
    // 监听_redView有没有调用redBtnClick:,如果调用了就会转换成信号
    [[_redView rac_signalForSelector:@selector(redBtnClick:)] subscribeNext:^(id  _Nullable x) {
     
        NSLog(@"%s 知道了红色View的RedBtnClick,可以做事情了", __FUNCTION__);
        
        NSLog(@"%s x = %@", __FUNCTION__, x);
    }];
}


- (void)testRACSignal
{
     // 创建信号A
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
       // 处理信号
        NSLog(@"%s 创建信号A", __FUNCTION__);
        // 发送数据
        [subscriber sendNext:@"热门商品"];
        
        return nil;
    }];
    // 创建信号B
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
       // 处理信号
        NSLog(@"%s 创建信号", __FUNCTION__);
        // 发送数据
        [subscriber sendNext:@"最新商品"];
        
        return nil;
    }];
    
    // RAC:就可以判断两个信号有没有都发出内容
    // SignalsFromArray:监听哪些信号的发出
    // 当signals数组中的所有信号都发送sendNext就会触发方法调用者(self)的selector
    // 注意:selector方法的参数不能乱写,有几个信号就对应几个参数
    // 不需要主动订阅signalA,signalB,方法内部会自动订阅
    
//    [self rac_liftSelector:@selector(updateUIWithHot:) withSignalsFromArray:@[signalA]];
    
    [self rac_liftSelector:@selector(updateUIWithHot: new:) withSignalsFromArray:@[signalA,signalB]];
    
}
//- (void)updateUIWithHot:(NSString *)hot
//{
//    NSLog(@"%s hot = %@", __FUNCTION__, hot);
//}
- (void)updateUIWithHot:(NSString *)hot new:(NSString *)new
{
    NSLog(@"%s hot = %@ , new = %@", __FUNCTION__, hot ,new);
}

///链式编程使用
- (void)testLink
{
    int result = [CalculateManager makeCalculators:^(CalculateMaker *maker) {
        maker.result = 10;
        maker.add(1).minus(2).mulity(3).divide(4);
    }];
    
    NSLog(@"%s result = %d", __FUNCTION__, result);
}
///函数式编程使用
- (void)testFunction
{
    CalculateMaker *maker = [[CalculateMaker alloc]init];
    BOOL isEqual = [[[maker calculator:^int(int result) {
        result += 2;
        result *= 5;
        return result;
    }]equal:^BOOL(int result) {
        return result == 10;
    }]isEqual];
    
    NSLog(@"%s isEqual = %d", __FUNCTION__, isEqual);
}

@end
