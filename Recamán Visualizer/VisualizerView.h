//
//  VisualizerView.h
//  Recamán Visualizer
//
//  Created by Richard Homan on 9/14/21.
//

#import <Cocoa/Cocoa.h>

@interface VisualizerView : NSView

@property (nonatomic) NSInteger degree;

@property (nonatomic) CGFloat rotation;
@property (nonatomic) CGFloat zoom; // setZoom: will change zoom to the absolute value, zoom: will change zoom by given factor
@property (nonatomic) CGPoint translation;

@property (strong, nonatomic) NSColor *backgroundColor;
@property (strong, nonatomic) NSColor *lineColor;

- (void)zoom:(CGFloat)multiplier;

@end
