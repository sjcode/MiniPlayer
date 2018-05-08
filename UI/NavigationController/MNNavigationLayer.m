//
//  MNNavigationLayer.m
//  NavigationBarDemo
//
//  Created by Arthur on 8/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MNNavigationLayer.h"

#import "Utilites.h"
CGImageRef layerImage(NSRect rect)
{
	CGImageRef returnImage = nil;
	
	if(returnImage == nil)
	{
		NSImage *returnValue = [[[NSImage alloc]initWithSize:NSMakeSize(NSWidth(rect),NSHeight(rect))]autorelease];
		[returnValue lockFocus];
		NSColor *startColor = [NSColor colorWithDeviceWhite:1 alpha:1];
		NSColor *endColor = [NSColor colorWithDeviceWhite:0.9 alpha:1];
		NSArray *colors = [NSArray arrayWithObjects:startColor,endColor,nil];
		NSGradient *gradient = [[[NSGradient alloc]initWithColors:colors] autorelease];
		[gradient drawInRect:NSMakeRect(0, 0, NSWidth(rect),NSHeight(rect)) angle:-90];
		[returnValue unlockFocus];
		CGImageSourceRef source;
		
		source = CGImageSourceCreateWithData((CFDataRef)[returnValue TIFFRepresentation], NULL);
		returnImage =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
	}
	return returnImage;
}

CGImageRef layerPushedImage(NSRect rect)
{
	CGImageRef returnImage = nil;
	
	if(returnImage == nil)
	{
		NSImage *returnValue = [[[NSImage alloc]initWithSize:NSMakeSize(NSWidth(rect),NSHeight(rect))]autorelease];
		[returnValue lockFocus];
		NSColor *startColor = [NSColor colorWithDeviceWhite:0 alpha:1];
		NSColor *endColor = [NSColor colorWithDeviceWhite:0 alpha:1];
		NSArray *colors = [NSArray arrayWithObjects:startColor,endColor,nil];
		NSGradient *gradient = [[[NSGradient alloc]initWithColors:colors] autorelease];
		[gradient drawInRect:NSMakeRect(0, 0, NSWidth(rect), NSHeight(rect)) angle:-90];
		[returnValue unlockFocus];
		CGImageSourceRef source;
		
		source = CGImageSourceCreateWithData((CFDataRef)[returnValue TIFFRepresentation], NULL);
		returnImage =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
	}
	return returnImage;
}



@implementation MNNavigationLayer
@synthesize text;

- (id) init
{
    if((self = [super init]))
	{
		[self setNeedsDisplayOnBoundsChange:YES];
    }
    
    return self;
}

- (void)dealloc
{
	[text release];
	[super dealloc];
}
#import <AppKit/NSAttributedString.h>
- (void)drawInContext:(CGContextRef)context
{
	//CGContextSetRGBFillColor(context, 1, 1, 1, 1);
    //CGContextFillRect(context,self.frame );
	
	CGImageRef image,arrowImage;
	NSNumber * isMouseDown = [self valueForKey:@"isMouseDown"];
	if([isMouseDown intValue]== 1)
	{
		image = centerSparatorPushedImage();//layerPushedImage(self.frame);
		arrowImage = arrowPushedImage();
	}
	else
	{
		image = layerImage(self.frame);
		arrowImage = arrowInactiveImage();
	}
	
	CGRect frame = self.frame;
	frame.origin.x = 0;
	frame.origin.y = 0;

	//[CATransaction begin];//临时关闭动画效果
	//[CATransaction setValue:(id)kCFBooleanTrue
	//				 forKey:kCATransactionDisableActions];
	
	
	CGContextDrawImage(context, frame, image);

	CGContextDrawImage(context, CGRectMake(frame.size.width - 10, 12, CGImageGetWidth(arrowImage), CGImageGetHeight(arrowImage)), arrowImage);
	
	NSGraphicsContext *nsGraphicsContext;
	nsGraphicsContext = [NSGraphicsContext graphicsContextWithGraphicsPort:context flipped:NO];
	[NSGraphicsContext saveGraphicsState];
	[NSGraphicsContext setCurrentContext:nsGraphicsContext];
	
	NSMutableDictionary *attributes = [[[NSMutableDictionary alloc] init]autorelease];
	[attributes setObject:[NSFont fontWithName:@"Arial" size:14] forKey:NSFontAttributeName];

		
	NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	[style setLineBreakMode:NSLineBreakByClipping];
	[style setAlignment:NSLeftTextAlignment];
	[attributes setValue:style forKey:NSParagraphStyleAttributeName];

	if([isMouseDown boolValue]== YES)
		[attributes setObject:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
	else
		[attributes setObject:[NSColor blackColor] forKey:NSForegroundColorAttributeName];
	
	NSSize size = [self.string sizeWithAttributes:attributes];
	NSRect textFrame;
	NSNumber *isMouseOver = [self valueForKey:@"isMouseOver"];
	if([isMouseOver boolValue] == YES)
	{
		textFrame = NSMakeRect(10, 10, size.width, size.height);
	}
	else
	{
		textFrame = NSMakeRect(10, 10, CElL_MIX_WIDTH-30, size.height);
	}
	NSLog(@"layer %@ %@",self.name,NSStringFromRect(textFrame));
	[self.string drawInRect:textFrame withAttributes:attributes];

	[NSGraphicsContext restoreGraphicsState];
	
	//[CATransaction commit];
	return;
	
}

@end
