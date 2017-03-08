//
//  Photo+CoreDataProperties.h
//  Attributor
//
//  Created by Leonardo Clavijo on 3/7/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Photo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Photo (CoreDataProperties)

+ (NSFetchRequest<Photo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *subtitle;
@property (nullable, nonatomic, copy) NSString *unique;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, retain) Photographer *photographer;

@end

NS_ASSUME_NONNULL_END
