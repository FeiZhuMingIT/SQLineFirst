//
//  XZSearcherVc.m
//  firstSqLine
//
//  Created by WZZ on 15/11/21.
//  Copyright © 2015年 晓志. All rights reserved.
//

#import "XZSearcherVc.h"
#import "userModel.h"
@interface XZSearcherVc()

@property(nonatomic,weak) UITextField   *textField;

@property (nonatomic, strong) NSString *dbpath;
@end

@implementation XZSearcherVc

// 这里只是拿到数据打印而已没有图形化效果

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [document stringByAppendingPathComponent:@"USER.sqlite"];
    self.dbpath = path;
    
    [self setupSubView];
    
    
}

- (void)setupSubView {
    
    // 丑就丑把，效果出来就可以
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = CGRectMake(100, 100, 200, 60);
    textField.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:textField];
    self.textField = textField;
    [self.view addSubview:textField];
    
    // 搜索
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(100, 180, 60, 60);
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(searchData) forControlEvents:UIControlEventTouchDown];
    
}

- (void)searchData {
    
    NSMutableArray *mtbArr = [NSMutableArray array];
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbpath];
    if ([db open]) {
        NSString *sql = @"SELECT * FROM USER WHERE name like ?";
        FMResultSet *rs = [db executeQuery:sql,self.textField.text];
        while ([rs next]) {
            NSString *name = [rs stringForColumn:@"name"];
            NSString *age = [rs stringForColumn:@"age"];
            NSString *ID = [rs stringForColumn:@"idcode"];
            
            userModel *model = [[userModel alloc] init];
            model.name = name;
            model.age = age;
            model.ID = ID;
            [mtbArr addObject:model];
        }
        [db close];
    }
    // 这里搜索只能搜索相同的，不相同的不能搜索。
    // 一般的做法是，如果是搜索网络的资源是返回给数据库让他自己处理再返回收索的数据，下拉列表是一些，以前自己搜索的东西。用户提示也是网络的，因为不可能插入一张写死的表。
    // 当然看需求也可以是写死的，然后请求数据的时候偷偷的进行更新。看需求。
    for (int index = 0; index < mtbArr.count ; index ++) {
        NSLog(@"%@  %@",[mtbArr[index] name], [mtbArr[index] ID]);
    }
}

@end
