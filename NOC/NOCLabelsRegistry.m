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

- (void)setCurrentVisibleNOCLabels:(NSArray *)currentVisibleNOCLabels{
    self.visibleLabelsChanged = NO;
    [self intersectCurrentLabelsWithLabelsFromArray:currentVisibleNOCLabels];
    [self updateCurrentLabelsFromArray:currentVisibleNOCLabels];
    if (self.visibleLabelsChanged) {
        [self.delegate visibleLabelsDidChange];        
    }
}

#pragma mark - helpers
- (void)intersectCurrentLabelsWithLabelsFromArray:(NSArray *)labelsArray{
    NSMutableSet *currentNOCLabelsSet = [NSMutableSet setWithArray:self.visibleNOCLabels];
    NSMutableSet *newNOCLabelsSet = [NSMutableSet setWithArray:labelsArray];
    [currentNOCLabelsSet intersectSet:newNOCLabelsSet];
    if (currentNOCLabelsSet.count < self.visibleNOCLabels.count) self.visibleLabelsChanged = YES;
    NSLog(@"** removing %i labels", self.visibleNOCLabels.count - currentNOCLabelsSet.count);
    self.visibleNOCLabels = [[currentNOCLabelsSet allObjects] mutableCopy];
}

- (void)updateCurrentLabelsFromArray:(NSArray *)labelsArray{
    __weak __typeof(&*self)weakSelf = self;
    [labelsArray bk_each:^(NOCLabel *newNOCLabel) {
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
