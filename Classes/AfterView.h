//
//  AfterView.h
//  ScoreKeepriOS
//
//  Created by Nick McGuire on 2012-12-06.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NMScoreView;

@interface AfterView : UIView

@property (nonatomic, strong) NMScoreView *redGreenBall;
@property (nonatomic, strong) NMScoreView *blueGreenBall;

@property (nonatomic, strong) NMScoreView *redFootball;
@property (nonatomic, strong) NMScoreView *blueFootball;

@property (nonatomic, strong) NMScoreView *redBasketBall;
@property (nonatomic, strong) NMScoreView *blueBasketBall;

@property (nonatomic, strong) UIButton *finishedScoring;

- (NSDictionary *)getRedScores;
- (NSDictionary *)getBlueScores;

@end
