//
//  DetailViewController.m
//  ScoreKeepriOS
//
//  Created by Nicholas McGuire on 2012-11-12.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController ()
- (void)cancel;
@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
	[[self navigationItem] setLeftBarButtonItem:cancelButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Connected";
    }
    return self;
}

- (void)cancel
{
	[[_delegate server] stop];
	[[self navigationController] popViewControllerAnimated:YES];
}
							
@end
