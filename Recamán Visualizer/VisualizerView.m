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

- (void)commonInit;

@end

@implementation VisualizerView
@synthesize sequence;
@synthesize pathLayer;
@synthesize degree;
@synthesize rotation, zoom;
@synthesize backgroundColor, lineColor, lineWidth;

- (id)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) [self commonInit];
	return self;
}

- (id)initWithFrame:(NSRect)frameRect
{
	self = [super initWithFrame:frameRect];
	if (self) [self commonInit];
	return self;
}

- (void)commonInit
{
	[self setWantsLayer:YES];
	[self.layer setBounds:self.bounds];
	closeHand = NO;
		
	[self setBackgroundColor:[NSColor whiteColor].CGColor];
	[self setLineColor:[NSColor blackColor].CGColor];
	[self setLineWidth:0.5];
	[self setSequence:[NSMutableArray arrayWithObject:@0]];
		
	[self setPathLayer:[CAShapeLayer new]];
	[self.pathLayer setLineWidth:self.lineWidth];
	[self.pathLayer setStrokeColor:self.lineColor];
	[self.pathLayer setFillColor:NULL];
	
	[self setRotation:0.0];
	[self setZoom:3.0];
		
	[self setDegree:DEFAULT_DEGREE];
}

- (void)resetCursorRects
{
	[super resetCursorRects];
	[self addCursorRect:self.frame cursor:[NSCursor openHandCursor]];
}

- (void)mouseDown:(NSEvent *)event
{
	[[NSCursor closedHandCursor] push];
}

- (void)mouseUp:(NSEvent *)event
{
	[[NSCursor closedHandCursor] pop];
}

- (void)mouseDragged:(NSEvent *)event
{
	NSPoint delta = NSMakePoint(-event.deltaX, event.deltaY);
	[self setTranslation:delta];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
	
	[self.layer addSublayer:self.pathLayer];
}

- (void)setDegree:(NSInteger)deg
{
	// recalculate sequence
	NSAssert(sequence, @"sequence is nil");
	BOOL direction = YES;
	CGMutablePathRef path = CGPathCreateMutable();
	CGAffineTransform rotate = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI/4.0);
	CGPathMoveToPoint(path, NULL, 0.0, 0.0);
		
	for (int i = 1; i < deg; i++)
	{
		int current = [[sequence objectAtIndex:i-1] intValue];
		int next;
		double radius;
		if (i >= [sequence count])
		{
			next = max(current-i, 0);
			NSNumber *nsnext = [NSNumber numberWithInt:next];
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
		} else next = [[sequence objectAtIndex:i] intValue];
		
		radius = (next-current)/2.0;
		
		CGPathAddArc(path, &rotate, current+radius, 0, radius, M_PI, 0.0, next < current ? direction : !direction);
		
		direction = !direction;
	}
	
	[self.pathLayer setPath:path];
	[self.pathLayer setBounds:CGRectMake(0, 0, deg, deg)];
	
	degree = deg;
}

- (void)zoom:(CGFloat)multiplier
{
	zoom *= multiplier;
	[self.pathLayer setTransform:CATransform3DMakeScale(self.zoom, self.zoom, 1.0)];
}

- (void)setZoom:(CGFloat)newZoom
{
	zoom = newZoom;
	[self.pathLayer setTransform:CATransform3DMakeScale(self.zoom, self.zoom, 1.0)];
}

- (void)setTranslation:(CGPoint)delta
{
	[CATransaction begin];
	[CATransaction setDisableActions:YES];
	CGPoint point = CGPointMake(self.pathLayer.position.x-delta.x, self.pathLayer.position.y-delta.y);
	[self.pathLayer setPosition:point];
	[CATransaction commit];
}

- (void)setBackgroundColor:(CGColorRef)bgcolor
{
	backgroundColor = bgcolor;
	[self.layer setBackgroundColor:bgcolor];
	[self setNeedsDisplay:YES];
}

- (void)setLineColor:(CGColorRef)lColor
{
	lineColor = lColor;
	[self.pathLayer setStrokeColor:lineColor];
	[self setNeedsDisplay:YES];
}

- (void)setLineWidth:(CGFloat)lw
{
	lineWidth = lw;
	[self.pathLayer setLineWidth:lineWidth];
}

@end

inline int max(int a, int b)
{
	return a > b ? a : b;
}
