//
//  UIColor+MDFlickrActivityIndicatorView.m
//  MDFlickrActivityIndicatorView
//
//  Created by Jānis Kiršteins on 09.07.13.
//  Copyright (c) 2013. g. Jānis Kiršteins. All rights reserved.
//

#import "UIColor+MDFlickrActivityIndicatorView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UIColor (Flickr)

+ (UIColor*)MD_flickrBlueColor
{
    return UIColorFromRGB(0x1065CB);
}

+ (UIColor*)MD_flickrPinkColor
{
    return UIColorFromRGB(0xFB007C);
}

+ (UIColor*)MD_flickrGrayColor
{
    return UIColorFromRGB(0x2E302D);
}

@end
