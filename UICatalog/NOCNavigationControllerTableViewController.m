//
//  NOCNavigationControllerTableViewController.m
//  UICatalog
//
//  Created by Benny Weingarten-Gabbay on 4/30/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "NOCNavigationControllerTableViewController.h"
#import "NOCContentController.h"

@interface NOCNavigationControllerTableViewController ()
@end

@implementation NOCNavigationControllerTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NOCContentController sharedInstance] startLiveContentEditing];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
