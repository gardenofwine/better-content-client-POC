//
//  NOCVisibleLabels.m
//  UICatalog
//
//  Created by Benny Weingarten-Gabbay on 5/5/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <BlocksKit.h>

#import "NOCVisibleLabels.h"

@interface NOCVisibleLabels ()

@property (nonatomic) NSMutableDictionary *visibleLabels;
@end


@implementation NOCVisibleLabels

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.visibleLabels = [NSMutableDictionary new];
    }
    return self;
}

- (NSDictionary *)currentVisibleLabels{
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    
    [self collectVisibleLabels:[topWindow subviews]];
    
    return self.visibleLabels;
}

- (void)collectVisibleLabels:(NSArray *)views{
    __weak typeof(self) weakSelf = self;
    [views bk_each:^(UIView *view) {
        if ([view isKindOfClass:[UILabel class]]){
            [weakSelf.visibleLabels setObject:view forKey:[weakSelf memoryAddress:view]];
        }
        
        [weakSelf collectVisibleLabels:[view subviews]];
    }];
}

- (NSString *)memoryAddress:(NSObject *)object{
    return [NSString stringWithFormat:@"%p", object];
}
@end
