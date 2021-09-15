//
//  WindowController.h
//  Recamán Visualizer
//
//  Created by Richard Homan on 9/15/21.
//

#import <Cocoa/Cocoa.h>
#import "VisualizerView.h"

@interface WindowController : NSWindowController
{
	BOOL mouseDownInView;
}

- (IBAction)zoomIn:(id)sender;
- (IBAction)zoomOut:(id)sender;
- (IBAction)zoomActual:(id)sender;

@end
