//
//  InGameViewController.h
//  ScoreKeepriOS
//
//  Created by Nick McGuire on 2012-11-29.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface InGameViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *labelBlueScore;
@property (strong, nonatomic) IBOutlet UILabel *labelRedScore;

@property (strong, nonatomic) IBOutlet UIStepper *stepperBlue;
@property (strong, nonatomic) IBOutlet UIStepper *stepperRed;

@property (assign, nonatomic) AppDelegate *delegate;

- (IBAction)stepperChanged:(UIStepper *)sender;
- (IBAction)matchFinished;

@end
