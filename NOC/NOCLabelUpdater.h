//
//  NOCLabelUpdater.h
//  UICatalog
//
//  Created by Benny Weingarten-Gabbay on 6/13/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NOCLabelsRegistry.h"

@interface NOCLabelUpdater : NSObject

+(void) updateLabelsInRegistry:(NOCLabelsRegistry *)labelRegistry FromDict:(NSDictionary *)updatedLabelsDict;

@end
