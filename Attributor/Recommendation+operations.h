//
//  Recommendation+operations.h
//  Attributor
//
//  Created by Leonardo Clavijo on 3/8/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//

#import "Recommendation+CoreDataClass.h"

@interface Recommendation (operations)
+(void ) store: (NSDictionary*) dic :(NSManagedObjectContext*)context;
@end
