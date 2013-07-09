//
//  MDFlickrActivityIndicatorView.h
//  MDFlickrActivityIndicatorView
//
//  Created by Jānis Kiršteins on 09.07.13.
//  Copyright (c) 2013. g. Jānis Kiršteins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDFlickrActivityIndicatorView : UIView

@property (nonatomic,readonly) BOOL isAnimating;

- (void)startAnimating;
- (void)stopAnimating;

@end
