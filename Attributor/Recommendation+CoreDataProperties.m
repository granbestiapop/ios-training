//
//  Recommendation+CoreDataProperties.m
//  Attributor
//
//  Created by Leonardo Clavijo on 3/8/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Recommendation+CoreDataProperties.h"

@implementation Recommendation (CoreDataProperties)

+ (NSFetchRequest<Recommendation *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Recommendation"];
}

@dynamic thumbnail;
@dynamic price;
@dynamic desc;

@end
