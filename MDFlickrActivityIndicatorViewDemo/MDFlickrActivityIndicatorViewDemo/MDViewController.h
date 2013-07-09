//
//  MDViewController.h
//  tet3
//
//  Created by Jānis Kiršteins on 09.07.13.
//  Copyright (c) 2013. g. Jānis Kiršteins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDFlickrActivityIndicatorView.h"

@interface MDViewController : UIViewController

@property (weak, nonatomic) IBOutlet MDFlickrActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end
