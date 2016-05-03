//
//  FNStopwatchView.m
//  StopwatchFormal
//
//  Created by xuyonghua on 5/3/16.
//  Copyright © 2016 FN. All rights reserved.
//

#import "FNStopwatchView.h"

@interface FNStopwatchView ()


@end

@implementation FNStopwatchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 0.0 initStatus
        _status = stopwatchStartAndLap;
        
        // 1.0 timeLblView
        _timeLblView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, SCR_WIDTH, SCR_HEIGHT / 3)];
        
        // 1.1
        _smallTimeLbl = [[UILabel alloc] initWithFrame:CGRectMake(SCR_WIDTH / 2 + 45, 40, 90, 30)];
        
        _smallTimeLbl.text = defaultTitleLbl;
        _smallTimeLbl.textAlignment = NSTextAlignmentRight;
        _smallTimeLbl.textColor = [UIColor grayColor];
        _smallTimeLbl.font = [UIFont systemFontOfSize:20];
        [_timeLblView addSubview:_smallTimeLbl];
        
        // 1.2
        _bigTimeLbl = [[ UILabel alloc] initWithFrame:CGRectMake(SCR_WIDTH / 2 - 135, 90, 270, 80)];
        _bigTimeLbl.text = defaultTitleLbl;
        _bigTimeLbl.textAlignment = NSTextAlignmentRight;
        _bigTimeLbl.textColor = [UIColor blackColor];
        _bigTimeLbl.font = [UIFont systemFontOfSize:60];
        [_timeLblView addSubview:_bigTimeLbl];
        
        // 2.0 BtnView
        _btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 60 + _timeLblView.bounds.size.height, SCR_WIDTH, SCR_HEIGHT / 5)];
        _btnView.backgroundColor = RGBA(204, 204, 204, 0.6);
        
        // 2.1
        _lapBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _lapBtn.frame = CGRectMake(SCR_WIDTH / 5, 20, SCR_WIDTH / 5, SCR_WIDTH / 5);
        _lapBtn.backgroundColor = [UIColor whiteColor];
        [_lapBtn setTitle:@"Lap" forState:UIControlStateNormal];
        [_lapBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _lapBtn.titleLabel.font = [UIFont systemFontOfSize:25];
        _lapBtn.layer.cornerRadius = _lapBtn.frame.size.width / 2;
        _lapBtn.clipsToBounds = YES;
        [_lapBtn addTarget:self action:@selector(lapTimer) forControlEvents:UIControlEventTouchUpInside];
        [_btnView addSubview:_lapBtn];
        
        // 2.2
        _startBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _startBtn.frame = CGRectMake((SCR_WIDTH * 3) / 5, 20, SCR_WIDTH / 5, SCR_WIDTH / 5);
        _startBtn.backgroundColor = [UIColor whiteColor];
        [_startBtn setTitle:@"Start" forState:UIControlStateNormal];
        [_startBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        _startBtn.titleLabel.font = [UIFont systemFontOfSize:25];
        _startBtn.layer.cornerRadius = _startBtn.frame.size.width / 2;
        _startBtn.clipsToBounds = YES;
        [_startBtn addTarget:self action:@selector(startTimer) forControlEvents:UIControlEventTouchUpInside];
        [_btnView addSubview:_startBtn];
        
        // 3.0
        _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60 + _timeLblView.bounds.size.height +_btnView.bounds.size.height, SCR_WIDTH, (SCR_HEIGHT - (SCR_HEIGHT / 3) - (SCR_HEIGHT / 5) ))];
        _listTableView.backgroundColor = RGBA(214, 204, 204, 0.6);
        
    }
    return self;
}

- (void)showUI:(UIView *)view {
    [view addSubview:_timeLblView];
    
    [view addSubview:_btnView];
    
    [view addSubview:_listTableView];
}

- (void)startTimer{
    
    if (_status == stopwatchStartAndLap) {
        
        if (self.startBlock) {
            self.startBlock();
        }
        
        [_startBtn setTitle:@"Stop" forState:UIControlStateNormal];
        [_startBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_lapBtn setTitle:@"Lap" forState:UIControlStateNormal];
        [_lapBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _status = stopwatchStopAndLap;
        
    } else if (_status == stopwatchStopAndLap){
        
        if (self.stopBlock) {
            self.stopBlock();
        }
        
        [_startBtn setTitle:@"Start" forState:UIControlStateNormal];
        [_startBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [_lapBtn setTitle:@"Reset" forState:UIControlStateNormal];
        [_lapBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _status = stopwatchStartAndReset;
        
    } else if (_status == stopwatchStartAndReset){
        
        if (self.startBlock) {
            self.startBlock();
        }
        
        [_startBtn setTitle:@"Stop" forState:UIControlStateNormal];
        [_startBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_lapBtn setTitle:@"Lap" forState:UIControlStateNormal];
        [_lapBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _status = stopwatchStopAndLap;
    }
}

- (void)lapTimer{
    if (_status == stopwatchStartAndLap) {
        
        return;
        
    } else if (_status == stopwatchStopAndLap){
        
        if (self.lapBlock) {
            self.lapBlock();
        }
        
    } else if (_status == stopwatchStartAndReset){
        if (self.resetBlock) {
            self.resetBlock();
        }
        
        [_startBtn setTitle:@"Start" forState:UIControlStateNormal];
        [_startBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [_lapBtn setTitle:@"Lap" forState:UIControlStateNormal];
        [_lapBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        _status = stopwatchStartAndLap;
    }
    
}


@end

