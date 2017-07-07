//
//  ViewController.m
//  SFTableView
//
//  Created by 张东坡 on 2017/6/29.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import "ViewController.h"
#import "SFBaseTableView.h"
#import "ViewControllerDataSource.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)creatDataSource
{
    self.dataSource = [[ViewControllerDataSource alloc]init];
}

@end
