//
//  MDFlickrActivityIndicatorView.h
//  MDFlickrActivityIndicatorView
//
//  Created by Jānis Kiršteins on 09.07.13.
//  Copyright (c) 2013. g. Jānis Kiršteins. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
   @class MDFlickrActivityIndicatorView
   @abstract
     An activity indicator view that mimicks Flickr loading animation, as
     seen in Flickr's iOS app and website. Use it to show that a task is 
     in progress.
 
     You control when an activity indicator animates by calling the 
     startAnimating and stopAnimating methods. To automatically hide the 
     activity indicator when animation stops, set the hidesWhenStopped property 
     to YES.
 */
@interface MDFlickrActivityIndicatorView : UIView

/*!
   @property hidesWhenStopped
   @abstract 
     A Boolean value that controls whether the receiver is hidden when the
     animation is stopped.
   @discussion
     If the value of this property is YES (the default), the receiver sets its
     hidden property (UIView) to YES when receiver is not animating. If the 
     hidesWhenStopped property is NO, the receiver is not hidden when animation 
     stops. 
     You stop an animating progress indicator with the stopAnimating method.
 */
@property (nonatomic, assign) BOOL hidesWhenStopped;

/*!
   @method isAnimating
   @abstract
     Returns whether the receiver is animating.
   @return 
     YES if the receiver is animating, otherwise NO.
 */
- (BOOL)isAnimating;

/*!
   @method startAnimating
   @abstract
     Starts the animation of the progress indicator.
   @discussion
     When the progress indicator is animated, the gear spins to indicate 
     indeterminate progress. The indicator is animated until stopAnimating is 
     called.
 */
- (void)startAnimating;

/*!
   @method stopAnimating
   @abstract
     Stops the animation of the progress indicator.
   @discussion
     Call this method to stop the animation of the progress indicator started 
     with a call to startAnimating. When animating is stopped, the indicator is 
     hidden, unless hidesWhenStopped is NO.
 */
- (void)stopAnimating;

@end
