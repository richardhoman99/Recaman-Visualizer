//
//  VisualizerView.m
//  Recamán Visualizer
//
//  Created by Richard Homan on 9/14/21.
//

#import "VisualizerView.h"

@interface VisualizerView ()

@property (strong, nonatomic) NSMutableArray *sequence;

@end

@implementation VisualizerView
@synthesize sequence;
@synthesize nthDegree;

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];

	NSAssert(nthDegree, @"nthDegree not defined");
	[self setNthDegree:6];
}

- (void)setNthDegree:(NSInteger )newDegree
{
	nthDegree = newDegree;
	// recalculate sequence

	sequence = [[NSMutableArray alloc] initWithObjects:@0, @1, @3, nil];
	for (int i = 3; i < newDegree; /* increments in block to reduce instruction */)
	{
		int current = [[sequence objectAtIndex:i] intValue];
		NSNumber *new = [NSNumber numberWithInt:current-i];
		
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
