//
//  ViewController.m
//  FMDBDemo
//
//  Created by Hanser on 2020/4/26.
//  Copyright © 2020 Hanser. All rights reserved.
//

#import "HSConstant.h"
#import "ViewController.h"
#import "QYGCLDataBaseHelper.h"
#import "HSDataSourceManager.h"
#import "HSSqliteDataManager.h"

#import "HSTableViewCell.h"
#import "HSSqliteModel.h"
#import "WHToast.h"


#define kTagsWidth 50.0f
#define kTagsHeight 30.0f

#define kButtonTag  2000


@interface ViewController ()

@property (nonatomic, strong) UIButton *creatTableButton;
@property (nonatomic, strong) UIButton *insertDataButton;
@property (nonatomic, strong) UIButton *updateDataButton;
@property (nonatomic, strong) UIButton *lookoverButton;
@property (nonatomic, strong) UIButton *insertDatasButton;
@property (nonatomic, strong) UIButton *deleteDataButton;
@property (nonatomic, strong) UIButton *lookoverAllDatasButton;
@property (nonatomic, strong) UIButton *deleteAllDatasButton;
@property (nonatomic, strong) UIButton *removalDataButton;


@property (nonatomic, strong) HSDataSourceManager *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [QYGCLDataBaseHelper createSqlite:kSqliteName];
    [QYGCLDataBaseHelper createTableWithName:kSqliteTabName];
    
    [self configViews];
    [self setupFrames];
}


- (void)configViews {
    
    self.creatTableButton = [self creatWithTitle:@"创建表格" textColor:UIColor.blueColor tag:HSSqliteCreateTableType];
    self.insertDataButton = [self creatWithTitle:@"插入单条数据" textColor:UIColor.blueColor tag:HSSqliteInsertDataType];
    self.updateDataButton = [self creatWithTitle:@"更新单条数据" textColor:UIColor.blueColor tag:HSSqliteUpdateDataType];
    self.lookoverButton = [self creatWithTitle:@"查询单条数据" textColor:UIColor.blueColor tag:HSSqliteLookoverDataType];
    self.insertDatasButton = [self creatWithTitle:@"插入多条数据" textColor:UIColor.redColor tag:HSSqliteInsertDatasType];
    self.deleteDataButton = [self creatWithTitle:@"删除单条数据" textColor:UIColor.redColor tag:HSSqliteDeleteDataType];
    self.deleteAllDatasButton = [self creatWithTitle:@"删除所有数据" textColor:UIColor.grayColor tag:HSSqliteDeleteAllDatasType];
    self.lookoverAllDatasButton = [self creatWithTitle:@"查询所有数据" textColor:UIColor.darkGrayColor tag:HSSqliteLookoverAllDatasType];
    self.removalDataButton = [self creatWithTitle:@"迁移数据" textColor:UIColor.greenColor tag:HSSqliteRemovalDatasType];
    
    self.dataSource = [[HSDataSourceManager alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, kLScreenHeight - 200) style:UITableViewStylePlain];
    self.tableView.delegate = self.dataSource;
    self.tableView.dataSource = self.dataSource;
    [self.tableView registerClass:[HSTableViewCell class] forCellReuseIdentifier:kCellId];
    
    
    [self.view addSubview:self.creatTableButton];
    [self.view addSubview:self.insertDataButton];
    [self.view addSubview:self.updateDataButton];
    [self.view addSubview:self.lookoverButton];
    [self.view addSubview:self.insertDatasButton];
    [self.view addSubview:self.deleteDataButton];
    [self.view addSubview:self.deleteAllDatasButton];
    [self.view addSubview:self.lookoverAllDatasButton];
    [self.view addSubview:self.tableView];
}

- (void)setupFrames {
    self.creatTableButton.sd_layout
    .leftSpaceToView(self.view, 10)
    .topSpaceToView(self.view, 64)
    .widthIs(kTagsWidth).heightIs(kTagsHeight);
    
    self.insertDataButton.sd_layout
    .leftSpaceToView(self.creatTableButton, 10)
    .topEqualToView(self.creatTableButton)
    .widthIs(80).heightIs(kTagsHeight);
    
    self.updateDataButton.sd_layout
    .leftSpaceToView(self.insertDataButton, 10)
    .topEqualToView(self.insertDataButton)
    .widthIs(80).heightIs(kTagsHeight);
    
    self.lookoverButton.sd_layout
    .leftSpaceToView(self.updateDataButton, 10)
    .topEqualToView(self.updateDataButton)
    .widthIs(80).heightIs(kTagsHeight);
    
    self.insertDatasButton.sd_layout
    .leftSpaceToView(self.view, 10)
    .topSpaceToView(self.creatTableButton, 10)
    .widthIs(80).heightIs(kTagsHeight);
    
    self.deleteDataButton.sd_layout
    .leftSpaceToView(self.insertDatasButton, 10)
    .topEqualToView(self.insertDatasButton)
    .widthIs(80).heightIs(kTagsHeight);
    
    self.deleteAllDatasButton.sd_layout
    .leftSpaceToView(self.deleteDataButton, 10)
    .topEqualToView(self.deleteDataButton)
    .widthIs(80).heightIs(kTagsHeight);
    
    self.lookoverAllDatasButton.sd_layout
    .leftSpaceToView(self.deleteAllDatasButton, 10)
    .topEqualToView(self.deleteAllDatasButton)
    .widthIs(80).heightIs(kTagsHeight);
    
}


- (UIButton *)creatWithTitle:(NSString *)title textColor:(UIColor *)color tag:(NSInteger)tag {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.layer.borderColor = color.CGColor;
    button.layer.cornerRadius = 2;
    button.layer.borderWidth = 1;
    button.tag = kButtonTag + tag;
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button addTarget:self action:@selector(sqliteFunctionEvent:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}




#pragma mark - Event
- (void)sqliteFunctionEvent:(UIButton *)sender {
    HSSqliteClickType type = sender.tag - kButtonTag;
    switch (type) {
        case HSSqliteCreateTableType:
            [self createSqlite];
            break;
        case HSSqliteInsertDataType:
            [self insertData];
            break;
        case HSSqliteInsertDatasType:
            [self insertDatas];
            break;
        case HSSqliteDeleteAllDatasType:
            [self deleteAllDatas];
            break;
        case HSSqliteLookoverAllDatasType:
            [self lookoverAllData];
            break;
        default:
            break;
    }
}


- (void)createSqlite {
    [QYGCLDataBaseHelper createSqlite:kSqliteName];
    [QYGCLDataBaseHelper createTableWithName:kSqliteTabName];
}

- (void)insertDatas {
//    [QYGCLDataBaseHelper addData:kSqliteTabName models:[HSSqliteDataManager createDatas]];
    [QYGCLDataBaseHelper addData:kSqliteTabName models:[HSSqliteDataManager createDatas] success:^(NSArray *  _Nullable data) {
        [WHToast showMessage:@"多条数据添加成功" duration:1 finishHandler:nil];
    } failure:^(id  _Nullable data) {
        
    }];
    
}

- (void)insertData {
    HSSqliteModel *model = [HSSqliteModel new];
    model.ID
    = @"30";
    model.name = @"haserzz";
    model.phone = @"123441233";
    model.score = @"11";
//    [self.dataSource inserData:model];
//    [self.tableView reloadData];
    [QYGCLDataBaseHelper addData:kSqliteTabName model:model success:^(id  _Nullable data) {
        
    } failure:^(id  _Nullable data) {

    }];
    
}

- (void)deleteAllDatas {
    [QYGCLDataBaseHelper deleteSquliteAllDataWithTable:kSqliteTabName success:^(id  _Nullable data) {
        
    } failure:^(id  _Nullable data) {
        
    }];
}

- (void)lookoverAllData {
    __weak typeof(self) weakSelf = self;
    [QYGCLDataBaseHelper selectSqliteAllDataWithTable:kSqliteTabName success:^(NSArray *data) {
        for (NSDictionary *dic in data) {
            HSSqliteModel *model = [[HSSqliteModel alloc] initWithDic:dic];
            [weakSelf.dataSource.dataArr addObject:model];
        }
        [weakSelf.tableView reloadData];
    } fail:^(id  _Nullable data) {
        
    }];
}

@end
