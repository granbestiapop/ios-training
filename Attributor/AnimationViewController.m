//
//  AnimationViewController.m
//  Attributor
//
//  Created by Leonardo Clavijo on 3/3/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//

#import "AnimationViewController.h"
#import "CustomBehavior.h"

@interface AnimationViewController ()<UIDynamicAnimatorDelegate>
@property (strong, nonatomic) IBOutlet UIView *animationView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attachment;

@property (nonatomic, strong) CustomBehavior *behavior;
@property (nonatomic, strong) UIView *droppingView;

@end

@implementation AnimationViewController

static const CGSize DROP_SIZE = {40,40};




#pragma mark - Initializers

- (UIDynamicAnimator *) animator
{
    if(!_animator){
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView: self.animationView];
        _animator.delegate = self;
        
    }
    return _animator;
}

- (CustomBehavior*) behavior
{
    if(!_behavior){
        _behavior = [[CustomBehavior alloc] init];
        [self.animator addBehavior:_behavior];
    }
    return _behavior;
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
    
    // Add view
    [self.animationView addSubview:view];
    // Add animation
    [self.behavior addItem:view];

    // Have a reference to last object
    self.droppingView = view;
}

- (IBAction)panGesture:(UIPanGestureRecognizer *)sender {
    CGPoint gesturePoint = [sender locationInView:self.view];
    
    if(sender.state == UIGestureRecognizerStateBegan){
        [self attachDroppingToPoint:gesturePoint];
    } else if(sender.state == UIGestureRecognizerStateChanged){
        self.attachment.anchorPoint = gesturePoint;
    } else if(sender.state == UIGestureRecognizerStateEnded){
        [self.animator removeBehavior:self.attachment];
    }
}

- (void) attachDroppingToPoint: (CGPoint)point{
    if(self.droppingView){
        self.attachment = [[UIAttachmentBehavior alloc]initWithItem:self.droppingView attachedToAnchor:point];
        self.droppingView = nil;
        [self.animator addBehavior:self.attachment];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
