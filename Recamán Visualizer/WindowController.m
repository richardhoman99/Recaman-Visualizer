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
@synthesize visulizerView;

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
	[self.visulizerView zoom:2.0];
}

- (IBAction)zoomOut:(id)sender
{
	[self.visulizerView zoom:0.5];
}

- (IBAction)zoomActual:(id)sender
{
	[self.visulizerView setZoom:3.0];
}

- (void)setDegreeLength:(NSNumber *)dl
{
	degreeLength = dl;
	[self.visulizerView setDegree:degreeLength.intValue];
}

- (void)setLineWidth:(NSNumber *)lw
{
	lineWidth = lw;
	[self.visulizerView setLineWidth:lineWidth.doubleValue];
}

- (void)setLineColor:(NSColor *)lc
{
	lineColor = lc;
	[self.visulizerView setLineColor:lineColor.CGColor];
}

- (void)setBackgroundColor:(NSColor *)bc
{
	backgroundColor = bc;
	[self.visulizerView setBackgroundColor:backgroundColor.CGColor];
}

@end
