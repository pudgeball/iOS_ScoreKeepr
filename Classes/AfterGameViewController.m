//
//  AfterGameViewController.m
//  ScoreKeepriOS
//
//  Created by Nick McGuire on 2012-11-29.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import "AfterGameViewController.h"
#import "AppDelegate.h"
#import "NMScoreView.h"

@interface AfterGameViewController ()

@end

@implementation AfterGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
	{
		self.title = @"Vex";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	//_contentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	//_contentView.contentSize = CGSizeMake(320, 715);
	
	UIScrollView *scrollView1 = [[UIScrollView alloc] init];
	[scrollView1 setBackgroundColor:[UIColor redColor]];
	scrollView1.frame = CGRectMake(0, 0, 320, 300);
	scrollView1.contentSize = CGSizeMake(320, 600);
	
	UIView *view1 = [[UIView alloc] init];
	view1.frame = CGRectMake(0, 0, 320, 100);
	view1.backgroundColor = [UIColor blueColor];
	
//	[scrollView1 addSubview:view1];
	
	NMScoreView *scoreView = [[NMScoreView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) withAlliance:RedAlliance];
	[scrollView1 addSubview:scoreView];
	
	[[self view] addSubview:scrollView1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
