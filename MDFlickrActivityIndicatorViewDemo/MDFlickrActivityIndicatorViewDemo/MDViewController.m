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

- (IBAction)toggleHideWhenStopped:(id)sender {
    UIButton *btnSender = (UIButton*)sender;
    
    if ([[btnSender titleForState:UIControlStateNormal] isEqualToString:@"Hide when stopped"])
    {
        self.spinner.hidesWhenStopped = YES;
        [btnSender setTitle:@"Show when stopped" forState:UIControlStateNormal];
    }
    else
    {
        self.spinner.hidesWhenStopped = NO;
        [btnSender setTitle:@"Hide when stopped" forState:UIControlStateNormal];
    }
}

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
