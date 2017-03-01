//
//  ViewController.m
//  Attributor
//
//  Created by Leonardo Clavijo on 2/24/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//

#import "ViewController.h"
#import "StatsController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *header;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation ViewController

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // We use segue instantiate the controller and bind vars to controller
    if([segue.identifier isEqualToString:@"text_stats"]){
        if([segue.destinationViewController isKindOfClass: [StatsController class]]){
            StatsController * sController = (StatsController *)segue.destinationViewController;
            sController.textToAnalyze = self.body.textStorage;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableAttributedString * title =
    [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
    [title setAttributes:@{NSStrokeWidthAttributeName: @3, NSStrokeColorAttributeName: self.outlineButton.tintColor} range:NSMakeRange(0, title.length)];
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // on create set preferred font 
    [self preferredFont];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredFontChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
    
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (IBAction)onTapChangeColor:(UIButton *)sender
{
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:[self.body selectedRange]];
}

- (IBAction)onTapOutline
{
    [self.body.textStorage setAttributes:@{NSStrokeWidthAttributeName: @-3, NSStrokeColorAttributeName: [UIColor blackColor]} range:self.body.selectedRange];
}

- (IBAction)onTapUnoutline {
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.body.selectedRange];
}


- (void) preferredFontChanged: (NSNotification *)notification
{
    [self preferredFont];
}

- (void) preferredFont
{
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.header.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    
}

@end
