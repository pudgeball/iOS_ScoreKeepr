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
	NSLog(@"Application Will Resign");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	NSLog(@"Headed to the background");
	
	if (_serverPickerView)
	{
		[_serverPickerView emptyServerList];
	}
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
	
}

- (void)applicationWillTerminate:(UIApplication *)application
{
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
	
	NSDictionary *message = @{ @"Type" : @"InGame", @"Red" : [results objectForKey:@"RedScore"], @"Blue" : [results objectForKey:@"BlueScore"] };
	
	NSError *error = nil;
	NSData *messageData = [NSJSONSerialization dataWithJSONObject:message options:NSJSONWritingPrettyPrinted error:&error];
	if (!error)
	{
		error = nil;
		[_server sendData:messageData error:&error];
		if (error)
		{
			NSLog(@"Error sending InGame message");
		}
	}
	else
	{
		NSLog(@"Error creating JSON for InGame Message");
	}
	
	_ingameView = nil;
	_afterView = [[AfterGameViewController alloc] init];
	_afterView.delegate = self;
	[self.modalNavigationController pushViewController:_afterView animated:YES];
}

- (void)scoringCompletedWithResults:(NSDictionary *)results
{
	NSLog(@"Scoring Did finish with results: %@", results);
	
	NSDictionary *message = @{ @"Type" : @"AfterGame", @"Red" : [results objectForKey:@"Red"], @"Blue" : [results objectForKey:@"Blue"] };
	NSError *error = nil;
	NSData *messageData = [NSJSONSerialization dataWithJSONObject:message options:NSJSONWritingPrettyPrinted error:&error];
	if (!error)
	{
		error = nil;
		[_server sendData:messageData error:&error];
		if (error)
		{
			NSLog(@"Error sending AfterGame message");
		}
	}
	else
	{
		NSLog(@"Error creating JSON for AfterGame message");
	}
	
	_afterView = nil;
	[self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)resetInterface
{
	[_serverPickerView emptyServerList];
	
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
    NSLog(@"Server did accept data");
	
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
