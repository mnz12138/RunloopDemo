//
//  ViewController.m
//  RunloopDemo
//
//  Created by Apple on 2018/6/5.
//  Copyright © 2018年 王全金. All rights reserved.
//

#import "ViewController.h"
#import "Tools.h"

typedef void(^RunloopBlock)(void);

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *tasks;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 135;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self addRunloopObserver];
}

#pragma mark - <RunLoop>
//添加RunLoop观察者!!  CoreFoundtion 里面 Ref (引用)指针!!
- (void)addRunloopObserver{
    //拿到当前的runloop
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    //定义一个context
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL,
    };
//    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
//        switch (activity) {
//            case kCFRunLoopEntry:
//                NSLog(@"即将进入runloop");
//                break;
//            case kCFRunLoopBeforeTimers:
//                NSLog(@"即将处理 Timer");
//                break;
//            case kCFRunLoopBeforeSources:
//                NSLog(@"即将处理 Sources");
//                break;
//            case kCFRunLoopBeforeWaiting:
//                NSLog(@"即将进入休眠");
//                break;
//            case kCFRunLoopAfterWaiting:
//                NSLog(@"从休眠中唤醒loop");
//                break;
//            case kCFRunLoopExit:
//                NSLog(@"即将退出runloop");
//                break;
//            default:
//                break;
//        }
//    });
    //定义观察
    static CFRunLoopObserverRef defaultModeObserver;
    //创建观察者
    defaultModeObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, 0, &sourceTodo, &context);
    //添加当前runloop的观察者!!
    CFRunLoopAddObserver(runloop, defaultModeObserver, kCFRunLoopCommonModes);
    //C 语言里面Create相关的函数!创建出来的指针!需要释放
    CFRelease(defaultModeObserver);
}

static void sourceTodo(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    NSLog(@"gemelaile ");
    //拿到控制器
    ViewController * vc = (__bridge ViewController *)info;
    NSLog(@"CallbackNoTask");//这里还没有执行事件
    if (vc.tasks.count == 0) {
        [vc.timer invalidate];
        vc.timer = nil;
        return;
    }
    RunloopBlock task = vc.tasks.firstObject;
    task();
    //干掉第一个任务
    [vc.tasks removeObjectAtIndex:0];
    NSLog(@"CallbackHasTask");//这里执行了事件
}

- (void)addTask:(RunloopBlock)task{
    //保持runloop一直处于活跃
    if (!self.timer) {//这是优化
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
    }
    //添加任务到数组!!
    [self.tasks addObject:task];
}
- (void)timerMethod{
    //啥都不干!!
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //添加文字
    [Tools addlabel:cell indexPath:indexPath];
    [self addTask:^{
        [Tools addImageWith:cell index:0];
    }];
    [self addTask:^{
        [Tools addImageWith:cell index:1];
    }];
    [self addTask:^{
        [Tools addImageWith:cell index:2];
    }];
    return cell;
}

- (NSMutableArray *)tasks {
    if (!_tasks) {
        _tasks = [[NSMutableArray alloc] init];
    }
    return _tasks;
}


@end
