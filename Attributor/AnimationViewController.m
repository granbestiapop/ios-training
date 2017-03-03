//
//  AnimationViewController.m
//  Attributor
//
//  Created by Leonardo Clavijo on 3/3/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()
@property (strong, nonatomic) IBOutlet UIView *animationView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UICollisionBehavior *collision;


@end

@implementation AnimationViewController

static const CGSize DROP_SIZE = {40,40};

#pragma mark - Initializers

- (UIDynamicAnimator *) animator
{
    if(!_animator){
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView: self.animationView];
    }
    return _animator;
}

- (UIGravityBehavior*) gravity
{
    if(!_gravity){
        _gravity = [[UIGravityBehavior alloc] init];
        _gravity.magnitude = 0.9;
        [self.animator addBehavior:_gravity];
    }
    return _gravity;
}

- (UICollisionBehavior*) collision
{
    if(!_collision){
        _collision = [[UICollisionBehavior alloc] init];
        _collision.translatesReferenceBoundsIntoBoundary = YES;
        [self.animator addBehavior:_collision];
    }
    return _collision;
}


#pragma mark - Gestures

- (IBAction)tap:(UITapGestureRecognizer *)sender
{
    [self drop];
}

- (void)drop
{
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = DROP_SIZE;
    int x = (arc4random()% (int) self.animationView.bounds.size.width) / DROP_SIZE.width;
    frame.origin.x = x * DROP_SIZE.width;
    
    UIView * view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor redColor];
    [self.animationView addSubview:view];
    
    [self.gravity addItem:view];
    [self.collision addItem:view];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
