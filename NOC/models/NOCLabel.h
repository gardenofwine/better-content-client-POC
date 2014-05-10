//
//  NOCLabel.h
//  UICatalog
//
//  Created by Benny Weingarten-Gabbay on 5/10/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NOCLabel : NSObject

@property (nonatomic) NSString *key;
@property (nonatomic) UILabel *label;

-(id)initWithKey:(NSString *)key label:(UILabel *)label;
@end
