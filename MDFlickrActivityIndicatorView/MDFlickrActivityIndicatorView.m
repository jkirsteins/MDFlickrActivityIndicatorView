//
//  MDFlickrActivityIndicatorView.m
//  MDFlickrActivityIndicatorView
//
//  Created by Jānis Kiršteins on 09.07.13.
//  Copyright (c) 2013. g. Jānis Kiršteins. All rights reserved.
//

#import "MDFlickrActivityIndicatorView.h"
#import "UIColor+MDFlickrActivityIndicatorView.h"

@interface MDFlickrActivityIndicatorView()
@property(nonatomic,assign) BOOL isAnimating;

@property (nonatomic, strong) CALayer *backgroundLayer;
@property (nonatomic, strong) CAShapeLayer *pinkDotLayer;
@property (nonatomic, strong) CAShapeLayer *blueDotLayer;

@property (nonatomic, strong) CABasicAnimation *moveLeftRight;
@property (nonatomic, strong) CABasicAnimation *moveRightLeft;

@property (nonatomic, weak) CAShapeLayer *dotOnTop;

@property (nonatomic, strong) NSTimer *timer;

-(void)swapDots;

@end

@implementation MDFlickrActivityIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isAnimating = false;
        self.clipsToBounds = YES;
        
        
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    BOOL shouldAdd = self.pinkDotLayer == nil;
    
    if (self.pinkDotLayer == nil)
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        
        shapeLayer.fillColor = [[UIColor MD_flickrPinkColor] CGColor];
        shapeLayer.lineWidth = 1.5f;
        shapeLayer.lineJoin = kCALineJoinRound;
        
        self.pinkDotLayer = shapeLayer;
    }
    
    if (self.blueDotLayer == nil)
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        
        shapeLayer.fillColor = [[UIColor MD_flickrBlueColor] CGColor];
        self.blueDotLayer = shapeLayer;
    }
    
    CGRect dotBounds = CGRectMake(0, 0, self.frame.size.height/2.0f, self.frame.size.height/2.0f);
    self.pinkDotLayer.path = [[UIBezierPath bezierPathWithOvalInRect:dotBounds] CGPath];
    self.blueDotLayer.path = [[UIBezierPath bezierPathWithOvalInRect:dotBounds] CGPath];

    self.pinkDotLayer.bounds = dotBounds;
    self.blueDotLayer.bounds = dotBounds;
    CGRect dotFrame = CGRectMake(
        frame.size.width/2.0f - dotBounds.size.width/2.0f,
        frame.size.height/2.0f - dotBounds.size.height/2.0f,
        dotBounds.size.width,
        dotBounds.size.height);
    
    CGRect pinkDotFrame = dotFrame;
    CGRect blueDotFrame = dotFrame;
    
    pinkDotFrame.origin.x += (dotBounds.size.width/2.0 + dotBounds.size.width/10.f);
    self.pinkDotLayer.frame = pinkDotFrame;
    
    blueDotFrame.origin.x -= (dotBounds.size.width/2.0 + dotBounds.size.width/10.0f);
    self.blueDotLayer.frame = blueDotFrame;
    
    
    
    if (self.backgroundLayer == nil)
    {
        CALayer *lay = [[CALayer alloc] init];
        lay.backgroundColor = [[UIColor MD_flickrGrayColor] CGColor];
        lay.cornerRadius = frame.size.height/4;
        self.backgroundLayer = lay;
    }
    
    self.backgroundLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.backgroundLayer.bounds = self.backgroundLayer.frame;
    
    
    if (shouldAdd)
    {
        [self.layer addSublayer:self.backgroundLayer];
        [self.layer addSublayer:self.pinkDotLayer];
        [self.layer addSublayer:self.blueDotLayer];
        
        self.dotOnTop = self.blueDotLayer;
    }
    
//    self.layer.backgroundColor = [[UIColor orangeColor] CGColor];
//    self.layer.cornerRadius = 20.0;
//    self.layer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}


- (id)init
{
    return [self initWithFrame:CGRectZero];
}


- (void)startAnimating;
{
    self.isAnimating = YES;
    
    if (self.moveLeftRight == nil)
    {
        self.moveLeftRight = [CABasicAnimation animationWithKeyPath:@"position"];
        //        [self.movePinkAnimation setDelegate:self];
        [self.moveLeftRight setDuration:.6f];
        [self.moveLeftRight setRepeatCount:HUGE_VALF];
        self.moveLeftRight.autoreverses = YES;
    }
    
    self.moveLeftRight.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    
    [self.moveLeftRight setFromValue:[NSValue valueWithCGPoint:self.pinkDotLayer.position]];
    [self.moveLeftRight setToValue:[NSValue valueWithCGPoint:self.blueDotLayer.position]];
    self.moveLeftRight.removedOnCompletion = NO;
    
    // copy and reverse
    
    self.moveRightLeft = [self.moveLeftRight copy];
    [self.moveRightLeft setFromValue:[NSValue valueWithCGPoint:self.blueDotLayer.position]];
    [self.moveRightLeft setToValue:[NSValue valueWithCGPoint:self.pinkDotLayer.position]];
    
    // set delegates

//    self.moveLeftRight.delegate = self;
    self.moveRightLeft.delegate = self;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.moveLeftRight.duration target:self selector:@selector(swapDots) userInfo:NULL repeats:YES];

    
    [self.pinkDotLayer addAnimation:self.moveLeftRight forKey:@"position"];
    [self.blueDotLayer addAnimation:self.moveRightLeft forKey:@"position"];
    
    //    [self.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}

-(void)swapDots
{
    if (self.dotOnTop == self.pinkDotLayer)
        self.dotOnTop = self.blueDotLayer;
    else
        self.dotOnTop = self.pinkDotLayer;
    
    [self.layer addSublayer:self.dotOnTop];
}

//- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
//{
//    if (flag)
//    {
//        [CATransaction begin];
//        [CATransaction setValue:(id)kCFBooleanTrue
//                         forKey:kCATransactionDisableActions];
//
//        CGPoint oldBluePos = self.blueDotLayer.position;
//        [self.blueDotLayer setPosition:self.pinkDotLayer.position];
//        [self.pinkDotLayer setPosition:oldBluePos];
//        
//        
//        // ended rightToLeft
//        CALayer *prevTopLayer = self.dotOnTop;
//        
//        if (self.dotOnTop == self.pinkDotLayer)
//            self.dotOnTop = self.blueDotLayer;
//        else
//            self.dotOnTop = self.pinkDotLayer;
//        
//        [self.layer addSublayer:self.dotOnTop];
//        [prevTopLayer addAnimation:self.moveLeftRight forKey:@"position"];
//        [self.dotOnTop addAnimation:self.moveRightLeft forKey:@"position"];
//        
//        
//        [CATransaction commit];
//
//    }
//}

- (void)stopAnimating
{
    self.isAnimating = NO;
    [self.timer invalidate];
    self.timer = nil;
    [self.pinkDotLayer removeAllAnimations];
    [self.blueDotLayer removeAllAnimations];
}

- (UIBezierPath *)samplePath
{
    return [UIBezierPath bezierPathWithRect:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
}

@end
