//
//  AfterGameViewController.m
//  ScoreKeepriOS
//
//  Created by Nick McGuire on 2012-11-29.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import "AfterGameViewController.h"
#import "AppDelegate.h"
#import "AfterView.h"
#import "UIColor+VexColor.h"

@interface AfterGameViewController ()

@property (strong, nonatomic) AfterView *afterView;

@end

@implementation AfterGameViewController

- (id)init
{
	self = [super init];
	if (self)
	{
		self.title = @"Vex";
		
		UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
		[scrollView setContentSize:CGSizeMake(320, 640)];
		[scrollView setBackgroundColor:[UIColor vexBlueColor]];
		
		_afterView = [[AfterView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, scrollView.contentSize.height)];
		[_afterView.finishedScoring addTarget:self
									   action:@selector(scoringFinished)
							 forControlEvents:UIControlEventTouchUpInside];
		
		[scrollView addSubview:_afterView];
		
		[self setView:scrollView];
	}
	
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)scoringFinished
{
	[_delegate scoringCompletedWithResults:@{ @"Red" : [_afterView getRedScores], @"Blue" : [_afterView getBlueScores] }];
}

@end
