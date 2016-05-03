//
//  AppDelegate.m
//  StopwatchFormal
//
//  Created by xuyonghua on 5/3/16.
//  Copyright © 2016 FN. All rights reserved.
//

#import "FNAppDelegate.h"
#import "FNAlarmViewController.h"
#import "FNStopwatchViewController.h"
#import "FNTimerViewController.h"
#import "FNWorldClockViewController.h"

@interface FNAppDelegate ()

@end

@implementation FNAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 1. Init
    UIImage *tabImage = nil;
    UIImage *tabImageHighlight = nil;
    
    // 2.1 World Clock
    FNWorldClockViewController *worldClockViewController = [[FNWorldClockViewController alloc] init];
    worldClockViewController.title = @"World Clock";
    // 创建图标
    tabImage = [[UIImage imageNamed:@"TabBar_Main"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    tabImageHighlight = [[UIImage imageNamed:@"TabBar_Main_HL"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //  创建导航控制器的TabBarItem
    worldClockViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:worldClockViewController.title image:tabImage selectedImage:tabImageHighlight];
    //  生成导航控制器
    UINavigationController *worldClockNavigationController = [[UINavigationController alloc] initWithRootViewController:worldClockViewController];
    
    // 2.2 Alarm
    FNAlarmViewController *alarmViewController = [[FNAlarmViewController alloc] init];
    alarmViewController.title = @"Alarm";
    //创建图标
    tabImage = [[UIImage imageNamed:@"TabBar_Explore"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    tabImageHighlight = [[UIImage imageNamed:@"TabBar_Explore_HL"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //  创建导航控制器的TabBarItem
    alarmViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:alarmViewController.title image:tabImage selectedImage:tabImageHighlight];
    //  生成导航控制器
    UINavigationController *alarmNavigationController = [[UINavigationController alloc] initWithRootViewController:alarmViewController];
    
    // 2.3 Stopwatch
    FNStopwatchViewController *stopwatchViewController = [[FNStopwatchViewController alloc] init];
    stopwatchViewController.title = @"Stopwatch";
    // 创建图标
    tabImage = [[UIImage imageNamed:@"TabBar_Me"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    tabImageHighlight = [[UIImage imageNamed:@"TabBar_Me_HL"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //  创建导航控制器的TabBarItem
    stopwatchViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:stopwatchViewController.title image:tabImage selectedImage:tabImageHighlight];
    //  生成导航控制器
    UINavigationController *stopwatchNavigationController = [[UINavigationController alloc] initWithRootViewController:stopwatchViewController];
    
    // 2.4 Timer
    FNTimerViewController *timerViewController = [[FNTimerViewController alloc] init];
    timerViewController.title = @"Timer";
    // 创建图标
    tabImage = [[UIImage imageNamed:@"TabBar_Me"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    tabImageHighlight = [[UIImage imageNamed:@"TabBar_Me_HL"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //  创建导航控制器的TabBarItem
    timerViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:timerViewController.title image:tabImage selectedImage:tabImageHighlight];
    //  生成导航控制器
    UINavigationController *timerNavigationController = [[UINavigationController alloc] initWithRootViewController:timerViewController];
    
    // 3. WorldClock Alarm Stopwatch Timer Controller
    // 创建tab控制器
    UITabBarController *mainTabBarController = [[UITabBarController alloc] init];
    // 设置tab控制器的轮转控制器
    mainTabBarController.viewControllers = @[worldClockNavigationController, alarmNavigationController, stopwatchNavigationController, timerNavigationController];
    // 设置rootView控制器
    mainTabBarController.selectedIndex = 2;//设置默认显示的导航视图
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = mainTabBarController;
    [self.window makeKeyAndVisible];//让当前UIWindow变成keyWindow，并显示出来// convenience. most apps call this to show the main window and also make it key. otherwise use view hidden property
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
