//
//  WindowController.h
//  Recamán Visualizer
//
//  Created by Richard Homan on 9/15/21.
//

#import <Cocoa/Cocoa.h>
#import "VisualizerView.h"

@interface WindowController : NSWindowController <NSWindowDelegate>
{
	BOOL mouseDownInView;
}

@property (strong, nonatomic) NSNumber *degreeLength;
@property (strong, nonatomic) NSNumber *lineWidth;
@property (strong, nonatomic) NSColor *lineColor;
@property (strong, nonatomic) NSColor *backgroundColor;

@property (weak, nonatomic) IBOutlet VisualizerView *visulizerView;

@property (weak, nonatomic) IBOutlet NSPanel *inspectorWindow;

- (IBAction)recenterView:(id)sender;
- (IBAction)zoomIn:(id)sender;
- (IBAction)zoomOut:(id)sender;
- (IBAction)zoomNormal:(id)sender;

@end
