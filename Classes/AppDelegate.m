//
//  AppDelegate.m
//  ScoreKeepriOS
//
//  Created by Nicholas McGuire on 2012-11-12.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import "AppDelegate.h"

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AutonomousViewController.h"
#import "InGameViewController.h"
#import "AfterGameViewController.h"
#import "UIColor+VexColor.h"

@interface AppDelegate()

@property (strong, nonatomic) AutonomousViewController *autonomousView;
@property (strong, nonatomic) InGameViewController *ingameView;
@property (strong, nonatomic) AfterGameViewController *afterView;
@property (strong, nonatomic) MasterViewController *serverPickerView;
@property (strong, nonatomic) DetailViewController *waitingView;
@property (strong, nonatomic) UINavigationController *modalNavigationController;

@property (nonatomic) BOOL inMatch;

- (void)resetInterface;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	_server = [[Server alloc] initWithProtocol:@"Vex"];
	_server.delegate = self;
	
	_serverPickerView = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
	_serverPickerView.delegate = self;
	self.navigationController = [[UINavigationController alloc] initWithRootViewController:_serverPickerView];
	
	[[self.navigationController navigationBar] setTintColor:[UIColor vexRedColor]];
	self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	NSLog(@"Headed to the background");
	[_server stop];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	NSLog(@"Entering ForeGround");
	NSError *error = nil;
	[_server start:&error];
	if (error)
	{
		NSLog(@"Woah error occured when entering foreground: %@", error);
	}
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	NSLog(@"Exiting App");
}

- (void)connectToService:(NSNetService *)service
{
	[_server connectToRemoteService:service];
}

- (void)autonomousEndedWithOutput:(NSDictionary *)results
{
	NSLog(@"Autonomous Endeded With Output: %@", results);
	NSDictionary *message = @{ @"Type" : @"Autonomous", @"Winner" : [results objectForKey:@"Winner"] };
	NSError *error = nil;
	NSData *messageData = [NSJSONSerialization dataWithJSONObject:message options:NSJSONWritingPrettyPrinted error:&error];
	if (!error)
	{
		error = nil;
		[_server sendData:messageData error:&error];
		
		if (error)
		{
			NSLog(@"Error sending Autonomous Message");
		}
	}
	else
	{
		NSLog(@"Error creating JSON for Autonomous Message");
	}
	
	_autonomousView = nil;
	_ingameView = [[InGameViewController alloc] initWithNibName:@"InGameViewController" bundle:nil];
	_ingameView.delegate = self;
	[self.modalNavigationController pushViewController:_ingameView animated:YES];
}

- (void)inGameEndedWithResults:(NSDictionary *)results
{
	NSLog(@"InGame Ended with Results: %@", results);
	_ingameView = nil;
	_afterView = [[AfterGameViewController alloc] initWithNibName:@"AfterGameViewController" bundle:nil];
	_afterView.delegate = self;
	[self.modalNavigationController pushViewController:_afterView animated:YES];
}

- (void)scoringCompletedWithResults:(NSDictionary *)results
{
	NSLog(@"Scoring Did finish with results: %@", results);
	_afterView = nil;
	[self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)resetInterface
{
	if (_inMatch)
	{
		[self.navigationController dismissViewControllerAnimated:YES completion:NULL];
	}
	
	[self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - ServerDelegate
- (void)serverRemoteConnectionComplete:(Server *)server
{
    NSLog(@"Connected to service");
	_inMatch = YES;
	[_server stopBrowser];
	
	_waitingView = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
	_waitingView.delegate = self;
	[self.navigationController pushViewController:_waitingView animated:YES];
}

- (void)serverStopped:(Server *)server
{
    NSLog(@"Disconnected from service");
	
	[self resetInterface];
	
	_inMatch = NO;
}

- (void)server:(Server *)server didNotStart:(NSDictionary *)errorDict
{
    NSLog(@"Server did not start %@", errorDict);
}

- (void)server:(Server *)server didAcceptData:(NSData *)data
{
    NSLog(@"Server did accept data %@", data);
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	
	NSError *error = nil;
	NSDictionary *messageDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
	
	if ([[messageDict objectForKey:@"Type"] isEqualToString:@"Begin"])
	{
		_inMatch = YES;
		_autonomousView = [[AutonomousViewController alloc] initWithNibName:@"AutonomousViewController" bundle:nil];
		_autonomousView.delegate = self;
		_modalNavigationController = [[UINavigationController alloc] initWithRootViewController:_autonomousView];
		[[_modalNavigationController navigationBar] setTintColor:[UIColor vexRedColor]];
		[self.navigationController presentViewController:_modalNavigationController animated:YES completion:NULL];
	}
	
    if(nil != message || [message length] > 0) {
		NSLog(@"Message: %@", message);
		if ([message isEqualToString:@"BeginMatch"])
		{
			
		}
    } else {
        NSLog(@"no message received");
    }
}

- (void)server:(Server *)server lostConnection:(NSDictionary *)errorDict
{
	NSLog(@"Lost connection");
	[self resetInterface];
}

- (void)serviceAdded:(NSNetService *)service moreComing:(BOOL)more
{
	NSLog(@"Added a service: %@", [service name]);
	
    [_serverPickerView serviceAdded:service moreComing:more];
}

- (void)serviceRemoved:(NSNetService *)service moreComing:(BOOL)more
{
	NSLog(@"Removed a service: %@", [service name]);
	[_serverPickerView serviceRemoved:service moreComing:more];
    
}

@end
