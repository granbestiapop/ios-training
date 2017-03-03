//
//  CustomBehavior.h
//  Attributor
//
//  Created by Leonardo Clavijo on 3/3/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBehavior : UIDynamicBehavior
- (void) addItem: (id <UIDynamicItem>) item;
- (void) removeItem: (id <UIDynamicItem>) item;

@end
