//
//  userTableView.m
//  firstSqLine
//
//  Created by WZZ on 15/11/21.
//  Copyright © 2015年 晓志. All rights reserved.
//

#import "userTableView.h"
#import "XZUserTableViewCell.h"
#import "userModel.h"
#import "XZViewController.h"
#import "XZSearcherVc.h"
@interface userTableView ()

@property(nonatomic,strong) NSArray *userlistArr;

@property(nonatomic,strong) NSMutableArray *userDataArr;
@end

@implementation userTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightBat = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addViewController)];

    self.navigationItem.rightBarButtonItem = rightBat;
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(modifyDataBase)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    // 加个搜索按钮
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 60, 44);
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"搜索按钮" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changSearcherBtn) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.titleView = btn;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *doucument = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doucument stringByAppendingPathComponent:@"USER.sqlite"];
    self.path = path;
    // 注意以上三句话是获取数据库路径必不可少，在viewDidload之前就已经准备好了
    [self createTable];
    // 得到表
    [self getAllDatabase];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.userlistArr.count;
    }
    return self.userDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        XZUserTableViewCell *cell = [XZUserTableViewCell cellWithtableView:tableView];
        cell.usermodel = self.userlistArr[0];
        return cell;
    }
    if (indexPath.section == 1) {
        XZUserTableViewCell *cell = [XZUserTableViewCell cellWithtableView:tableView];
        cell.usermodel = self.userDataArr[indexPath.row];
        return cell;
    }
 
    return nil;
}

#pragma mark - set & get
- (NSArray *)userlistArr {
    if (_userlistArr == nil) {
        userModel * model = [[userModel alloc] init];
        model.name = @"姓名";
        model.age = @"年龄";
        model.ID = @"ID";
        _userlistArr = @[model];
    }
    return _userlistArr;
}

- (NSMutableArray *)userDataArr {
    if (_userDataArr == nil) {
        _userDataArr = [NSMutableArray array];
    }
    return _userDataArr;
}


#pragma mark - SQLine
// 创建表
- (void)createTable {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:self.path]) {
        NSLog(@"表不存在创建表");
        FMDatabase *db = [FMDatabase databaseWithPath:self.path];
        if ([db open]) {
            // 创建表
            NSString *sql = @"CREATE TABLE 'USER'('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'name' VARCHAR(20),'age' VARCHAR(20),'idcode' VARCHAR(30))    ";//sql语句
            BOOL success = [db executeUpdate:sql];
            if (!success) {
                NSLog(@"创建表错误");
            } else {
                NSLog(@"创建成功");
            }
            [db close];
        } else {
            NSLog(@"数据库打开失败");
        }
    }
}

// 得到表中数据
- (void)getAllDatabase {
    
    [self.userDataArr removeAllObjects];
    // 得到表路径
    FMDatabase *db = [FMDatabase databaseWithPath:self.path];
    if ([db open]) { // 如果能打开表
        NSString *sql = @"SELECT * FROM USER";
        FMResultSet *rs = [db executeQuery:sql];
        NSLog(@"rs = %@",rs);
        
        while ([rs next]) {
            NSString *name = [rs stringForColumn:@"name"];
            NSString *age = [rs stringForColumn:@"age"];
            NSString *ID = [rs stringForColumn:@"idcode"];
            userModel *model = [[userModel alloc] init];
            model.name = name;
            model.age = age;
            model.ID = ID;
            [self.userDataArr addObject:model];
        }
        [db close];
        [self.tableView reloadData];
    }
}

#pragma mark - 跳转界面
- (void)addViewController {
    XZViewController *viewVc = [[XZViewController alloc] init];
    [self.navigationController pushViewController:viewVc animated:YES];
}

#pragma mark - 刷新数据
- (void)modifyDataBase {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath == nil) {
        NSLog(@"更新数据");
        return;
    } else {
        // 跳转界面选择要更新的数据
        XZViewController *addViewVc = [[XZViewController alloc] init];
        addViewVc.operateType = 1;
        addViewVc.model = self.userDataArr[indexPath.row];
        [self.navigationController pushViewController:addViewVc animated:YES];
    }
}

#pragma mark - 跳转到收索控制器
- (void)changSearcherBtn {
    
    XZSearcherVc *search = [[XZSearcherVc alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}

@end
