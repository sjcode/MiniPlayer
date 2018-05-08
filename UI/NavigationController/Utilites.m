//
//  Utilites.m
//  NavigationBarDemo
//
//  Created by Arthur on 9/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Utilites.h"


CGImageRef loadImageWithName(NSString *imageName)
{	
	CGImageRef returnImage;
	NSString *path = [[NSBundle mainBundle] pathForResource:[imageName stringByDeletingPathExtension] ofType:[imageName pathExtension]];
	if(path){
		CGImageSourceRef imageSource = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:path], NULL);
		
		if(imageSource){
			returnImage = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
		}
	}
	
	return returnImage;
}

CGImageRef sparatorImage()
{
	static CGImageRef sparatorImage = nil;
	if(sparatorImage == nil)
	{
		sparatorImage = loadImageWithName(@"navBar-separator.png");
	}
	return sparatorImage;
}

CGImageRef centerSparatorImage()
{
	static CGImageRef centerSparatorImage = nil;
	if(centerSparatorImage == nil)
	{
		centerSparatorImage = loadImageWithName(@"navBar-separator-center-pushed-inactive.png");
	}
	return centerSparatorImage;
}

CGImageRef centerSparatorPushedImage()
{
	static CGImageRef centerSparatorPushedImage = nil;
	if(centerSparatorPushedImage == nil)
	{
		centerSparatorPushedImage = loadImageWithName(@"navBar-separator-center-pushed.png");
	}
	return centerSparatorPushedImage;
}

CGImageRef rightSparatorImage()
{
	static CGImageRef rightSparatorImage = nil;
	if(rightSparatorImage == nil)
	{
		rightSparatorImage = loadImageWithName(@"navBar-separator-right-pushed-inactive.png");
	}
	return rightSparatorImage;
}

CGImageRef rightSparatorPushedImage()
{
	static CGImageRef rightSparatorPushedImage = nil;
	if(rightSparatorPushedImage == nil)
	{
		rightSparatorPushedImage = loadImageWithName(@"navBar-separator-right-pushed.png");
	}
	return rightSparatorPushedImage;
}

CGImageRef leftSparatorImage()
{
	static CGImageRef leftSparatorImage = nil;
	if(leftSparatorImage == nil)
	{
		leftSparatorImage = loadImageWithName(@"navBar-separator-left-pushed-inactive.png");
	}
	return leftSparatorImage;
}

CGImageRef leftSparatorPushedImage()
{
	static CGImageRef leftSparatorPushedImage = nil;
	if(leftSparatorPushedImage == nil)
	{
		leftSparatorPushedImage = loadImageWithName(@"navBar-separator-left-pushed.png");
	}
	return leftSparatorPushedImage;
}

CGImageRef arrowInactiveImage()
{
	static CGImageRef arrowImage = nil;
	if(arrowImage == nil)
	{
		arrowImage = loadImageWithName(@"tinyArrow.png");
	}
	return arrowImage;
}

CGImageRef arrowPushedImage()
{
	static CGImageRef arrowImage = nil;
	if(arrowImage == nil)
	{
		arrowImage = loadImageWithName(@"tinyArrow-pushed.png");
	}
	return arrowImage;
}
