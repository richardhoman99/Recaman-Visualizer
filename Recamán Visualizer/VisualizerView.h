//
//  VisualizerView.h
//  Recamán Visualizer
//
//  Created by Richard Homan on 9/14/21.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@interface VisualizerView : NSView

@property (nonatomic) NSInteger degree;

@property (nonatomic) CGFloat rotation;
@property (nonatomic) CGFloat zoom; // setZoom: will change zoom to the absolute value, zoom: will change zoom by given factor

@property (nonatomic) CGColorRef backgroundColor;
@property (nonatomic) CGColorRef lineColor;
@property (nonatomic) CGFloat lineWidth;

- (void)zoom:(CGFloat)multiplier;
- (void)setTranslation:(CGPoint)delta;

@end
