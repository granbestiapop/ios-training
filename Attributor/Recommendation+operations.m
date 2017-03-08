//
//  Recommendation+operations.m
//  Attributor
//
//  Created by Leonardo Clavijo on 3/8/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//

#import "Recommendation+operations.h"

@implementation Recommendation (operations)

+(void ) store: (NSDictionary*) dic :(NSManagedObjectContext*)context
{
    Recommendation *rec = [NSEntityDescription
                    insertNewObjectForEntityForName:@"Recommendation"
                    inManagedObjectContext:context];
    rec.price = [dic valueForKey:@"price"];
    rec.desc = [dic valueForKey:@"description"];
    rec.thumbnail = [dic valueForKey:@"thumbnail"];
    
    NSError * error;
    if(![context save: &error]){
        NSLog(@"Error persiting recommendation");
    }
}
@end
