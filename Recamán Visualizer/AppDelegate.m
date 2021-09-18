//
//  AppDelegate.m
//  Recamán Visualizer
//
//  Created by Richard Homan on 9/14/21.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize inspectorMenuItem;
@synthesize windowController;
@synthesize inspectorShown;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[self setWindowController:[[WindowController alloc] initWithWindowNibName:@"Window"]];

	NSUserDefaults *sharedUserDefaults = [NSUserDefaults standardUserDefaults];
	[sharedUserDefaults registerDefaults:@{@"length":			@20,
										   @"lineWidth":		@0.5,
	}];
	
	[self.windowController showWindow:self];
	[self setInspectorShown:[self.windowController.inspectorWindow isVisible]];
}

- (IBAction)toggleInspector:(NSMenuItem *)sender
{
	if (self.inspectorShown)
		[self.windowController.inspectorWindow orderOut:sender];
	else
		[self.windowController.inspectorWindow orderFront:sender];
	[self setInspectorShown:!inspectorShown];
}

- (void)setInspectorShown:(BOOL)shown
{
	if (shown)
		[self.inspectorMenuItem setTitle:@"Hide Inspector"];
	else
		[self.inspectorMenuItem setTitle:@"Show Inspector"];
	inspectorShown = shown;
}

@end
