//
//  NMScoreView.m
//  ScoreKeepriOS
//
//  Created by Nick McGuire on 2012-12-06.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import "NMScoreView.h"
#import "UIColor+VexColor.h"

@interface NMScoreView ()

@property (strong, nonatomic) UIStepper *counter;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *score;

- (void)counterUpdated:(UIStepper *)sender;

@end

@implementation NMScoreView

- (id)initWithFrame:(CGRect)frame withAlliance:(NMAlliance )alliance
{
    self = [super initWithFrame:frame];
    if (self)
	{
		_counter = [[UIStepper alloc] init];
		[_counter addTarget:self
					 action:@selector(counterUpdated:)
		   forControlEvents:UIControlEventValueChanged];
		
		_title = [[UILabel alloc] init];
		[_title setFont:[UIFont boldSystemFontOfSize:17.0f]];
		[_title setTextColor:[UIColor whiteColor]];
		[_title setTextAlignment:NSTextAlignmentCenter];
		
		if (alliance == RedAlliance)
		{
			[_title setBackgroundColor:[UIColor redColor]];
			[_title setText:@"Red"];
		}
		else
		{
			[_title setBackgroundColor:[UIColor blueColor]];
			[_title setText:@"Blue"];
		}
		
		_score = [[UILabel alloc] init];
		[_score setFont:[UIFont boldSystemFontOfSize:17.0f]];
		[_score setBackgroundColor:[UIColor vexYellowColor]];
		[_score setTextAlignment:NSTextAlignmentCenter];
		[_score setText:[NSString stringWithFormat:@"%i", (int)_counter.value]];

		[self setBackgroundColor:[UIColor vexYellowColor]];
		[self setFrame:CGRectMake(frame.origin.x, frame.origin.y, 160, 130)];
    }
    return self;
}

- (void)layoutSubviews
{	
	[_title setFrame:CGRectMake(0, 20, 160, 20)];
	[_score setFrame:CGRectMake(0, 50, 160, 20)];
	[_counter setFrame:CGRectMake(33, 85, 160, 50)];
	
	[self addSubview:_title];
	[self addSubview:_score];
	[self addSubview:_counter];
}

- (void)counterUpdated:(UIStepper *)sender
{
	[_score setText:[NSString stringWithFormat:@"%i", (int)_counter.value]];
}

- (NSNumber *)getScore
{
	return [NSNumber numberWithInt:(int)_counter.value];
}

@end
