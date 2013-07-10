//
//  MDFlickrActivityIndicatorView.m
//  MDFlickrActivityIndicatorView
//
//  Created by Jānis Kiršteins on 09.07.13.
//  Copyright (c) 2013. g. Jānis Kiršteins. All rights reserved.
//

#import "MDFlickrActivityIndicatorView.h"
#import "UIColor+MDFlickrActivityIndicatorView.h"

#pragma mark -
#pragma mark Internal category - MDFlickrActivityIndicatorView()

@interface MDFlickrActivityIndicatorView()
{
    BOOL _isAnimating;
}

/*!
   @property backgroundLayer
   @abstract 
     Layer responsible for drawing the background rounded rectangle.
 */
@property (nonatomic, strong) CALayer *backgroundLayer;

/*!
   @property pinkDotLayer
   @abstract
     Layer responsible for drawing the pink dot.
 */
@property (nonatomic, strong) CAShapeLayer *pinkDotLayer;

/*!
   @property blueDotLayer
   @abstract
     Layer responsible for drawing the blue dot.
 */
@property (nonatomic, strong) CAShapeLayer *blueDotLayer;

/*!
   @property dotOnTop
   @abstract
     Weak reference to the top dot layer (either pinkDotLayer or blueDotLayer).
 */
@property (nonatomic, weak) CAShapeLayer *dotOnTop;

/*!
  @property moveLeftRight
  @abstract
    Animation for moving a dot from left to right.
 */
@property (nonatomic, strong) CABasicAnimation *moveLeftRight;

/*!
   @property moveRightLeft
   @abstract
     Animation for moving a dot from right to left.
 */
@property (nonatomic, strong) CABasicAnimation *moveRightLeft;

/*!
   @property timer
   @abstract
     Timer that is responsible for changing the Z-index of the pink/blue 
     dot layers.
 */
@property (nonatomic, strong) NSTimer *timer;

/*!
   @method swapDots
   @abstract
     Swap the Z-index of pink/blue dot layers. Bring the background dot to
     front, and vice versa.
 */
- (void)swapDots;

- (void)createLayers;
- (void)createAnimations;

@end

#pragma mark -
#pragma mark Implementation of MDFlickrActivityIndicatorView

@implementation MDFlickrActivityIndicatorView

@synthesize hidesWhenStopped = _hidesWhenStopped;

#pragma mark Internal methods

-(void)swapDots
{
    if (self.dotOnTop == self.pinkDotLayer)
        self.dotOnTop = self.blueDotLayer;
    else
        self.dotOnTop = self.pinkDotLayer;
    
    [self.layer addSublayer:self.dotOnTop];
}

- (void)setUp
{
    self->_isAnimating = false;
    self.hidden = self.hidesWhenStopped;
    self.clipsToBounds = YES;
}

- (void)createLayers
{
    self.pinkDotLayer = [CAShapeLayer layer];
    self.pinkDotLayer.fillColor = [[UIColor MD_flickrPinkColor] CGColor];
    self.blueDotLayer = [CAShapeLayer layer];
    self.blueDotLayer.fillColor = [[UIColor MD_flickrBlueColor] CGColor];
    
    self.backgroundLayer = [CALayer layer];
    self.backgroundLayer.backgroundColor = [[UIColor MD_flickrGrayColor] CGColor];
    
    self.dotOnTop = self.blueDotLayer;
}

- (void)createAnimations
{
    self.moveLeftRight = [CABasicAnimation animationWithKeyPath:@"position"];
    self.moveLeftRight.duration = .6f;
    self.moveLeftRight.repeatCount = HUGE_VALF;
    self.moveLeftRight.autoreverses = YES;
    self.moveLeftRight.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    self.moveLeftRight.removedOnCompletion = NO;
    
    self.moveRightLeft = [self.moveLeftRight copy];
    
    [self.moveLeftRight setFromValue:[NSValue valueWithCGPoint:self.pinkDotLayer.position]];
    [self.moveLeftRight setToValue:[NSValue valueWithCGPoint:self.blueDotLayer.position]];
    
    [self.moveRightLeft setFromValue:[NSValue valueWithCGPoint:self.blueDotLayer.position]];
    [self.moveRightLeft setToValue:[NSValue valueWithCGPoint:self.pinkDotLayer.position]];
}

#pragma mark Public methods

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setUp];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void) setHidesWhenStopped:(BOOL)hidesWhenStopped
{
    _hidesWhenStopped = hidesWhenStopped;
    self.hidden = self.isAnimating || hidesWhenStopped;
}

- (BOOL)isAnimating
{
    return self->_isAnimating;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self createLayers];
    
    // Set background layer frame and bounds
    self.backgroundLayer.frame = CGRectMake(0, 0,
                                            frame.size.width,
                                            frame.size.height);
    self.backgroundLayer.bounds = self.backgroundLayer.frame;
    self.backgroundLayer.cornerRadius = frame.size.height/4;
    
    // Set dot layer paths and bounds
    CGRect dotBounds = CGRectMake(0, 0,
                                  self.frame.size.height/2.0f,
                                  self.frame.size.height/2.0f);
    CGPathRef dotPath = [[UIBezierPath bezierPathWithOvalInRect:dotBounds] CGPath];
    self.pinkDotLayer.path = dotPath;
    self.blueDotLayer.path = dotPath;
    self.pinkDotLayer.bounds = dotBounds;
    self.blueDotLayer.bounds = dotBounds;
    
    // Create dot layer frames at the center of this view
    CGRect pinkDotFrame = CGRectMake(
        frame.size.width/2.0f - dotBounds.size.width/2.0f,
        frame.size.height/2.0f - dotBounds.size.height/2.0f,
        dotBounds.size.width,
        dotBounds.size.height);
    CGRect blueDotFrame = pinkDotFrame;
    
    // Shift pink to the left and blue to the right
    pinkDotFrame.origin.x += (dotBounds.size.width/2.0 + dotBounds.size.width/10.f);
    blueDotFrame.origin.x -= (dotBounds.size.width/2.0 + dotBounds.size.width/10.0f);
    
    self.pinkDotLayer.frame = pinkDotFrame;
    self.blueDotLayer.frame = blueDotFrame;
    
    [self createAnimations];
    
    [self.layer addSublayer:self.backgroundLayer];
    [self.layer addSublayer:self.pinkDotLayer];
    [self.layer addSublayer:self.blueDotLayer];
}

- (void)startAnimating;
{
    self->_isAnimating = YES;
    self.hidden = NO;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.moveLeftRight.duration
                                                  target:self
                                                selector:@selector(swapDots)
                                                userInfo:NULL
                                                 repeats:YES];
    
    [self.pinkDotLayer addAnimation:self.moveLeftRight forKey:@"position"];
    [self.blueDotLayer addAnimation:self.moveRightLeft forKey:@"position"];
}

- (void)stopAnimating
{
    self->_isAnimating = NO;
    self.hidden = self.hidesWhenStopped;
    
    [self.timer invalidate];
    self.timer = nil;
    
    [self.pinkDotLayer removeAllAnimations];
    [self.blueDotLayer removeAllAnimations];
}

@end
