//
//  NOCVisibleLabels.m
//  UICatalog
//
//  Created by Benny Weingarten-Gabbay on 5/5/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <BlocksKit.h>

#import "NOCVisibleLabelsScanner.h"

@implementation NOCVisibleLabelsScanner

- (NSDictionary *)currentVisibleLabels{
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];

    NSMutableDictionary *visibleLabels = [NSMutableDictionary new];
    
    [self collectVisibleLabels:[topWindow subviews] inDictionary:visibleLabels];
    return visibleLabels;
}

- (void)collectVisibleLabels:(NSArray *)views inDictionary:(NSMutableDictionary *)labelDictionary{
    __weak typeof(self) weakSelf = self;
    [views bk_each:^(UIView *view) {
        if ([view isKindOfClass:[UILabel class]]){
            UILabel *label = (UILabel *)view;
            // TODO only add labels that are visible on sceen
            if (label.text && !label.hidden){
                [labelDictionary setObject:view forKey:[weakSelf memoryAddress:view]];
            }
        }
        
        [weakSelf collectVisibleLabels:[view subviews] inDictionary:labelDictionary];
    }];
}

- (NSString *)memoryAddress:(NSObject *)object{
    return [NSString stringWithFormat:@"%p", object];
}
@end
