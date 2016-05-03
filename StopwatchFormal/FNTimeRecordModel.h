//
//  FNTimeRecordModel.h
//  StopwatchFormal
//
//  Created by xuyonghua on 5/3/16.
//  Copyright © 2016 FN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNTimeRecordModel : NSObject

@property (nonatomic, assign) int rowid;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *time;

@end
