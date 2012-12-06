//
//  NMScoreView.m
//  ScoreKeepriOS
//
//  Created by Nick McGuire on 2012-12-06.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import "NMScoreView.h"

@interface NMScoreView ()

@property (strong, nonatomic) UIStepper *counter;

- (void)counterUpdated:(UIStepper *)sender;

@end

@implementation NMScoreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		_counter = [[UIStepper alloc] init];
		[_counter addTarget:self action:@selector(counterUpdated:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)counterUpdated:(UIStepper *)sender
{
	NSLog(@"Counter Updated: %f", sender.value);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
