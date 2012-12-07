//
//  AfterGameViewController.h
//  ScoreKeepriOS
//
//  Created by Nick McGuire on 2012-11-29.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface AfterGameViewController : UIViewController

@property (assign, nonatomic) AppDelegate *delegate;

- (void)scoringFinished;

@end
