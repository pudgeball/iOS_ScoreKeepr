//
//  AfterView.m
//  ;
//
//  Created by Nick McGuire on 2012-12-06.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import "AfterView.h"
#import "NMScoreView.h"
#import "UIColor+VexColor.h"

@interface AfterView ()

@property (nonatomic, strong) UILabel *greenBallLabel;

@property (nonatomic, strong) UILabel *footballLabel;

@property (nonatomic, strong) UILabel *basketBallLabel;

@end

@implementation AfterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		_greenBallLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 55)];
		[_greenBallLabel setTextAlignment:NSTextAlignmentCenter];
		[_greenBallLabel setTextColor:[UIColor whiteColor]];
		[_greenBallLabel setText:@"How many Green Balls on"];
		[_greenBallLabel setBackgroundColor:[UIColor vexBlueColor]];
		[_greenBallLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
		
		_redGreenBall = [[NMScoreView alloc] initWithFrame:CGRectMake(0, _greenBallLabel.frame.size.height, 160, 130) withAlliance:RedAlliance];
		_blueGreenBall = [[NMScoreView alloc] initWithFrame:CGRectMake(160, _greenBallLabel.frame.size.height, 160, 130) withAlliance:BlueAlliance];
		
		
		_footballLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (_redGreenBall.frame.origin.y + _redGreenBall.frame.size.height), 320, 55)];
		[_footballLabel setTextAlignment:NSTextAlignmentCenter];
		[_footballLabel setTextColor:[UIColor whiteColor]];
		[_footballLabel setText:@"How many Footballs on"];
		[_footballLabel setBackgroundColor:[UIColor vexBlueColor]];
		[_footballLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
		
		_redFootball = [[NMScoreView alloc] initWithFrame:CGRectMake(0, (_footballLabel.frame.origin.y + _footballLabel.frame.size.height), 160, 130) withAlliance:RedAlliance];
		_blueFootball = [[NMScoreView alloc] initWithFrame:CGRectMake(160, (_footballLabel.frame.origin.y + _footballLabel.frame.size.height), 160, 130) withAlliance:BlueAlliance];
		
		
		_basketBallLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (_redFootball.frame.origin.y + _redFootball.frame.size.height), 320, 55)];
		[_basketBallLabel setTextAlignment:NSTextAlignmentCenter];
		[_basketBallLabel setTextColor:[UIColor whiteColor]];
		[_basketBallLabel setText:@"How many balls are in the basket on"];
		[_basketBallLabel setBackgroundColor:[UIColor vexBlueColor]];
		[_basketBallLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
		
		_redBasketBall = [[NMScoreView alloc] initWithFrame:CGRectMake(0, (_basketBallLabel.frame.origin.y + _basketBallLabel.frame.size.height), 160, 130) withAlliance:RedAlliance];
		_blueBasketBall = [[NMScoreView alloc] initWithFrame:CGRectMake(160, (_basketBallLabel.frame.origin.y + _basketBallLabel.frame.size.height), 160, 130) withAlliance:BlueAlliance];
		
		_finishedScoring = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[_finishedScoring setFrame:CGRectMake(20, (_blueBasketBall.frame.origin.y + _blueBasketBall.frame.size.height + 20), 280, 44)];
		[_finishedScoring setTitle:@"Finished Scoring" forState:UIControlStateNormal];
		
		[self setBackgroundColor:[UIColor vexBlueColor]];
    }
    return self;
}

- (void)layoutSubviews
{
	[self addSubview:_greenBallLabel];
	[self addSubview:_redGreenBall];
	[self addSubview:_blueGreenBall];
	
	[self addSubview:_footballLabel];
	[self addSubview:_redFootball];
	[self addSubview:_blueFootball];
	
	[self addSubview:_basketBallLabel];
	[self addSubview:_redBasketBall];
	[self addSubview:_blueBasketBall];
	
	[self addSubview:_finishedScoring];
}

- (NSDictionary *)getRedScores
{
	return @{ @"GreenBalls" : [_redGreenBall getScore], @"FootBalls" : [_redFootball getScore], @"BasketBalls" : [_redBasketBall getScore]};
}

- (NSDictionary *)getBlueScores
{
	return @{ @"GreenBalls" : [_blueGreenBall getScore], @"FootBalls" : [_blueFootball getScore], @"BasketBalls" : [_blueBasketBall getScore]};
}

@end
