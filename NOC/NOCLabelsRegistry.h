//
//  NOCLabelsRegistry.h
//  UICatalog
//
//  Created by Benny Weingarten-Gabbay on 5/6/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NOCLabelsRegistryDelegate.h"

@interface NOCLabelsRegistry : NSObject

@property (nonatomic, weak) id <NOCLabelsRegistryDelegate> delegate;
@property (nonatomic) NSArray *currentVisibleNOCLabels;
//- (NSArray *)currentVisibleNOCLabels;
//- (void)setCurrentVisibleLabels:(NSDictionary *)labelsDict;

//- (NSArray *)labelsJSON;

@end
