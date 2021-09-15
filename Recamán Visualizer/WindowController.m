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

- (void)windowDidLoad
{
    [super windowDidLoad];
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

- (void)mouseDown:(NSEvent *)event
{
	if ([[(VisualizerView *)self.window.contentView hitTest:event.locationInWindow] isEqualTo:(VisualizerView *)self.window.contentView])
		mouseDownInView = YES;
}

- (void)mouseUp:(NSEvent *)event
{
	mouseDownInView = NO;
}

- (void)mouseDragged:(NSEvent *)event
{
	if (mouseDownInView)
	{
		NSPoint translationPoint = NSMakePoint(-event.deltaX, event.deltaY);
		[(VisualizerView *)self.window.contentView setTranslation:translationPoint];
	}
}

@end
