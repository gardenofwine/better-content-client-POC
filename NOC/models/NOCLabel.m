//
//  NOCLabel.m
//  UICatalog
//
//  Created by Benny Weingarten-Gabbay on 5/10/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "NOCLabel.h"

@implementation NOCLabel

-(id)initWithKey:(NSString *)key label:(UILabel *)label {
    self = [super init];
    if (self) {
        self.key = key;
        self.label = label;
    }
    return self;
}

- (BOOL)isEqual:(id)object{
    NOCLabel *otherNOCLabel = (NOCLabel *)object;
    return [self.key isEqual:otherNOCLabel.key];
}

- (NSUInteger)hash{
    return self.key.hash;
}

@end
