//
//  InGameViewController.m
//  ScoreKeepriOS
//
//  Created by Nick McGuire on 2012-11-29.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import "InGameViewController.h"
#import "AppDelegate.h"

@interface InGameViewController ()

@end

@implementation InGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Vex";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.navigationItem.backBarButtonItem = nil;
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
			_labelRedScore.text = value;
			break;
		case 1:
			_labelBlueScore.text = value;
			break;
		default:
			NSLog(@"Something went wrong in stepperChanged:");
			break;
	}
}

- (IBAction)matchFinished
{
	NSDictionary *results = @{ @"RedScore" : _labelRedScore.text,
								@"BlueScore" : _labelBlueScore.text };
	self.title = @"";
	[_delegate inGameEndedWithResults:results];
}

@end
