//
//  NSManagedObjectContext+logic.m
//  Attributor
//
//  Created by Leonardo Clavijo on 3/8/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//

#import "NSManagedObjectContext+logic.h"
#import "Recommendation+CoreDataClass.h"

@implementation NSManagedObjectContext (logic)

-(void) deleteAllFromEntity:(NSString *)entityName {
    NSFetchRequest * allRecords = [[NSFetchRequest alloc] init];
    [allRecords setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:self]];
    [allRecords setIncludesPropertyValues:NO];
    NSError * error = nil;
    NSArray * result = [self executeFetchRequest:allRecords error:&error];
    for (NSManagedObject * profile in result) {
        [self deleteObject:profile];
        NSError *saveError;
        [self save:&saveError];
    }

}

-(void ) saveAll: (NSArray *) recommendations
{
    NSError * error;
    for(NSDictionary* dic in recommendations){
        Recommendation *rec = [NSEntityDescription
                               insertNewObjectForEntityForName:@"Recommendation"
                               inManagedObjectContext:self];
        rec.price = [dic valueForKey:@"price"];
        rec.desc = [dic valueForKey:@"description"];
        rec.thumbnail = [dic valueForKey:@"thumbnail"];
        if(![self save: &error]){
            NSLog(@"Error on persistence Recommendation");
        }
    }
    

}

-(void ) cleanAndSaveAll: (NSArray *) recommendations
{
    
    [self deleteAllFromEntity:@"Recommendation"];
    [self saveAll:recommendations];
}

@end
