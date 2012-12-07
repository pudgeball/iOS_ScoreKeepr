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

@interface NMScoreView : UIView

- (id)initWithFrame:(CGRect)frame withAlliance:(NMAlliance *)alliance;

@end
