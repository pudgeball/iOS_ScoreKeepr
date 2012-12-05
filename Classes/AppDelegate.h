//
//  AppDelegate.h
//  ScoreKeepriOS
//
//  Created by Nicholas McGuire on 2012-11-12.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Server.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, ServerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) Server *server;

- (void)autonomousEndedWithOutput:(NSDictionary *)results;
- (void)inGameEndedWithResults:(NSDictionary *)results;
- (void)scoringCompletedWithResults:(NSDictionary *)results;
- (void)connectToService:(NSNetService *)service;

@end
