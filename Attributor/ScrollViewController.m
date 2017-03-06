//
//  ScrollViewController.m
//  Attributor
//
//  Created by Leonardo Clavijo on 3/3/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(strong, nonatomic) UIImageView *imageView;

@end

@implementation ScrollViewController

- (void) delegateScrollView: (UIScrollView*)sender
{

}

#pragma mark - Hola
- (void)viewDidLoad {
    [super viewDidLoad];

    // set zoom
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale= 0.5;
    self.scrollView.maximumZoomScale= 2.0;
    
    // load image
    UIImage * image = [UIImage imageNamed:@"screen"];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    
    //set scroll range
    [self.scrollView setContentSize:self.imageView.bounds.size];
    [self.scrollView addSubview:self.imageView];

}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
