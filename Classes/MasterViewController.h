//
//  MasterViewController.h
//  ScoreKeepriOS
//
//  Created by Nicholas McGuire on 2012-11-12.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;
@class Server;

@interface MasterViewController : UITableViewController

@property (assign, nonatomic) Server *server;
@property (assign, nonatomic) AppDelegate *delegate;

- (void)serviceAdded:(NSNetService *)service moreComing:(BOOL)more;
- (void)serviceRemoved:(NSNetService *)service moreComing:(BOOL)more;

@end
