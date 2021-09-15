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

- (void)mouseDragged:(NSEvent *)event
{
	NSPoint translationPoint = NSMakePoint(-event.deltaX, event.deltaY);
	[(VisualizerView *)self.window.contentView setTranslation:translationPoint];
}

@end
