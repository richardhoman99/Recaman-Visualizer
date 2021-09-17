//
//  AppDelegate.m
//  Recamán Visualizer
//
//  Created by Richard Homan on 9/14/21.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (strong) IBOutlet NSWindow *window;

@end

@implementation AppDelegate
@synthesize windowController, window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[self setWindowController:[[WindowController alloc] initWithWindow:window]];

	NSUserDefaults *sharedUserDefaults = [NSUserDefaults standardUserDefaults];
	[sharedUserDefaults registerDefaults:@{@"length":			@20,
										   @"lineWidth":		@0.5,
	}];
			
	[self.windowController showWindow:self];
}

@end
