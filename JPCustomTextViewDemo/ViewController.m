//
//  ViewController.m
//  JPCustomTextViewDemo
//
//  Created by 鞠鹏 on 16/3/25.
//  Copyright © 2016年 JuPeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString * _originStr;
    NSString * _contentStr;
}


@property (nonatomic,strong) UITableView * tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _originStr = @"原来你是我最想留住的幸运\n\
    原来我们和爱情曾经靠得那么近\n\
    那为我对抗世界的决定\n\
    那陪我淋的雨\n\
    一幕幕都是你 一尘不染的真心\n\
    与你相遇 好幸运\n\
    可我已失去为你泪流满面的权利\n\
    但愿在我看不到的天际\n\
    你张开了双翼\n\
    遇见你的注定 (oh--)\n\
    她会有多幸运";
    
    [self initUI];

}

- (void)initUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 500)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = [UIColor cyanColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    /**
     第一步，创建一个view
     */
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width -20, 30)];

    [self.bgView addTextView:nil font:[UIFont systemFontOfSize:14.0f] rightArrowisHidden:NO bolderisHidden:NO originStr:nil];
    self.bgView.customTextView.placeholder = @"你是我的小幸运";
    self.bgView.customTextView.placeholderColor = [UIColor lightGrayColor];
    [self.view addSubview:self.bgView];
}


- (IBAction)changeStringClick:(UIButton *)sender {
    _contentStr = _originStr;
    CGFloat  count= arc4random()%3 + 1;
    NSLog(@"%f",count);
    for (NSInteger i = 1; i < count; i ++) {
        _contentStr =[_contentStr stringByAppendingString:_originStr];
    }
    NSLog(@"%@",_contentStr);
    /**
     * 第二部 自动变化调用的方法
     */
    [self.bgView changeHeightWithcontentStr:_contentStr andTextView:self.bgView.customTextView withSize:14.0f];
    
    
    [self.tableView reloadData];
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableView.frame = CGRectMake(0, 40, self.view.frame.size.width, self.bgView.frame.size.height + 10);

    return self.bgView.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
        [cell addSubview:self.bgView];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
