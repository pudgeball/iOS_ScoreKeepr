//
//  AfterGameViewController.m
//  ScoreKeepriOS
//
//  Created by Nick McGuire on 2012-11-29.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import "AfterGameViewController.h"
#import "AppDelegate.h"

@interface AfterGameViewController ()

@end

@implementation AfterGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		NSLog(@"zomg");
		self.title = @"Vex";
		self.navigationItem.backBarButtonItem = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	_contentView.contentSize = CGSizeMake(320, 600);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)stepperChanged:(UIStepper *)sender
{
	NSString *value = [NSString stringWithFormat:@"%i", (int)sender.value];
	switch (sender.tag)
	{
		case 0:
			_labelRedGreenBalls.text = value;
			break;
		case 1:
			_labelBlueGreenBalls.text = value;
			break;
		case 2:
			_labelRedFootBalls.text = value;
			break;
		case 3:
			_labelBlueFootBalls.text = value;
			break;
		case 4:
			_labelRedBasketBalls.text = value;
			break;
		case 5:
			_labelBlueBasketBalls.text = value;
			break;
		default:
			NSLog(@"Something went wrong in stepperChanged:");
			break;
	}
}

- (IBAction)scoringFinished
{
	NSDictionary *redResults = @{ @"GreenBalls" : _labelRedGreenBalls.text, @"FootBalls" : _labelRedFootBalls.text, @"BasketBalls" : _labelRedBasketBalls.text };
	NSDictionary *blueResults = @{ @"GreenBalls" : _labelBlueGreenBalls.text, @"FootBalls" : _labelBlueFootBalls.text, @"BasketBalls" : _labelBlueBasketBalls.text };
	
	NSDictionary *results = @{ @"Red" : redResults, @"Blue" : blueResults };
	
	[_delegate scoringCompletedWithResults:results];
}

@end
