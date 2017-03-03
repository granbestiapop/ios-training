//
//  StatsController.m
//  Attributor
//
//  Created by Leonardo Clavijo on 3/1/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//

#import "StatsController.h"
#import "ViewController.h"

@interface StatsController ()
@property (weak, nonatomic) IBOutlet UILabel *coloredLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedLabel;
@property (weak, nonatomic) IBOutlet UIView *gestureView;

@end


@implementation StatsController

- (void) setTextToAnalyze: (NSAttributedString *) textToAnalyze
{
    _textToAnalyze = textToAnalyze;
    if(self.view.window)
        [self updateUI];
}

- (void) updateUI
{
    self.coloredLabel.text = [NSString stringWithFormat:@"%lu colored text", (unsigned long)[[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedLabel.text = [NSString stringWithFormat:@"%lu outlined text", (unsigned long)[[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self updateUI];
}

- (NSAttributedString *) charactersWithAttribute: (NSString *) attribute
{
    NSMutableAttributedString * characters = [[NSMutableAttributedString alloc] init];
    NSInteger index = 0;
    NSInteger range = [self.textToAnalyze length];
    while(index < range){
        NSRange range;
        id value = [self.textToAnalyze attribute:attribute atIndex:index effectiveRange:&range];
        if(value){
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        }else{
            index++;
        }
    }
    
    return characters;
}

-(void) viewDidLoad
{
    [self refreshStats];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self refreshStats];
}

- (void) refreshStats {
    NSLog(@"Did appear view controller");
    NSArray * controllers = [self.tabBarController viewControllers];
    UINavigationController *uiViewController = (UINavigationController *)controllers[0];
    ViewController * viewController = (ViewController *)[uiViewController.childViewControllers firstObject];
    NSTextStorage * text = [viewController.getBody textStorage];
    self.textToAnalyze = text;
}


- (void) setPannableView: (UIView *) view
{

    UIPanGestureRecognizer * gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.gestureView action:@selector(logPan:)];
    
    [self.gestureView addGestureRecognizer: gesture];
}

- (void) logPan{
    
}

@end
