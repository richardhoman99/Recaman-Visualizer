//
//  WindowController.m
//  Recamán Visualizer
//
//  Created by Richard Homan on 9/15/21.
//

#import "WindowController.h"
#import "AppDelegate.h"

#define ZOOM_IN 2.0
#define ZOOM_OUT 0.5

@interface WindowController ()

@end

@implementation WindowController
@synthesize degreeLength;
@synthesize lineWidth;
@synthesize lineColor, backgroundColor;
@synthesize visulizerView;
@synthesize inspectorWindow;

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
	[self.visulizerView zoom:ZOOM_IN];
}

- (IBAction)zoomOut:(id)sender
{
	[self.visulizerView zoom:ZOOM_OUT];
}

- (IBAction)zoomNormal:(id)sender
{
	[self.visulizerView setZoom:NORMAL_ZOOM];
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

- (IBAction)recenterView:(id)sender
{
	[self.visulizerView setTranslation:CGPointMake(0.0, 0.0)];
}

- (void)windowWillClose:(NSNotification *)notification
{
	if ([notification.object isEqualTo:self.inspectorWindow])
	{
		[(AppDelegate *)[[NSApplication sharedApplication] delegate] setInspectorShown:NO];
	}
}

@end
