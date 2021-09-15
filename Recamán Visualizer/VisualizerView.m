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
	NSLog(@"%@", sequence);
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
