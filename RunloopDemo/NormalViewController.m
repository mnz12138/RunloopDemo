//
//  NormalViewController.m
//  RunloopDemo
//
//  Created by Apple on 2018/6/5.
//  Copyright © 2018年 王全金. All rights reserved.
//

#import "NormalViewController.h"
#import "Tools.h"

@interface NormalViewController ()

@end

@implementation NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 135;
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
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //添加文字
    [Tools addlabel:cell indexPath:indexPath];
    [Tools addImageWith:cell index:0];
    [Tools addImageWith:cell index:1];
    [Tools addImageWith:cell index:2];
    return cell;
}

@end
