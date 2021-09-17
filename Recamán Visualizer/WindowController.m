//
//  WindowController.m
//  Recamán Visualizer
//
//  Created by Richard Homan on 9/15/21.
//

#import "WindowController.h"

@interface WindowController ()

@end

@implementation WindowController
@synthesize degreeLength;
@synthesize lineWidth;
@synthesize lineColor, backgroundColor;

- (void)awakeFromNib
{
	NSUserDefaults *sharedUserDefaults = [NSUserDefaults standardUserDefaults];
	[self bind:@"degreeLength" toObject:sharedUserDefaults withKeyPath:@"length" options:nil];
	[self bind:@"lineWidth" toObject:sharedUserDefaults withKeyPath:@"lineWidth" options:nil];
	[self setBackgroundColor:[NSColor whiteColor]];
	[self setLineColor:[NSColor blackColor]];
}

- (IBAction)zoomIn:(id)sender
{
	[(VisualizerView *)self.window.contentView zoom:2.0];
}

- (IBAction)zoomOut:(id)sender
{
	[(VisualizerView *)self.window.contentView zoom:0.5];
}

- (IBAction)zoomActual:(id)sender
{
	[(VisualizerView *)self.window.contentView setZoom:3.0];
}

- (void)setDegreeLength:(NSNumber *)dl
{
	degreeLength = dl;
	[(VisualizerView *)self.window.contentView setDegree:degreeLength.intValue];
}

- (void)setLineWidth:(NSNumber *)lw
{
	lineWidth = lw;
	[(VisualizerView *)self.window.contentView setLineWidth:lineWidth.doubleValue];
}

- (void)setLineColor:(NSColor *)lc
{
	lineColor = lc;
	[(VisualizerView *)self.window.contentView setLineColor:lineColor.CGColor];
}

- (void)setBackgroundColor:(NSColor *)bc
{
	backgroundColor = bc;
	[(VisualizerView *)self.window.contentView setBackgroundColor:backgroundColor.CGColor];
}

@end
