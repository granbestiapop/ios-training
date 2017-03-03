//
//  PlayingCardView.m
//  Attributor
//
//  Created by Leonardo Clavijo on 3/2/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//

#import "PlayingCardView.h"


@implementation PlayingCardView

#pragma mark - Properties

#define CORNER_FONT 180.0
#define CORNER_RADIUS 12.0
#define DEFAULT_SCALE_FACTOR 0.90


@synthesize faceCardScaleFactor = _faceCardScaleFactor;
@synthesize faceUp = _faceUp;

-(CGFloat) faceCardScaleFactor
{
    if(!_faceCardScaleFactor) _faceCardScaleFactor = DEFAULT_SCALE_FACTOR;
    return _faceCardScaleFactor;
}

-(void) setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
{
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

-(CGFloat) cornerScaleFactor
{
    return self.bounds.size.height / CORNER_FONT;
}
-(CGFloat) cornerRadius
{
    return CORNER_RADIUS * [self cornerScaleFactor];
}

-(CGFloat) cornerOffset
{
    return [self cornerRadius] / 3.0;
}


#pragma mark - Initialization

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIBezierPath * roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius: [self cornerRadius]];
    
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    //draw image
    if(self.faceUp){
        UIImage * faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suite]];
        
        if (faceImage){
            CGRect imageRect = CGRectInset(self.bounds, self.bounds.size.width * (1.0-self.faceCardScaleFactor), self.bounds.size.height * (1.0-self.faceCardScaleFactor));
            [faceImage drawInRect:imageRect];
        } else {
            [self drawPips];
        }
        [self drawCorners];
    }else{
        [[UIImage imageNamed:@"cardBack"] drawInRect:self.bounds];
    }

}

-(void) drawPips
{
    
}

-(NSString *) rankAsString{
    return @[@"1", @"2"][self.rank];
}

-(void) drawCorners
{
    // Set card
    NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.alignment = NSTextAlignmentCenter;
    UIFont * cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suite] attributes:@{NSFontAttributeName: cornerFont, NSParagraphStyleAttributeName: paragraph}];
    CGRect textBounds;
    textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
    textBounds.size = [cornerText size];
    [cornerText drawInRect:textBounds];
    
    //rotate
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    [cornerText drawInRect:textBounds];
    
}

-(void) setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void) awakeFromNib
{
    [self setup];
}

+(void) animation{
    [self transitionWithView:self duration:3.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:<#^(void)animations#> completion:<#^(BOOL finished)completion#>]
}

-(void) setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

-(BOOL) faceUp
{
    if(!_faceUp) _faceUp = NO;
    return _faceUp;
}

- (void)pinch: (UIPinchGestureRecognizer *) gesture
{
    if(gesture.state == UIGestureRecognizerStateChanged || gesture.state == UIGestureRecognizerStateEnded){
    
        self.faceCardScaleFactor *= gesture.scale;
        gesture.scale = 1.0;
    }
}

@end
