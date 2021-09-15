//
//  VisualizerView.m
//  Recamán Visualizer
//
//  Created by Richard Homan on 9/14/21.
//

#import "VisualizerView.h"

int max(int, int);
#define CURVE_CONSTANT 0.552284749831; // aids in giving the bezier control points their optimum position to mimic a circle

@interface VisualizerView ()

@property (strong, nonatomic) NSMutableArray *sequence;

@end

@implementation VisualizerView
@synthesize sequence;
@synthesize degree;
@synthesize rotation, zoom, translation;

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];

	[self setDegree:37];
	NSAssert(degree, @"degree not defined");
	
	int direction = -1;
	NSBezierPath *path = [NSBezierPath new];
	[path moveToPoint:NSMakePoint(0, 0)];
	
	for (int i = 1; i < sequence.count; i++)
	{
		int prev, current;
		double radiusX, radiusY, bezierControlX, bezierControlY;
		NSPoint midpoint, endpoint, midcontrol1, midcontrol2, endcontrol1, endcontrol2;
		
		prev = [[sequence objectAtIndex:i-1] intValue];
		current = [[sequence objectAtIndex:i] intValue];
		radiusX = (current-prev)/2.0;
		radiusY = fabs(radiusX)*direction;
		bezierControlX = radiusX*CURVE_CONSTANT;
		bezierControlY = radiusY*CURVE_CONSTANT;
		
		midpoint = NSMakePoint(prev+radiusX, radiusY);
		endpoint = NSMakePoint(current, 0);
		
		midcontrol1 = NSMakePoint(prev, bezierControlY);
		midcontrol2 = NSMakePoint(prev+radiusX-bezierControlX, radiusY);
		endcontrol1 = NSMakePoint(current-radiusX+bezierControlX, radiusY);
		endcontrol2 = NSMakePoint(current, bezierControlY);
		
		[path curveToPoint:midpoint controlPoint1:midcontrol1 controlPoint2:midcontrol2];
		[path curveToPoint:endpoint controlPoint1:endcontrol1 controlPoint2:endcontrol2];
		direction *= -1;
	}
	
	NSAffineTransform *transform = [[NSAffineTransform alloc] init];
	[transform translateXBy:10 yBy:50];
	[transform scaleBy:15.0];
	[transform rotateByDegrees:45];
	path = [transform transformBezierPath:path];
	[path stroke];
}

- (void)setDegree:(NSInteger)deg
{
	degree = deg;
	
	// recalculate sequence
	sequence = [[NSMutableArray alloc] initWithObjects:@0, nil];
	for (int i = 1; i < deg; i++)
	{
		int current = [[sequence objectAtIndex:i-1] intValue];
		NSNumber *new = [NSNumber numberWithInt:max(current-i, 0)];
		
		if ([sequence containsObject:new]) // go forwards
		{
			new = [NSNumber numberWithInt:current+i];
			[sequence addObject:new];
		}
		else // does not contain n, go back
		{
			[sequence addObject:new];
		}
	}
}

@end

int max(int a, int b)
{
	return a > b ? a : b;
}
