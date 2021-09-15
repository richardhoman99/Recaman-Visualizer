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
@property (nonatomic) CGFloat zoom;
@property (nonatomic) CGPoint translation;

@end
