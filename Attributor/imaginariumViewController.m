//
//  imaginariumViewController.m
//  Attributor
//
//  Created by Leonardo Clavijo on 3/6/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//

#import "imaginariumViewController.h"

@interface imaginariumViewController () <UIScrollViewDelegate>
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIImage * image;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end


@implementation imaginariumViewController

// this ocurrs after setImage
- (void) setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    _scrollView.minimumZoomScale = 0.2;
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.delegate = self;
    
    self.scrollView.contentSize= self.image ? self.image.size: CGSizeZero;
}

- (void) setImageUrl: (NSURL*) url
{
    _imageUrl = url;
    // this block main queue
    //self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageUrl]];
    [self startDownloading];

}

- (void) setImage: (UIImage *)image{
    self.imageView.image = image;
    [self.imageView sizeToFit];
    // sets image
    self.scrollView.contentSize= self.image ? self.image.size: CGSizeZero;
    [self.activityIndicator stopAnimating];

}

- (UIImage*) image
{
    return self.imageView.image;
}


- (UIImageView *)imageView
{
    if(!_imageView){
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
}

//delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}


- (void) startDownloading
{
    self.image=nil;
    [self.activityIndicator startAnimating];

    if(self.imageUrl){
        NSURLRequest * request = [NSURLRequest requestWithURL:self.imageUrl];
        NSURLSessionConfiguration * config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession * session = [NSURLSession sessionWithConfiguration:config];
        NSURLSessionDownloadTask * task  = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable localfile, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if(!error){
                if([request.URL isEqual:self.imageUrl]){
                    UIImage * downloadImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.image = downloadImage;
                        
                    });
                }
            }
        }];
        [task resume];
        
    }
}

@end
