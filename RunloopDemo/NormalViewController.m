//
//  NormalViewController.m
//  RunloopDemo
//
//  Created by Apple on 2018/6/5.
//  Copyright © 2018年 王全金. All rights reserved.
//

#import "NormalViewController.h"

@interface NormalViewController ()

@end

@implementation NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    //普通写法
    for (NSInteger i=0; i<50; i++) {
        NSString *str = [NSString stringWithFormat:@"%@",indexPath];
        NSLog(@"%@",str);
    }
    for (NSInteger i=0; i<50; i++) {
        NSString *str = [NSString stringWithFormat:@"%@",indexPath];
        NSLog(@"%@",str);
    }
    return cell;
}

@end
