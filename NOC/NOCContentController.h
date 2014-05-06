//
//  NOCContentController.h
//  UICatalog
//
//  Created by Benny Weingarten-Gabbay on 5/6/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NOCContentController : NSObject

- (void)startLiveContentEditing;
- (void)stopLiveContentEditing;

+ (NOCContentController *)sharedInstance;

@end
