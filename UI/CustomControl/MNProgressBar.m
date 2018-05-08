//
//  MNProgressBar.m
//  MiniPlayer
//
//  Created by Arthur on 8/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MNProgressBar.h"

NSString * MNProgressBarValueDidChangeNotify = @"MNProgressBarValueDidChange";

@implementation MNProgressBar
- (id)initWithFrame:(NSRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib{
	progressImage = [NSImage imageNamed:@"bg_player_progress"];
	thumbImage = [NSImage imageNamed:@"bg_player_thumb"];
	knobImage = [NSImage imageNamed:@"progressposition"];
	
	progressImageLeft = [NSImage imageNamed:@"bg_player_progress_left"];
	progressImageMiddle = [NSImage imageNamed:@"bg_player_progress_middle"];
	progressImageRight = [NSImage imageNamed:@"bg_player_progress_right"];
	
	thumbImageLeft = [NSImage imageNamed:@"bg_player_progress_thumb_left"];
	thumbImageMiddle = [NSImage imageNamed:@"bg_player_progress_thumb_middle"];
	thumbImageRight = [NSImage imageNamed:@"bg_player_progress_thumb_right"];
	
	isMouseDown=NO;
	isKnobRelease = YES;
	lastpostdate=[[NSDate date] retain];
	
	NSTrackingArea *trackingArea = [[[NSTrackingArea alloc] initWithRect:[self visibleRect]
																 options:NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingInVisibleRect |NSTrackingActiveAlways
																   owner:self
																userInfo:nil] autorelease];
	[self addTrackingArea:trackingArea];
	[self display];
}

- (void) dealloc
{
	[super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect {
	
	NSSize canvasSize = NSMakeSize([self bounds].size.width, [self bounds].size.height);
	NSImage *canvas = [[[NSImage alloc] initWithSize:canvasSize] autorelease];
	NSRect canvasRect=NSMakeRect(0, 0, [canvas size].width,[canvas size].height);
	
	
	NSRect sliderRect = canvasRect;
	
	sliderRect.origin.y = (canvasRect.size.height/2) - (progressImage.size.height/2);
	sliderRect.size.height=progressImage.size.height;
	
	[canvas lockFocus];
	
	NSRect leftRect = NSMakeRect(0, 0, [progressImageLeft size].width, [progressImageLeft size].height);
	[progressImageLeft drawInRect:leftRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];	
	
	NSRect middleRect = NSMakeRect([progressImageLeft size].width, 0, canvasSize.width-leftRect.size.width*2, [progressImageMiddle size].height);
	[progressImageMiddle drawInRect:middleRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	NSRect rightRect = NSMakeRect(leftRect.size.width+middleRect.size.width, 0, [progressImageRight size].width, [progressImageRight size].height);
	[progressImageRight drawInRect:rightRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	NSRect thumbRect = sliderRect;
	thumbRect.size.height = [thumbImageMiddle size].height;
	thumbRect.size.width = canvasRect.size.width*[self doubleValue]/[self maxValue];
	
	NSRect thumbLeftRect = NSMakeRect(0, 0, [thumbImageLeft size].width, [thumbImageLeft size].height);
	NSRect thumbMiddleRect = NSMakeRect([thumbImageLeft size].width, 0, thumbRect.size.width-thumbLeftRect.size.width, [thumbImageMiddle size].height);
	NSRect thumbRightRect = NSMakeRect(thumbLeftRect.size.width+thumbMiddleRect.size.width, 0, [thumbImageRight size].width, [thumbImageRight size].height);
	
	[thumbImageLeft drawInRect:thumbLeftRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0]; 
	[thumbImageMiddle drawInRect:thumbMiddleRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0]; 
	[thumbImageRight drawInRect:thumbRightRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0]; 
	
	NSRect thumbRc = sliderRect;
	 
	 if(isMouseEnter)
	 {
	 NSRect knobRect;
	 if(thumbRc.size.width < knobImage.size.width)
	 {
	 knobRect = NSMakeRect(0, 2, knobImage.size.width, knobImage.size.height);
	 }
	 else {
	 knobRect = NSMakeRect(thumbRc.size.width-knobImage.size.width, 2, knobImage.size.width, knobImage.size.height);
	 }
	 
	 [knobImage drawInRect:knobRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	 }
	 
	[canvas unlockFocus];
	
	[canvas drawInRect:canvasRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
}

- (void)setDoubleValue:(double)doubleValue
{
	[super setDoubleValue:doubleValue];
	[self setNeedsDisplay:YES];
}

- (BOOL)mouseDownCanMoveWindow
{
	return NO;
}

- (BOOL)isFlipped
{	
	return NO;
}

- (void) mouseDown:(NSEvent *)theEvent
{
	isKnobRelease = NO;
	isMouseEnter = YES;
	NSPoint thePoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	if(NSPointInRect(thePoint, [self bounds])){
		isMouseDown=YES;
		[self mouseDragged:theEvent];
	}
}

- (void)mouseUp:(NSEvent *)theEvent
{
	isMouseDown=NO;
	isKnobRelease = YES;
	isMouseEnter = NO;
	
	[self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)theEvent
{
	if (isMouseDown) {
		NSPoint thePoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
		double theValue;
		double maxX=[self bounds].size.width;
		
		if (thePoint.x < 0)
			theValue = [self minValue];
		else if (thePoint.x >= [self bounds].size.width)
			theValue = [self maxValue];
		else
			theValue = [self minValue] + (([self maxValue] - [self minValue]) *
										  (thePoint.x - 0) / (maxX - 0));
		[self setDoubleValue:theValue];
		
		NSDate *now=[[NSDate date] retain];
		NSTimeInterval diff = [now timeIntervalSinceDate:lastpostdate];
		if (diff>0.08) {  
			[[NSNotificationCenter defaultCenter]
			 postNotificationName:MNProgressBarValueDidChangeNotify
			 object:self
			 userInfo:[NSDictionary 
					   dictionaryWithObject:[NSNumber numberWithDouble:theValue]
					   forKey:@"ProgressBarValue"]];
			[lastpostdate release];
			lastpostdate=now;			
		}
		
		[self display];
	}
}

- (void)mouseEntered:(NSEvent *)event {
	isMouseEnter = YES;
	[self setNeedsDisplay:YES];
}

- (void)mouseExited:(NSEvent *)event {
	if(isKnobRelease)
	{
		isMouseEnter = NO;
	}
	[self setNeedsDisplay:YES];
}

@end
