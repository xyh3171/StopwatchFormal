//
//  Macro.h
//
//  Created by xuyonghua on 4/7/16.
//  Copyright © 2016 FN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Macro : NSObject

#pragma mark - Frame
#define SCR_WIDTH                  [UIScreen mainScreen].bounds.size.width
#define SCR_HEIGHT                 [UIScreen mainScreen].bounds.size.height
#define SCR_BOUNDS                 [UIScreen mainScreen].bounds
#define SIZE(w, h)                 CGSizeMake(w, h)
#define POINT(x, y)                CGPointMake(x, y)
#define RECT(x, y, w, h)           CGRectMake(x, y, w, h)

#pragma mark - IMG 
#define IMAGE(name)                [UIImage imageNamed:name]

#pragma mark - Font
#define FONT(SIZE)                 [UIFont systemFontOfSize:SIZE]
#define BOLD_FONT(SIZE)            [UIFont boldSystemFontOfSize:SIZE]

#pragma mark - Color
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)/1.0f]
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]


@end
