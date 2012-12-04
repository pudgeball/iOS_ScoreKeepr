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
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Vex";
		
		_objects = [[NSMutableArray alloc] init];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

	cell.textLabel.text = [[_objects objectAtIndex:indexPath.row] name];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[_delegate connectToService:[_objects objectAtIndex:indexPath.row]];
}

- (void)serviceAdded:(NSNetService *)service moreComing:(BOOL)more
{
	[_objects addObject:service];
    if(!more) [[self tableView] reloadData];
}

- (void)serviceRemoved:(NSNetService *)service moreComing:(BOOL)more
{
	[_objects removeObject:service];
    if(!more) [self.tableView reloadData];
}

@end
