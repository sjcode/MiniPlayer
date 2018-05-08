//
//  MNFootView.m
//  MiniPlayer
//
//  Created by Arthur on 8/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MNFootView.h"


@implementation MNFootView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)awakeFromNib
{
	[super awakeFromNib];
	backgroundImage = [NSImage imageNamed:@"bg_toolbar"];
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
	[backgroundImage drawInRect:[self bounds]
                       fromRect:NSMakeRect(0.0f, 0.0f, backgroundImage.size.width, backgroundImage.size.height)
                      operation:NSCompositeSourceAtop
                       fraction:1.0f];
	
}

@end
