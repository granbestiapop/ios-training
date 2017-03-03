//
//  CustomBehavior.m
//  Attributor
//
//  Created by Leonardo Clavijo on 3/3/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//

#import "CustomBehavior.h"

@interface CustomBehavior()
@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UICollisionBehavior *collision;
@property (nonatomic, strong) UIDynamicItemBehavior *animationOptions;

@end

@implementation CustomBehavior

#pragma mark - Initializers
- (instancetype)init
{
    self = [super init];
    
    [self addChildBehavior: self.gravity];
    [self addChildBehavior: self.collision];
    [self addChildBehavior: self.animationOptions];
    
    return self;
}


- (UIGravityBehavior*) gravity
{
    if(!_gravity){
        _gravity = [[UIGravityBehavior alloc] init];
        _gravity.magnitude = 0.9;
    }
    return _gravity;
}

- (UICollisionBehavior*) collision
{
    if(!_collision){
        _collision = [[UICollisionBehavior alloc] init];
        _collision.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collision;
}

/*
 Animation rules
 */
-(UIDynamicItemBehavior *) animationOptions
{
    if(!_animationOptions){
        _animationOptions = [[UIDynamicItemBehavior alloc] init];
        _animationOptions.allowsRotation = NO;
        
    }
    return _animationOptions;
}

#pragma mark - implementations

- (void) addItem: (id <UIDynamicItem>) item
{
    [self.gravity addItem:item];
    [self.collision addItem:item];
    [self.animationOptions addItem:item];
}

- (void) removeItem: (id <UIDynamicItem>) item
{
    [self.gravity removeItem:item];
    [self.collision removeItem:item];
    [self.animationOptions removeItem:item];
}

@end
