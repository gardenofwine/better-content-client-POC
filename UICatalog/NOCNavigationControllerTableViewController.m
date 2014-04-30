//
//  NOCNavigationControllerTableViewController.m
//  UICatalog
//
//  Created by Benny Weingarten-Gabbay on 4/30/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <BlocksKit.h>
#import "NOCNavigationControllerTableViewController.h"

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.title = @"NoContent experiment";
    __weak __typeof(&*self)weakSelf = self;
    [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
        if (weakSelf.title.length == 0){
            [timer invalidate];
            return;
        }
        NSString *text = weakSelf.title;
        weakSelf.title = [text substringToIndex:weakSelf.title.length -1];
    } repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
