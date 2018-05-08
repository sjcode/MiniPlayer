//
//  MNImageTextCell.h
//  MiniPlayer
//
//  Created by Arthur on 8/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MNImageTextCell : NSTextFieldCell 
{
@private
	NSImageCell *albumImageCell;
	NSString *title;
}

@property (retain) NSImage *image;
@property (copy) NSString *title;
@end
