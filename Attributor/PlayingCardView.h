//
//  PlayingCardView.h
//  Attributor
//
//  Created by Leonardo Clavijo on 3/2/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView
@property NSInteger rank;
@property (strong, nonatomic) NSString *suite;
@property (nonatomic) CGFloat faceCardScaleFactor;
@property (nonatomic) BOOL faceUp;

- (void) pinch: (UIPinchGestureRecognizer *) gesture;
@end
