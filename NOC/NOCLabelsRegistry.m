//
//  NOCLabelsRegistry.m
//  UICatalog
//
//  Created by Benny Weingarten-Gabbay on 5/6/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <BlocksKit.h>

#import "NOCLabelsRegistry.h"
#import "NOCLabel.h"

@interface NOCLabelsRegistry ()
@property (nonatomic) NSMutableArray *visibleNOCLabels;
@property (nonatomic) BOOL visibleLabelsChanged;
@end

@implementation NOCLabelsRegistry

- (instancetype)init{
    self = [super init];
    if (self) {
        self.visibleNOCLabels = [NSMutableArray new];
    }
    return self;
}

- (NSArray *)currentVisibleNOCLabels{
    return self.visibleNOCLabels;
}

- (void)setCurrentVisibleLabels:(NSDictionary *)labelsDict{
    self.visibleLabelsChanged = NO;
    [self removeNOCLabelsNotVisibleInDict:labelsDict];
    [self updateLabelsFromDict:labelsDict];
    if (self.visibleLabelsChanged) [self.delegate visibleLabelsDidChange];
}


#pragma mark - helpers
- (void)removeNOCLabelsNotVisibleInDict:(NSDictionary *)labelsDict{
    __weak __typeof(&*self)weakSelf = self;
    [self.visibleNOCLabels bk_each:^(NOCLabel *nocLabel) {
        if (![labelsDict valueForKey:nocLabel.key]){
            [weakSelf.visibleNOCLabels removeObject:nocLabel];
            weakSelf.visibleLabelsChanged = YES;
        }
    }];
}

- (void)updateLabelsFromDict:(NSDictionary *)labelsDict{
    __weak __typeof(&*self)weakSelf = self;
    [labelsDict.allKeys bk_each:^(NSString *key) {
        NOCLabel *newNOCLabel = [[NOCLabel alloc] initWithKey:key label:[labelsDict valueForKey:key]];
        if ([weakSelf.visibleNOCLabels containsObject:newNOCLabel]){
            int nocLabelIndex = [weakSelf.visibleNOCLabels indexOfObject:newNOCLabel];
            NOCLabel *currentNOCLabel = [weakSelf.visibleNOCLabels objectAtIndex:nocLabelIndex];
            if (![currentNOCLabel.label.text isEqualToString:newNOCLabel.label.text]){
                currentNOCLabel.label.text = newNOCLabel.label.text;
                weakSelf.visibleLabelsChanged = YES;
            }
        } else {
            [weakSelf.visibleNOCLabels addObject:newNOCLabel];
            weakSelf.visibleLabelsChanged = YES;

        }
    }];

}

@end
