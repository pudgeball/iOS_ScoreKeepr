//
//  AutonomousViewController.m
//  ScoreKeepriOS
//
//  Created by Nick McGuire on 2012-11-29.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import "AutonomousViewController.h"
#import "AppDelegate.h"

@interface AutonomousViewController ()

@end

@implementation AutonomousViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Vex";
    }
    return self;
}

- (IBAction)optionSelected:(id)sender
{
	UIButton *button = (UIButton *)sender;
	NSString *winner = @" ";
	switch (button.tag)
	{
		case RedAlliance:
			winner = @"red";
			break;
		case BlueAlliance:
			winner = @"blue";
			break;
		case NoAlliance:
			winner = @"no";
			break;
		default:
			winner = @"Err";
			break;
	}
	
	NSDictionary *results = @{ @"Winner" : winner };
	
	self.title = @"";
	[_delegate autonomousEndedWithOutput:results];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
