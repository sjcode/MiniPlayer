//
//  MNNavigationBar.h
//  NavigationBarDemo
//
//  Created by Arthur on 8/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MNNavigationLayer.h"

@interface MNNavigationBar : NSView 
{
	NSMutableArray *tabArray;
	CALayer *rootLayer;
	CGFloat curBarWidth;
	CGColorRef borderColor;
	float tabIndex;
	NSTrackingArea *trackingArea;
	NSString * lastMoveLayer;
	
	CGImageRef centerSparatorPushedImage;
}

- (void)insertTab:(NSString *)stringValue;
- (void)updateLayer;
- (void)popupMenu:(NSString*)string location:(NSPoint)location;

@end
