//
//  FNStopwatchView.h
//  StopwatchFormal
//
//  Created by xuyonghua on 5/3/16.
//  Copyright © 2016 FN. All rights reserved.
//

//
//  FNStopwatchView.h
//  StopWatch1
//
//  Created by xuyonghua on 4/28/16.
//  Copyright © 2016 FN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"

#define defaultTitleLbl @"00:00.00"

typedef enum StopwatchStatus{
    stopwatchStartAndLap = 0,
    stopwatchStopAndLap,
    stopwatchStartAndReset,
}currentStatus;


@interface FNStopwatchView : UIView


@property (assign) currentStatus status;

@property (nonatomic, strong) UIView *timeLblView;
@property (nonatomic, strong) UILabel *smallTimeLbl;
@property (nonatomic, strong) UILabel *bigTimeLbl;

@property (nonatomic, strong) UIView *btnView;
@property (nonatomic, strong) UIButton *lapBtn;
@property (nonatomic, strong) UIButton *startBtn;

@property (nonatomic, strong) UITableView *listTableView;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)showUI:(UIView *)view;

@property (nonatomic, copy) dispatch_block_t startBlock;
@property (nonatomic, copy) dispatch_block_t stopBlock;

@property (nonatomic, copy) dispatch_block_t lapBlock;
@property (nonatomic, copy) dispatch_block_t resetBlock;

@end

