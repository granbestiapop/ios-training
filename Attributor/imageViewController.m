//
//  imageViewController.m
//  Attributor
//
//  Created by Leonardo Clavijo on 3/6/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//

#import "imageViewController.h"
#import "imaginariumViewController.h"

@interface imageViewController ()

@end

@implementation imageViewController



// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass: [imaginariumViewController class]]){
        // instrospection
        imaginariumViewController *ivc = (imaginariumViewController *) segue.destinationViewController;
        ivc.imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/%@.jpg", segue.identifier]];
        ivc.title = segue.identifier;
        
    }
    
}

@end
