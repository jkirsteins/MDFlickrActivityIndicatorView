//
//  MDViewController.m
//  MDFlickrActivityIndicatorViewDemo
//
//  Created by Jānis Kiršteins on 09.07.13.
//  Copyright (c) 2013. g. Jānis Kiršteins. All rights reserved.
//

#import "MDViewController.h"

@interface MDViewController ()

@end

@implementation MDViewController

- (IBAction)animationButtonTapped:(id)sender {
    if([self.spinner isAnimating])
    {
        [self.spinner stopAnimating];
        [self.button setTitle:@"Start animating" forState:UIControlStateNormal];
    }
    else
    {
        [self.spinner startAnimating];
        [self.button setTitle:@"Stop animating" forState:UIControlStateNormal];
    }
}

@end
