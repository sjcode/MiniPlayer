//
//  MiniPlayerAppDelegate.h
//  MiniPlayer
//
//  Created by Arthur on 8/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MNNavigationBar.h"

@interface MiniPlayerAppDelegate : NSObject <NSApplicationDelegate> 
{
	IBOutlet MNNavigationBar *navigationBar;
    NSWindow *window;
	NSImage *testimage;
}

@property (assign) IBOutlet NSWindow *window;

@end
