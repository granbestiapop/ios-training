//
//  Photo+CoreDataProperties.m
//  Attributor
//
//  Created by Leonardo Clavijo on 3/7/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Photo+CoreDataProperties.h"

@implementation Photo (CoreDataProperties)

+ (NSFetchRequest<Photo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Photo"];
}

@dynamic title;
@dynamic subtitle;
@dynamic unique;
@dynamic url;
@dynamic photographer;

@end
