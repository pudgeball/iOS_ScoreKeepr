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

@property (strong, nonatomic) IBOutlet UIScrollView *contentView;

@property (strong, nonatomic) IBOutlet UILabel *labelRedGreenBalls;
@property (strong, nonatomic) IBOutlet UILabel *labelBlueGreenBalls;

@property (strong, nonatomic) IBOutlet UILabel *labelRedFootBalls;
@property (strong, nonatomic) IBOutlet UILabel *labelBlueFootBalls;

@property (strong, nonatomic) IBOutlet UILabel *labelRedBasketBalls;
@property (strong, nonatomic) IBOutlet UILabel *labelBlueBasketBalls;

@property (assign, nonatomic) AppDelegate *delegate;

- (IBAction)stepperChanged:(UIStepper *)sender;
- (IBAction)scoringFinished;

@end
