# MDFlickrActivityIndicatorView

![MDFlickrActivityIndicatorView Screenshot](images/MDFlickrActivityIndicatorView_Preview.png)

Inspired by this [CSS3 version of Flickr Loading Animation](http://codepen.io/beau/pen/aAxDy).

## What is this?

This is a custom UIView descendant that mimicks the Flickr loading animation, as seen on Flickr iOS app and website. It uses CoreAnimation to achieve the animation.

The code assumes that automatic reference counting (ARC) is enabled.

The included demo project was created in Xcode5 (Developer Preview), targetting iOS7 beta.

## How to use it?

Download the source and drag the "MDFlickrActivityIndicator" folder into your Xcode project.

Then, either instantiate the MDFlickrActivityIndicator via code, or add a "UIView" object to your Storyboard, and set its class to MDFlickrActivityIndicator.

Then, use as you would a normal UIActivityIndicatorView. Call 
    
    [view startAnimating]
    
to begin animation, and

    [view stopAnimating]
    
to stop animation.

## License

Licensed under the BSD 2-clause license. 

&copy; 2013 Jānis Kiršteins <janis@janiskirsteins.org>
    

