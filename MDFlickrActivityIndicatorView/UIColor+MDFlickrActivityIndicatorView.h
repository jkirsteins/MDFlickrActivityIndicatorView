//
//  UIColor+MDFlickrActivityIndicatorView.h
//  MDFlickrActivityIndicatorView
//
//  Created by Jānis Kiršteins on 09.07.13.
//  Copyright (c) 2013. g. Jānis Kiršteins. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
   @category Flickr (UIColor)
   @abstract
     Adds static Flickr color accessors to UIColor.
 */
@interface UIColor (Flickr)

/*!
   @property MD_flickrBlueColor
   @brief Flickr blue color
 */
+(UIColor*)MD_flickrBlueColor;

/*!
 @property MD_flickrGrayColor
 @brief Gray color for background behind the pink and bue dots.
 */
+(UIColor*)MD_flickrGrayColor;

/*!
 @property MD_flickrPinkColor
 @brief Flickr pink color
 */
+(UIColor*)MD_flickrPinkColor;

@end
