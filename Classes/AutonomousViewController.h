//
//  AutonomousViewController.h
//  ScoreKeepriOS
//
//  Created by Nick McGuire on 2012-11-29.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NMAutonomous) {
	RedAlliance,
	BlueAlliance,
	NoAlliance
};

@class AppDelegate;

@interface AutonomousViewController : UIViewController

@property (nonatomic, assign) AppDelegate *delegate;

- (IBAction)optionSelected:(id)sender;

@end
