//
//  Recommendation+CoreDataProperties.h
//  Attributor
//
//  Created by Leonardo Clavijo on 3/8/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Recommendation+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Recommendation (CoreDataProperties)

+ (NSFetchRequest<Recommendation *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *thumbnail;
@property (nullable, nonatomic, copy) NSString *price;
@property (nullable, nonatomic, copy) NSString *desc;

@end

NS_ASSUME_NONNULL_END
