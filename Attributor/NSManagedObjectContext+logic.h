//
//  NSManagedObjectContext+logic.h
//  Attributor
//
//  Created by Leonardo Clavijo on 3/8/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (logic)
-(void) deleteAllFromEntity:(NSString *)entityName;
-(void) saveAll: (NSArray *) recommendations;
-(void) cleanAndSaveAll: (NSArray *) recommendations;
@end
