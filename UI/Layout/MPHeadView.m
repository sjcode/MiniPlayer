//
//  MPHeadView.m
//  MiniPlayer
//
//  Created by Arthur on 8/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MPHeadView.h"


@implementation MPHeadView

- (void)awakeFromNib
{
	[super awakeFromNib];
	backgroundImage = [NSImage imageNamed:@"bg_titlebar"];
}

- (void)drawRect:(NSRect)dirtyRect {
    [backgroundImage drawInRect:[self bounds]
                       fromRect:NSMakeRect(0.0f, 0.0f, backgroundImage.size.width, backgroundImage.size.height)
                      operation:NSCompositeSourceAtop
                       fraction:1.0f];
}

@end
