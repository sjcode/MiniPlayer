//
//  MiniPlayerAppDelegate.m
//  MiniPlayer
//
//  Created by Arthur on 8/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MiniPlayerAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "MNImageTextCell.h"
@implementation MiniPlayerAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification 
{
	// Insert code here to initialize your application 
	[navigationBar insertTab:@"You have to explicitly disable animations"];
	[navigationBar insertTab:@"I don't understand why this"];
	[navigationBar insertTab:@"测2试3文4本3abcdefg"];
}

- (void)awakeFromNib
{
	self.window.alphaValue = 0.0;
	[self.window.animator setAlphaValue:1.0];
	CAAnimation *anim = [CABasicAnimation animation];	
	[anim setDelegate:self];
	[self.window setAnimations:[NSDictionary dictionaryWithObject:anim forKey:@"alphaValue"]];
	
	testimage = [[NSImage imageNamed:@"defaultvedio"]retain];
	
	
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
	[NSApp terminate:self];
}

- (BOOL)windowShouldClose:(id)sender
{
	[self.window.animator setAlphaValue:0.0];
	return NO;
}

#pragma mark -
#pragma mark NSTableView delegate and source

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return 3;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    return @"hello miniplayer";
}

- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row 
{	
	MNImageTextCell *imageTextCell = (MNImageTextCell *)cell;
	imageTextCell.image = testimage;
	imageTextCell.title = @"music 1";
}

@end
