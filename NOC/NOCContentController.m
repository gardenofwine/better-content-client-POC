//
//  NOCContentController.m
//  UICatalog
//
//  Created by Benny Weingarten-Gabbay on 5/6/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <BlocksKit.h>
#import "SRWebSocket.h"
#import "NOCContentController.h"
#import "NOCLabelsRegistry.h"
#import "NOCLabelsRegistryDelegate.h"
#import "NOCVisibleLabelsScanner.h"
#import "NOCLabel.h"
#import "NOCLabelUpdater.h"

//#define WEBSOCKET_URL @"ws://localhost"
//#define WEBSOCKET_PORT @":5000"
//#define WEBSOCKET_URL @"http://bettercontent.herokuapp.com/"
//#define WEBSOCKET_PORT @""

@interface NOCContentController () <NOCLabelsRegistryDelegate>//, SRWebSocketDelegate>
@property (nonatomic) NOCVisibleLabelsScanner *visibleLabelsScanner;
@property (nonatomic) NOCLabelsRegistry *labelRegistry;

//@property (nonatomic) SRWebSocket *webSocket;
@end

@implementation NOCContentController

+ (void)load {
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(beginMonitoringLabels)
//                                                 name:UIApplicationDidFinishLaunchingNotification
//                                              object:nil];
}

+ (void)beginMonitoringLabels{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidFinishLaunchingNotification object:nil];
    [[NOCContentController sharedInstance] startLiveContentEditing];
}

- (void)startLiveContentEditing{
    self.visibleLabelsScanner = [NOCVisibleLabelsScanner new];
    self.labelRegistry = [NOCLabelsRegistry new];
    self.labelRegistry.delegate = self;
    [self initiateLabelScanningTask];
    
//    [self connectWebSocket];
    
}

- (void)stopLiveContentEditing{
    
}

#pragma mark - RocektSocket
//- (void)connectWebSocket {
//    self.webSocket.delegate = nil;
//    self.webSocket = nil;
//    
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", WEBSOCKET_URL, WEBSOCKET_PORT];
//    SRWebSocket *newWebSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlString]];
//    newWebSocket.delegate = self;
//    
//    [newWebSocket open];
//}

//#pragma mark - RocektSocketDelegate
//- (void)webSocketDidOpen:(SRWebSocket *)newWebSocket {
//    NSLog(@"** webSocketDidOpen");
//    self.webSocket = newWebSocket;
//    NSData *handshake = [NSJSONSerialization dataWithJSONObject:@{@"type":@"register", @"data": @"nativeApp"} options:kNilOptions error:nil];
//    [self.webSocket send:handshake];
//}
//
//- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
//    NSLog(@"** webSocket:didFailWithError %@", error);
////    [self connectWebSocket];
//}
//
//- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code
//           reason:(NSString *)reason wasClean:(BOOL)wasClean {
//    NSLog(@"** webSocket:didCloseWithCode");
//    [self connectWebSocket];
//}
//
//- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
//    NSLog(@"** string received %@", message);
//    NSData *jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
//    NSArray *json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
//    
//    [NOCLabelUpdater updateLabelsInRegistry:self.labelRegistry FromArray:json];
//    NSLog(@"** json received %@", json);
//}

#pragma mark - NOCLabelRegisrtyDelegate
- (void)visibleLabelsDidChange{
    NSLog(@"** labels changed");
    NSLog(@"** number of visible labels:%d",[self.labelRegistry currentVisibleNOCLabels].count);
    NSData *labels = [NSJSONSerialization dataWithJSONObject:@{@"type":@"labelMap", @"data": [self labelsJSON]} options:kNilOptions error:nil];
//    [self.webSocket send:labels];
}

#pragma mark - helper methods

- (void)initiateLabelScanningTask{
    __weak __typeof(&*self)weakSelf = self;
    [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
        NSDictionary *visibleLabelsDict = [weakSelf.visibleLabelsScanner currentVisibleLabels];
        NSArray *nocLabelsArray = [visibleLabelsDict.allKeys bk_map:^id(NSString *key) {
            return [[NOCLabel alloc] initWithKey:key label:[visibleLabelsDict valueForKey:key]];
        }];

        // TODO transfer all the labels to be a NSArray of NOCLables
        [weakSelf.labelRegistry setCurrentVisibleNOCLabels:nocLabelsArray];
    } repeats:YES];
}

- (BOOL)shortenLabel:(UILabel *)label{
    if (label.text.length == 0) return NO;
    NSString *text = label.text;
    label.text = [text substringToIndex:label.text.length -1];
    return YES;
}

- (NSArray *)labelsJSON{
    // TODO only send the labels that are not null
    return [self.labelRegistry.currentVisibleNOCLabels bk_map:^id(NOCLabel *nocLabel) {
        return @{@"key": nocLabel.key, @"text": [nocLabel labelText]};
    }];
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
