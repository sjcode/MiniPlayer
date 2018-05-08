//
//  MNNavigationLayer.h
//  NavigationBarDemo
//
//  Created by Arthur on 8/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

#define CElL_MIX_WIDTH 110
#define CELL_MAX_WIDTH	120
#define CELL_HEIGHT 34

#define CELL_EDGE 15
#define POPUP_BUTTON_WIDTH 15
#define THUMB_IMAGE_WIDTH 20

@interface MNNavigationLayer : CATextLayer 
{
	NSString *text;
}

@property (nonatomic,copy)NSString *text;


@end
