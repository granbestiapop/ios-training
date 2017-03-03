//
//  CardViewController.m
//  Attributor
//
//  Created by Leonardo Clavijo on 3/2/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//

#import "CardViewController.h"
#import "PlayingCardView.h"

@interface CardViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCard;

@end

@implementation CardViewController

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"swipe");
    self.playingCard.faceUp = !self.playingCard.faceUp;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.playingCard.suite = @"♠︎";
    self.playingCard.rank = 1;
    UIPinchGestureRecognizer * gesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self.playingCard action:@selector(pinch:)];
    [self.playingCard addGestureRecognizer:gesture];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
