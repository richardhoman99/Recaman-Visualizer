//
//  AppDelegate.h
//  Recamán Visualizer
//
//  Created by Richard Homan on 9/14/21.
//

#import <Cocoa/Cocoa.h>
#import "WindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (weak, nonatomic) IBOutlet NSMenuItem *inspectorMenuItem;

@property (strong, nonatomic) WindowController *windowController;
@property (nonatomic) BOOL inspectorShown;

- (IBAction)toggleInspector:(NSMenuItem *)sender;

@end

