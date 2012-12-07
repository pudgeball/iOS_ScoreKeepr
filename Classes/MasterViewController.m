//
//  MasterViewController.m
//  ScoreKeepriOS
//
//  Created by Nicholas McGuire on 2012-11-12.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import "MasterViewController.h"

#import "AppDelegate.h"
#import "Server.h"

@interface MasterViewController ()
{
    NSMutableArray *_serverList;
}
@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Vex";
		
		_serverList = [[NSMutableArray alloc] init];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	NSError *error = nil;
	[[_delegate server] start:&error];
	
	if (!error)
	{
		NSLog(@"Started server again");
	}
	
	[[self tableView] reloadData];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	[self emptyServerList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)emptyServerList
{
	[_serverList removeAllObjects];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _serverList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

	cell.textLabel.text = [[_serverList objectAtIndex:indexPath.row] name];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[_delegate connectToService:[_serverList objectAtIndex:indexPath.row]];
}

- (void)serviceAdded:(NSNetService *)service moreComing:(BOOL)more
{
	[_serverList addObject:service];
    if(!more) [[self tableView] reloadData];
}

- (void)serviceRemoved:(NSNetService *)service moreComing:(BOOL)more
{
	[_serverList removeObject:service];
    if(!more) [[self tableView] reloadData];
}

@end
