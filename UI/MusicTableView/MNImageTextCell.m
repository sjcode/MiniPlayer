//
//  MNImageTextCell.m
//  MiniPlayer
//
//  Created by Arthur on 8/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MNImageTextCell.h"

#define IMAGE_INSET 2.0
#define ASPECT_RATIO 1.6
#define TITLE_HEIGHT 17.0
#define FILL_COLOR_RECT_SIZE 25.0
#define INSET_FROM_IMAGE_TO_TEXT 4.0

@interface MNImageTextCell(Private)

- (NSRect)imageFrameForInteriorFrame:(NSRect)frame;
- (NSRect)titleFrameForInteriorFrame:(NSRect)frame;

@end


@implementation MNImageTextCell

@dynamic image;
@synthesize title;

#pragma mark -
#pragma mark object life cycle

- (id)copyWithZone:(NSZone *)zone
{
	MNImageTextCell *result = [super copyWithZone:zone];
	if(result != nil)
	{
		result->albumImageCell = [albumImageCell copyWithZone:zone];
		
	}
	return result;
}

- (void)dealloc
{
	[albumImageCell release];
	[super dealloc];
}

#pragma mark -
#pragma mark public method

- (NSImage *)image
{
	return albumImageCell.image;
}

- (void)setImage:(NSImage *)image
{
	if(albumImageCell == nil)
	{
		albumImageCell = [[NSImageCell alloc]init];
		[albumImageCell setControlView:self.controlView];
		[albumImageCell setBackgroundStyle:self.backgroundStyle];
	}
	albumImageCell.image = image;
}

#pragma mark -
#pragma mark Override method

- (void)drawInteriorWithFrame:(NSRect)frame inView:(NSView *)controlView
{
	if(albumImageCell)
	{
		NSRect imageFrame = [self imageFrameForInteriorFrame:frame];
		[albumImageCell drawWithFrame:imageFrame inView:controlView];
	}
	if(title)
	{
		NSRect textFrame = [self titleFrameForInteriorFrame:frame];
		NSMutableDictionary * attributes = [[[NSMutableDictionary alloc] init] autorelease];
		[attributes setObject:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
		[attributes setObject:[NSFont fontWithName:@"Helvetica" size:14] forKey:NSFontAttributeName];
		[title drawInRect:textFrame withAttributes:attributes];
	}
}

#pragma mark -
#pragma mark Private method

- (NSRect)imageFrameForInteriorFrame:(NSRect)frame
{
	NSRect result = frame;
    // Inset the top
    result.origin.y += IMAGE_INSET;
    result.size.height -= 2*IMAGE_INSET;
    // Inset the left
    result.origin.x += IMAGE_INSET;
    // Make the width match the aspect ratio based on the height
    result.size.width = ceil(result.size.height * ASPECT_RATIO);
    return result;
}

- (NSRect)titleFrameForInteriorFrame:(NSRect)frame
{
	NSRect imageFrame = [self imageFrameForInteriorFrame:frame];
    NSRect result = frame;
    // Move our inset to the left of the image frame
    result.origin.x = NSMaxX(imageFrame) + INSET_FROM_IMAGE_TO_TEXT;
    // Go as wide as we can
    result.size.width = NSMaxX(frame) - NSMinX(result);
    // Move the title above the Y centerline of the image. 
    NSSize naturalSize = [super cellSize];
    result.origin.y = floor(NSMidY(imageFrame) - naturalSize.height ) + 10;
    result.size.height = naturalSize.height;
    return result;
}

@end
