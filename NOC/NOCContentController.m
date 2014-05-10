//
//  NOCContentController.m
//  UICatalog
//
//  Created by Benny Weingarten-Gabbay on 5/6/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <BlocksKit.h>
#import "NOCContentController.h"
#import "NOCLabelsRegistry.h"
#import "NOCLabelsRegistryDelegate.h"
#import "NOCVisibleLabelsScanner.h"
#import "NOCLabel.h"

@interface NOCContentController () <NOCLabelsRegistryDelegate>
@property (nonatomic) NOCVisibleLabelsScanner *visibleLabelsScanner;
@property (nonatomic) NOCLabelsRegistry *labelRegistry;
@end

@implementation NOCContentController

- (void)startLiveContentEditing{
    self.visibleLabelsScanner = [NOCVisibleLabelsScanner new];
    self.labelRegistry = [NOCLabelsRegistry new];
    self.labelRegistry.delegate = self;
    [self initiateLabelScanningTask];
}

- (void)stopLiveContentEditing{
    
}

#pragma mark - NOCLabelRegisrtyDelegate
- (void)visibleLabelsDidChange{
    NSLog(@"** labels changed");
    NSLog(@"** number of visible labels:%d",[self.labelRegistry currentVisibleNOCLabels].count);
}

#pragma mark - helper methods

- (void)initiateLabelScanningTask{
    __weak __typeof(&*self)weakSelf = self;
    [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
        NSDictionary *visibleLabelsDict = [weakSelf.visibleLabelsScanner currentVisibleLabels];
        [self.labelRegistry setCurrentVisibleLabels:visibleLabelsDict];
    } repeats:YES];
}

- (BOOL)shortenLabel:(UILabel *)label{
    if (label.text.length == 0) return NO;
    NSString *text = label.text;
    label.text = [text substringToIndex:label.text.length -1];
    return YES;
}

#pragma mark - singelton

+ (NOCContentController *)sharedInstance {
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static NOCContentController * _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}
@end
