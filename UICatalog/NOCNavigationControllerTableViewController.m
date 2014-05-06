//
//  NOCNavigationControllerTableViewController.m
//  UICatalog
//
//  Created by Benny Weingarten-Gabbay on 4/30/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <BlocksKit.h>
#import "NOCNavigationControllerTableViewController.h"
#import "NOCVisibleLabels.h"

@interface NOCNavigationControllerTableViewController ()
@property (nonatomic) NOCVisibleLabels *visibleLabels;
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
    self.visibleLabels = [NOCVisibleLabels new];
    [self initiateLabelScanningTask];
    
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

- (void)initiateLabelScanningTask{
    __weak __typeof(&*self)weakSelf = self;
    [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
        NSDictionary *visibleLabelsDict = [weakSelf.visibleLabels currentVisibleLabels];
        [visibleLabelsDict bk_each:^(id key, id obj) {
            UILabel *label = (UILabel*) obj;
            NSLog(@"%@: %@",key, label.text);
            [weakSelf shortenLabel:label];
        }];
    } repeats:YES];
}

- (BOOL)shortenLabel:(UILabel *)label{
    if (label.text.length == 0) return NO;
    NSString *text = label.text;
    label.text = [text substringToIndex:label.text.length -1];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
