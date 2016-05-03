//
//  FNStopwatchViewController.m
//  StopwatchFormal
//
//  Created by xuyonghua on 5/3/16.
//  Copyright © 2016 FN. All rights reserved.
//

#import "FNStopwatchViewController.h"
#import "fmdb/FMDB.h"
#import "FNTimeRecordModel.h"




@interface FNStopwatchViewController ()<UITableViewDelegate, UITableViewDataSource>

{
    FNStopwatchView *_stopwatchViewC;
    
    NSDate *_endDate;
    
    NSTimeInterval _smallTimeLblSecond;
    NSTimeInterval _bigTimeLblSecond;
    NSTimeInterval _deltaSeconds;
    
    NSDateFormatter *_formatter;
    
    NSString *_dbPath;
    
    FMDatabase *_db;
    
    NSString *_smallTimeLblRecord;
    NSString *_bigTimeLblRecord;
    
    FNTimeRecordModel *_timeRecordModel;
    
    NSTimer *_smallTimeLblTimer;
    NSTimer *_bigTimeLblTimer;
    
}

@property (nonatomic, strong)NSMutableArray *timeMutableArray;

@end

@implementation FNStopwatchViewController

static int onClickCount = 0;

- (NSMutableArray *)timeMutableArray {
    if (!_timeMutableArray) {
        _timeMutableArray = [[NSMutableArray alloc] init];
    }
    return _timeMutableArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _stopwatchViewC = [[FNStopwatchView alloc] initWithFrame:CGRectZero];
    [_stopwatchViewC showUI:self.view];
    
    _stopwatchViewC.listTableView.delegate = self;
    _stopwatchViewC.listTableView.dataSource = self;
    
    __weak FNStopwatchViewController *weakSelf = self;
    
    _stopwatchViewC.startBlock = ^(){
        NSLog(@"start");
        [weakSelf startTimer];
    };
    
    _stopwatchViewC.stopBlock = ^(){
        NSLog(@"stop");
        [weakSelf stopTimer];
    };
    
    _stopwatchViewC.lapBlock = ^(){
        NSLog(@"lap");
        [weakSelf lapTimer];
        
    };
    
    _stopwatchViewC.resetBlock = ^(){
        NSLog(@"reset");
        [weakSelf resetTimer];
    };
    
    [self createTable];
    
    [self orderByData];
    
}

#pragma mark - Timer Method
- (void)startTimer {
    
    if (_deltaSeconds) {
        
        _smallTimeLblSecond = _deltaSeconds;
        _bigTimeLblSecond = _deltaSeconds;
        
        _smallTimeLblTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                              target:self selector:@selector(startSmallTimerMethod:)
                                                            userInfo:nil repeats:YES];
        _bigTimeLblTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                            target:self selector:@selector(startBigTimerMethod:)
                                                          userInfo:nil repeats:YES];
        
    } else {
        _formatter = [[NSDateFormatter alloc] init];
        // 2.格式化对象的样式/z大小写都行/格式必须严格和字符串时间一样
        _formatter.dateFormat = @"mm:ss.SS";//HH:mm:ss.SS
        
        _smallTimeLblSecond = 0.00;
        _bigTimeLblSecond = 0.00;
        
        _smallTimeLblTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                              target:self selector:@selector(startSmallTimerMethod:)
                                                            userInfo:nil repeats:YES];
        _bigTimeLblTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                            target:self selector:@selector(startBigTimerMethod:)
                                                          userInfo:nil repeats:YES];
    }
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    
    [runLoop addTimer:_smallTimeLblTimer forMode:NSRunLoopCommonModes];//别写成NSDefaultRunLoopMode默认的，那就没效果了
    [runLoop addTimer:_bigTimeLblTimer forMode:NSRunLoopCommonModes];
    
    [self createTable];
    
}

- (void)startSmallTimerMethod:(NSTimer*)theTimer {
    
    //1. 时间字符串 -> 时间戳
    NSString *string = @"10";// 0.01秒
    _smallTimeLblSecond = _smallTimeLblSecond + (string.longLongValue / 1000.0);//10除以1000毫秒等于0.01秒
    
    // 时间戳 -> NSDate
    _endDate = [NSDate dateWithTimeIntervalSince1970:_smallTimeLblSecond];// 这是GMT ＋ 8 的时间
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    // 获取当前时区和格林尼治GMT 0 的时间差
    NSInteger seconds = [zone secondsFromGMTForDate:_endDate];
    
    // 用当前时区的时间减去（GMT 0 到当前时区的时间差） ＝ GMT 0的时间
    _endDate = [_endDate dateByAddingTimeInterval:-seconds];
    
    // 时间转字符串
    _smallTimeLblRecord = [_formatter stringFromDate:_endDate];
    
    // 显示到lbl
    _stopwatchViewC.smallTimeLbl.text = _smallTimeLblRecord;
    
    
}

- (void)startBigTimerMethod:(NSTimer*)theTimer {
    
    NSString *string = @"10";
    _bigTimeLblSecond = _bigTimeLblSecond + (string.longLongValue / 1000.0);
    _endDate = [NSDate dateWithTimeIntervalSince1970:_bigTimeLblSecond];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger seconds = [zone secondsFromGMTForDate:_endDate];
    _endDate = [_endDate dateByAddingTimeInterval:-seconds];
    _bigTimeLblRecord = [_formatter stringFromDate:_endDate];
    _stopwatchViewC.bigTimeLbl.text = _bigTimeLblRecord;
    
}

- (void)stopTimer {
    _deltaSeconds = _smallTimeLblSecond;
    _deltaSeconds = _bigTimeLblSecond;
    [_smallTimeLblTimer invalidate];
    [_bigTimeLblTimer invalidate];
}

- (void)lapTimer {
    onClickCount ++;
    NSLog(@"%i", onClickCount);
    
    [_smallTimeLblTimer invalidate];
    _smallTimeLblTimer = nil;
    
    _smallTimeLblSecond = 0.00;
    
    _smallTimeLblTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                          target:self selector:@selector(startSmallTimerMethod:)
                                                        userInfo:nil repeats:YES];
    
    [self insertData];
    
    [self orderByData];
    
}

- (void)resetTimer {
    [_smallTimeLblTimer invalidate];
    _smallTimeLblTimer = nil;
    
    [_bigTimeLblTimer invalidate];
    _bigTimeLblTimer = nil;
    
    _deltaSeconds = 0.00;
    _stopwatchViewC.bigTimeLbl.text = _stopwatchViewC.smallTimeLbl.text = defaultTitleLbl;
    
    [self deleteLapRecord];
    
}

#pragma mark - FMDB

- (void)createTable {
    NSLog(@"Create Table");
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *time_record_file = @"timeRecord.db";
    _dbPath = [documentDirectory stringByAppendingPathComponent:time_record_file];
    _db = [FMDatabase databaseWithPath:_dbPath];
    
    if (![_db open]) {
        NSLog(@"OPEN FAIL  create");
        return;
    }
    NSString *CreateSql = @"CREATE TABLE IF NOT EXISTS time_record(rowid INTEGER PRIMARY KEY AUTOINCREMENT,number text,time text)";
    [_db executeUpdate:CreateSql];
    [_db close];
    
}

- (void)insertData {
    if (![_db open]) {
        NSLog(@"OPEN FAIL insert");
        return;
    }
    NSString *number = [NSString stringWithFormat:@"Lap %i",onClickCount];
    
    NSString *time = _smallTimeLblRecord;
    NSLog(@"%@",_smallTimeLblRecord);
    NSString *insertSql = @"INSERT INTO time_record(number,time) VALUES (?,?)";
    [_db executeUpdate:insertSql, number, time];
    
    
}

- (void)orderByData {
    
    if (![_db open]) {
        NSLog(@"OPEN FAIL ");
        return;
    }
    NSString *querySql = @"SELECT rowid,number,time FROM time_record ORDER BY rowid DESC";
    FMResultSet *rs = [_db executeQuery:querySql];
    
    _timeMutableArray = [[NSMutableArray alloc] init];
    
    while ([rs next]) {
        _timeRecordModel = [[FNTimeRecordModel alloc] init];
        _timeRecordModel.rowid = [rs intForColumn:@"rowid"];
        _timeRecordModel.number = [rs stringForColumn:@"number"];
        _timeRecordModel.time = [rs stringForColumn:@"time"];
        [_timeMutableArray addObject:_timeRecordModel];
        
    }
    
    [_stopwatchViewC.listTableView reloadData];
}


- (void)deleteLapRecord {
    
    if (![_db open]) {
        NSLog(@"OPEN FAIL delete");
        return;
    }
    
    NSString *deleteSql = @"DELETE FROM time_record";
    BOOL isSuccess = [_db executeUpdate:deleteSql];//Drop Table IF EXISTS time_record
    if (isSuccess) {
        NSLog(@"delete success");
    }else {
        NSLog(@"delete failed");
    }
    
    onClickCount = 0;
    
    [_timeMutableArray removeAllObjects];
    
    [_stopwatchViewC.listTableView reloadData];
}

#pragma mark - UITableViewDataSource Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _timeMutableArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"time";
    UITableViewCell *cell = [_stopwatchViewC.listTableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = [UIColor grayColor];
    }
    
    _timeRecordModel = _timeMutableArray[indexPath.row];
    NSString *str1 = _timeRecordModel.number;
    NSString *str2 = [str1 stringByAppendingFormat:@"       %@", _timeRecordModel.time];
    cell.textLabel.text = str2;
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
