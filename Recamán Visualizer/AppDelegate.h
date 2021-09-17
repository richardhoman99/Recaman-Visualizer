//
//  AppDelegate.h
//  Recamán Visualizer
//
//  Created by Richard Homan on 9/14/21.
//

#import <Cocoa/Cocoa.h>
#import "WindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (strong, nonatomic) WindowController *windowController;

@end

