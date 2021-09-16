//
//  VisualizerView.m
//  Recamán Visualizer
//
//  Created by Richard Homan on 9/14/21.
//

#import "VisualizerView.h"

#define DEFAULT_DEGREE 30

int max(int, int);

@interface VisualizerView ()

@property (strong, nonatomic) NSMutableArray *sequence;
@property (strong, nonatomic) CAShapeLayer *pathLayer;

@end

@implementation VisualizerView
@synthesize sequence;
@synthesize pathLayer;
@synthesize degree;
@synthesize rotation, zoom, translation;
@synthesize backgroundColor, lineColor;

- (id)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self)
	{
		rotation = 0.0;
		zoom = 3.0;
		translation = NSMakePoint(0, 0);
		[self setBackgroundColor:[NSColor whiteColor]];
		[self setSequence:[NSMutableArray arrayWithObject:@0]];
		[self setPathLayer:[CAShapeLayer new]];
		
		[self setDegree:DEFAULT_DEGREE];
	}
	return self;
}

- (id)initWithFrame:(NSRect)frameRect
{
	self = [super initWithFrame:frameRect];
	if (self)
	{
		rotation = 0.0;
		zoom = 3.0;
		translation = NSMakePoint(0, 0);
		[self setBackgroundColor:[NSColor whiteColor]];
		[self setSequence:[NSMutableArray arrayWithObject:@0]];
		[self setPathLayer:[CAShapeLayer new]];
		
		[self setDegree:DEFAULT_DEGREE];
	}
	return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
	[self.layer setBackgroundColor:self.backgroundColor.CGColor];
	
	[self.pathLayer setTransform:CATransform3DMakeScale(self.zoom, self.zoom, 1.0)];
	[self.pathLayer setNeedsDisplayInRect:dirtyRect];
	
	[self.pathLayer setLineWidth:0.5];
	[self.pathLayer setStrokeColor:[NSColor blackColor].CGColor];
	[self.pathLayer setFillColor:NULL];
	[self.layer addSublayer:self.pathLayer];
}

- (void)setDegree:(NSInteger)deg
{
	// recalculate sequence
	NSAssert(sequence, @"sequence is nil");
	BOOL direction = NO;
	CGMutablePathRef path = CGPathCreateMutable();
	CGAffineTransform rotate = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI/4.0);
	CGPathMoveToPoint(path, NULL, 0.0, 0.0);
		
	for (int i = 1; i < deg; i++)
	{
		int current = [[sequence objectAtIndex:i-1] intValue];
		int next = max(current-i, 0);
		NSNumber *nsnext = [NSNumber numberWithInt:next];
		
		double radius;
		
		if ([sequence containsObject:nsnext]) // go forwards
		{
			next = current+i;
			if (i >= degree)
			{
				nsnext = [NSNumber numberWithInt:next];
				[sequence addObject:nsnext];
			}
		}
		else if (i >= degree) // does not contain n, go back
			[sequence addObject:nsnext];
		
		radius = (next-current)/2.0;
		
		CGPathAddArc(path, &rotate, current+radius, 0, radius, M_PI, 0.0, next < current ? direction : !direction);
		
		direction = !direction;
	}
	
	[self.pathLayer setPath:path];
	
	degree = deg;
}

- (void)zoom:(CGFloat)multiplier
{
	zoom *= multiplier;
	[self setNeedsDisplay:YES];
}

- (void)setZoom:(CGFloat)newZoom
{
	zoom = newZoom;
	[self setNeedsDisplay:YES];
}

- (void)setTranslation:(CGPoint)newTranslation
{
	NSRect oldBounds = self.bounds;
	NSRect newBounds = NSMakeRect(oldBounds.origin.x+newTranslation.x,
								  oldBounds.origin.y+newTranslation.y,
								  oldBounds.size.width,
								  oldBounds.size.height);
	[self setBounds:newBounds];
	translation = newTranslation;
}

- (void)setBackgroundColor:(NSColor *)bgColor
{
	[self.layer setBackgroundColor:bgColor.CGColor];
	[self setNeedsDisplay:YES];
}

@end

inline int max(int a, int b)
{
	return a > b ? a : b;
}
