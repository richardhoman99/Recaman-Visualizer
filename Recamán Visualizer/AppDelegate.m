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
@synthesize windowController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[self setWindowController:[[WindowController alloc] initWithWindowNibName:@"Window"]];

	NSUserDefaults *sharedUserDefaults = [NSUserDefaults standardUserDefaults];
	[sharedUserDefaults registerDefaults:@{@"length":			@20,
										   @"lineWidth":		@0.5,
	}];
	
	[self.windowController showWindow:self];
}

@end
