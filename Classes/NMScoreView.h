//
//  NMScoreView.h
//  ScoreKeepriOS
//
//  Created by Nick McGuire on 2012-12-06.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NMAlliance) {
	RedAlliance,
	BlueAlliance
};

@protocol NMScoreViewDelegate;

@interface NMScoreView : UIView

@property (nonatomic, weak) id <NMScoreViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame withAlliance:(NMAlliance *)alliance;

@end


@protocol NMScoreViewDelegate <NSObject>

@required

- (void)scoreWasUpdatedToValue:(NSNumber *)score;

@end