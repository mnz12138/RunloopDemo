
//
//  Tools.m
//  RunloopDemo
//
//  Created by Apple on 2018/6/5.
//  Copyright © 2018年 王全金. All rights reserved.
//

#import "Tools.h"

@implementation Tools

//MARK: 内部实现方法
//添加文字
+(void)addlabel:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 300, 25)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor redColor];
    label.text = [NSString stringWithFormat:@"%zd - Drawing index is top priority", indexPath.row];
    label.font = [UIFont boldSystemFontOfSize:13];
    [cell.contentView addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 99, 300, 35)];
    label1.lineBreakMode = NSLineBreakByWordWrapping;
    label1.numberOfLines = 0;
    label1.backgroundColor = [UIColor clearColor];
    label1.textColor = [UIColor colorWithRed:0 green:100.f/255.f blue:0 alpha:1];
    label1.text = [NSString stringWithFormat:@"%zd - Drawing large image is low priority. Should be distributed into different run loop passes.", indexPath.row];
    label1.font = [UIFont boldSystemFontOfSize:13];
    [cell.contentView addSubview:label1];
}
+(void)addImageWith:(UITableViewCell *)cell index:(NSInteger)index{
    UIImageView *imageView = [[UIImageView alloc] init];
    switch (index) {
        case 0:
            imageView.frame = CGRectMake(5, 20, 85, 85);
            break;
        case 1:
            imageView.frame = CGRectMake(105, 20, 85, 85);
            break;
        case 2:
            imageView.frame = CGRectMake(200, 20, 85, 85);
            break;
        default:
            break;
    }
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"spaceship" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path1];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = image;
    [UIView transitionWithView:cell.contentView duration:0.3 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve) animations:^{
        [cell.contentView addSubview:imageView];
    } completion:nil];
}

@end
