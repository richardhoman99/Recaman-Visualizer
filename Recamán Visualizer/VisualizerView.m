//
//  VisualizerView.m
//  Recamán Visualizer
//
//  Created by Richard Homan on 9/14/21.
//

#import "VisualizerView.h"

int max(int, int);

@interface VisualizerView ()

@property (strong, nonatomic) NSMutableArray *sequence;

@end

@implementation VisualizerView
@synthesize sequence;
@synthesize nthDegree;

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];

	[self setNthDegree:75];
	NSAssert(nthDegree, @"nthDegree not defined");
	
	int direction = -1;
//	double zoom = 5.0;
	NSBezierPath *path = [NSBezierPath new];
	[path moveToPoint:NSMakePoint(0, 0)];
	
	for (int i = 1; i < sequence.count; i++)
	{
		int prev, current, diff;
		double radius;
		NSPoint endpoint, control1, control2;
		prev = [[sequence objectAtIndex:i-1] intValue];
		current = [[sequence objectAtIndex:i] intValue];
		diff = abs(current-prev);
		radius = diff/2;
		endpoint = NSMakePoint(current, 0);
		control1 = NSMakePoint(prev, radius*direction);
		control2 = NSMakePoint(current, radius*direction);
		direction *= -1;
		
		[path curveToPoint:endpoint controlPoint1:control1 controlPoint2:control2];
	}
	[path closePath];
	[path stroke];
}

- (void)setNthDegree:(NSInteger )newDegree
{
	nthDegree = newDegree;
	
	// recalculate sequence
	sequence = [[NSMutableArray alloc] initWithObjects:@0, nil];
	for (int i = 1; i < newDegree; i++)
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
