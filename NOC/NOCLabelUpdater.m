//
//  NOCLabelUpdater.m
//  UICatalog
//
//  Created by Benny Weingarten-Gabbay on 6/13/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <BlocksKit.h>
#import "NOCLabelUpdater.h"
#import "NOCLabel.h"

@implementation NOCLabelUpdater

+(void) updateLabelsInRegistry:(NOCLabelsRegistry *)labelRegistry FromArray:(NSArray *)updatedLabelsArray{
    NSArray *currentLabels = labelRegistry.currentVisibleNOCLabels;
    [updatedLabelsArray bk_each:^(NSDictionary *labelJSON) {
        NOCLabel *nocLabel = [[NOCLabel alloc] initWithKey:[labelJSON objectForKey:@"key"] label:nil];
        NSUInteger currentLabelIndex = [currentLabels indexOfObject:nocLabel];
        if (currentLabelIndex != NSNotFound) {
            NOCLabel *currentNOCLabel = [currentLabels objectAtIndex:currentLabelIndex];
            if (currentNOCLabel.label) currentNOCLabel.label.text = [labelJSON objectForKey:@"text"];
        }
    }];
}

@end
