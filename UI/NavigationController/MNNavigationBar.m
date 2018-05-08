//
//  MNNavigationBar.m
//  NavigationBarDemo
//
//  Created by Arthur on 8/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MNNavigationBar.h"
#import "Utilites.h"
#define degreesToRadians(x) (M_PI * x / 180.0)
/*

 */

@interface MNNavigationBar(Private)

- (void)initRootLayer;
- (CALayer *)addSparator;
- (void)AddMaskLayer:(NSRect)rect;
@end

@implementation MNNavigationBar

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)awakeFromNib
{
	
	curBarWidth = 0;
	tabArray = [[NSMutableArray alloc]init];
	[self initRootLayer];
	trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds
												options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow )
												  owner:self userInfo:nil];
	[self addTrackingArea:trackingArea];
}

- (void)dealloc
{
	[tabArray release];
	CGColorRelease(borderColor);
	[super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
	
	NSColor *startColor = [NSColor colorWithDeviceWhite:1 alpha:1];
	NSColor *endColor = [NSColor colorWithDeviceWhite:0.9 alpha:1];
	NSArray *colors = [NSArray arrayWithObjects:startColor,endColor,nil];
	NSGradient *gradient = [[[NSGradient alloc]initWithColors:colors] autorelease];
	[gradient drawInRect:dirtyRect angle:-90];
	 
	/*
	NSMutableDictionary *attributes = [[[NSMutableDictionary alloc] init]autorelease];
	[attributes setObject:[NSFont fontWithName:@"Arial" size:14] forKey:NSFontAttributeName];
	NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	[style setLineBreakMode:NSLineBreakByClipping];
	//[style setAlignment:NSLeftTextAlignment];
	[attributes setValue:style forKey:NSParagraphStyleAttributeName];
	NSString *str = @"You have to explicitly disable animations";
	[str drawInRect:dirtyRect withAttributes:attributes];*/
}

- (void)initRootLayer
{

	[self setWantsLayer:YES];
	rootLayer = self.layer;
	NSLog(@"initRootLayer rootLayer = %@",rootLayer);
	rootLayer.backgroundColor = CGColorCreateGenericRGB(1.0f,1.0f,1.0f,1.0f);
	rootLayer.layoutManager = [CAConstraintLayoutManager layoutManager];
	rootLayer.borderWidth = 1;
	borderColor = CGColorCreateGenericRGB(0, 0, 0, 0.2);
	rootLayer.borderColor = borderColor;

}

- (void)insertTab:(NSString *)stringValue
{/*
	CALayer *layer = [CALayer layer];
	NSString *layerName = [NSString stringWithFormat:@"%0.1f",tabIndex];
	tabIndex += 0.5;
	layer.name = layerName;
	layer.frame = CGRectMake(0, 0, CElL_MIX_WIDTH, CELL_HEIGHT);
	layer.position = CGPointMake(curBarWidth, 0);
	curBarWidth += CElL_MIX_WIDTH;
	layer.anchorPoint = CGPointMake(0, 0);
	[rootLayer addSublayer:layer];
*/	
	MNNavigationLayer *textLayer = [MNNavigationLayer layer];
	textLayer.string = stringValue;
	textLayer.layoutManager = [CAConstraintLayoutManager layoutManager];
	textLayer.frame = CGRectMake(0, 0, CElL_MIX_WIDTH, CELL_HEIGHT);
	
	textLayer.position = CGPointMake(curBarWidth, 0);
	
	NSString *textLayerName = [NSString stringWithFormat:@"textLayer%0.1f",tabIndex];
	textLayer.name = textLayerName;
	
	textLayer.anchorPoint = CGPointMake(0, 0);
	textLayer.fontSize = 16.0f;
	textLayer.font = @"Helvetica";

	textLayer.foregroundColor = CGColorGetConstantColor(kCGColorBlack);
	
	
	//[textLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth relativeTo:@"superlayer" attribute:kCAConstraintWidth]];
	//[textLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight relativeTo:@"superlayer" attribute:kCAConstraintHeight ]];
	
	curBarWidth += CElL_MIX_WIDTH;
	tabIndex += 0.5;
	
	[rootLayer addSublayer:textLayer];
	[textLayer setNeedsDisplay];
	CALayer *sparatorLayer = [self addSparator];
	//[self AddMaskLayer:NSZeroRect];
	
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	[dict setValue:textLayer forKey:@"kDataTextLayer"];
	[dict setValue:textLayerName forKey:@"kDataTextLayerName"];
	//[dict setValue:layer forKey:@"kDataLayer"];
	[dict setValue:sparatorLayer forKey:@"kDataSparatorLayer"];
	
	[tabArray addObject:dict];
	//textLayer.alignmentMode = kCAAlignmentCenter;
	
	
	
	
	
	
	
	/*
	NSLog(@"start insertTab");
	MNNavigationLayer *layer = [[MNNavigationLayer alloc]init];
	layer.layoutManager = [CAConstraintLayoutManager layoutManager];
	
	NSString *layerName = [NSString stringWithFormat:@"%0.1f",tabIndex];
	tabIndex += 0.5;
	
	layer.name = layerName;
	layer.text = stringValue;
	layer.frame = CGRectMake(0, 0, CElL_MIX_WIDTH, CELL_HEIGHT);
	layer.position = CGPointMake(curBarWidth, 0);
	curBarWidth += CElL_MIX_WIDTH;
	layer.anchorPoint = CGPointMake(0, 0);
	
	
	//[tabArray addObject:layer];
	
	
	[rootLayer addSublayer:layer];
	NSLog(@"insertTab rootLayer = %@",rootLayer);
	
	[self addSparator];
	[layer setNeedsDisplay];
	
	NSLog(@"end insertTab");*/
}

- (CALayer *)addSparator
{
	CALayer *sparatorLayer = [CALayer layer];

	CGFloat width = CGImageGetWidth(sparatorImage());
	CGFloat height = CGImageGetHeight(sparatorImage());
	
	NSString *layerName = [NSString stringWithFormat:@"%0.1f",tabIndex];
	tabIndex += 0.5;
	sparatorLayer.name = layerName;
	sparatorLayer.frame = CGRectMake(0, 0, width, height);
	sparatorLayer.contents = (id)sparatorImage();
	sparatorLayer.position = CGPointMake(curBarWidth, 0);
	curBarWidth += width;
	sparatorLayer.anchorPoint = CGPointMake(0, 0);
	[rootLayer addSublayer:sparatorLayer];
	return sparatorLayer;
}

- (void)updateLayer
{
	NSArray *sublayer = rootLayer.sublayers;
	NSLog(@"updateLayer rootLayer = %@",rootLayer);
	CALayer *layer;
	for(layer in sublayer)
	{
		[layer setNeedsDisplay];
	}
	[rootLayer setNeedsDisplay];
}

-(void)resizeLayer:(CALayer*)layer to:(CGSize)size
{
    // Prepare the animation from the old size to the new size
    CGRect oldBounds = layer.bounds;
    CGRect newBounds = oldBounds;
    newBounds.size = size;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    animation.fromValue = [NSValue valueWithRect:NSRectFromCGRect(oldBounds)];
    animation.toValue = [NSValue valueWithRect:NSRectFromCGRect(newBounds)];
	
    // Update the layer's bounds so the layer doesn't snap back when the animation completes.
    layer.bounds = newBounds;
	
    // Add the animation, overriding the implicit animation.
    [layer addAnimation:animation forKey:@"bounds"];
}

-(void)moveLayer:(CALayer*)layer to:(CGPoint)point
{
    // Prepare the animation from the current position to the new position
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [layer valueForKey:@"position"];
    animation.toValue = [NSValue valueWithPoint:NSPointFromCGPoint(point)];
	
    // Update the layer's position so that the layer doesn't snap back when the animation completes.
    layer.position = point;
	
    // Add the animation, overriding the implicit animation.
    [layer addAnimation:animation forKey:@"position"];
}

- (void)AddMaskLayer:(NSRect)rect
{
	CAGradientLayer *gradientLayer = [CAGradientLayer layer];
	gradientLayer.name = @"gradientLayer";
	//Create 2 colors for the gradient
	CGColorRef maskcolor1 = CGColorCreateGenericRGB(1, 1, 1, 1);
	CGColorRef maskcolor2 = CGColorCreateGenericRGB(1, 1, 1, 0.9);
	CGColorRef maskcolor3 = CGColorCreateGenericRGB(1, 1, 1, 0.8);
	CGColorRef maskcolor4 = CGColorCreateGenericRGB(1, 1, 1, 0.7);
	CGColorRef maskcolor5 = CGColorCreateGenericRGB(1, 1, 1, 0.6);
	CGColorRef maskcolor6 = CGColorCreateGenericRGB(1, 1, 1, 0.0);
	
	//Package the colors in a NSArray and add it to the layer
	NSArray *colors = [NSArray arrayWithObjects:(id) maskcolor6, (id) maskcolor5,(id) maskcolor4,(id) maskcolor3,(id) maskcolor2,(id) maskcolor1, nil];
	gradientLayer.colors = colors;
	
	//Set the size and position of the gradient layer
	gradientLayer.bounds = CGRectMake(0, 0, 70, 40);
	gradientLayer.position = CGPointMake(70, 0);
	
	//Rotate the gradient layer by adding a rotation matrix
	// Define rotation on z axis
	float degreesVariance = 90;
	// object will always take shortest path, so that
	// a rotation of less than 180 deg will move clockwise, and more than will move counterclockwise
	
	float radiansToRotate = degreesToRadians( degreesVariance );
	
	gradientLayer.transform = CATransform3DMakeRotation(radiansToRotate, 0, 0, -1);	
	
	[rootLayer addSublayer:gradientLayer];
}

- (CALayer *)layerByLocationInWindow:(NSEvent*)event
{
	CALayer *layer;
	CGPoint point = NSPointToCGPoint([self convertPoint:[event locationInWindow] fromView:nil]);
	layer = [rootLayer hitTest:point];
	if(layer)
	{
		return layer;
	}
	return nil;
}

- (CALayer *)layerByName:(NSString *)name
{
	NSArray *sublayers = rootLayer.sublayers;
	NSEnumerator *enumerator = [sublayers objectEnumerator];
	CALayer *layer;
	while (layer = [enumerator nextObject])
	{
		if([name isEqualToString:layer.name])
			return layer;
	}
	return nil;
}

- (CALayer*)baseLayerFromTextLayerName:(NSString*)name
{
	NSEnumerator *enumerator = [tabArray objectEnumerator];
	NSMutableDictionary *dict;
	while (dict = [enumerator nextObject])
	{
		NSString *textLayerName = [dict valueForKey:@"kDataTextLayerName"];
		if(textLayerName && [textLayerName isEqualToString:name])
		{
			return [dict valueForKey:@"kDataLayer"];
		}
	}
	return nil;
}

- (void)resetBar
{
	CGFloat increaseWidth = 0;
	CALayer *outLayer = [self layerByName:lastMoveLayer];
	if(outLayer)
	{
		NSAssert(outLayer != nil,@"baseLayer == nil");
		BOOL bFound = NO;
		NSArray *sublayers = rootLayer.sublayers;
		NSEnumerator *enumerator = [sublayers objectEnumerator];
		CALayer *layer;
		while (layer = [enumerator nextObject])
		{
			if(layer == outLayer && [layer.name rangeOfString:@".5"].location ==NSNotFound)
			{
				CATextLayer *textLayer = (CATextLayer*)layer;
				NSMutableDictionary *attributes = [[[NSMutableDictionary alloc] init]autorelease];
				[attributes setObject:[NSFont fontWithName:@"Arial" size:14] forKey:NSFontAttributeName];
				NSSize realSize = [textLayer.string sizeWithAttributes:attributes];
				
				CGSize newSize = layer.frame.size;
				increaseWidth = NSSizeToCGSize(realSize).width - CElL_MIX_WIDTH + 30;
				newSize.width = CElL_MIX_WIDTH;
				
				[textLayer setValue:[NSNumber numberWithBool:NO] forKey:@"isMouseOver"];
				
				[self resizeLayer:layer to:newSize];
				
				/*
				CGSize newSize = layer.frame.size;
				newSize.width = CElL_MIX_WIDTH;
				[self resizeLayer:layer to:newSize];
				*/
				//CALayer *textLayer = [layer.sublayers objectAtIndex:0];
//				newSize = textLayer.frame.size;
//				newSize.width -= 40;
//				[self resizeLayer:textLayer to:newSize];
				bFound = YES;
			}
			else
			{
				if(bFound)
				{
					CGPoint newPoint = layer.position;
					newPoint.x -= increaseWidth;
					[self moveLayer:layer to:newPoint];
				}
			}
			
		}
		lastMoveLayer = @"";
	}
	
}

- (CGImageRef)loadImageWithName:(NSString *)imageName
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

- (CGImageRef)centerSparatorPushedImage
{
	if(centerSparatorPushedImage == nil)
	{
		centerSparatorPushedImage = [self loadImageWithName:@"navBar-separator-center-pushed.png"];
	}
	return centerSparatorPushedImage;
}

- (void)mouseDown:(NSEvent*)theEvent
{
	CALayer * layer =  [self layerByLocationInWindow:theEvent];
	if(layer)
	{
		if([layer.name rangeOfString:@".5"].location == NSNotFound)
		{
			CATextLayer *textLayer = (CATextLayer*)layer;
			textLayer.foregroundColor = CGColorGetConstantColor(kCGColorWhite);
			[textLayer setValue:[NSNumber numberWithBool:YES] forKey:@"isMouseDown"];
			[textLayer setNeedsDisplay];
			
			NSString *rightSparator,*leftSparator;
			
			NSString *layerName = layer.name;
			NSRange range = [layerName rangeOfString:@"textLayer"];
			NSString *layerId = [layerName substringFromIndex:range.length];
			leftSparator = [NSString stringWithFormat:@"%0.1f",[layerId floatValue]-0.5];
			rightSparator = [NSString stringWithFormat:@"%0.1f",[layerId floatValue]+0.5];
			
			CALayer *leftSparatorLayer = [self layerByName:leftSparator];
			CALayer *rightSparatorLayer = [self layerByName:rightSparator];
			[CATransaction begin];//临时关闭动画效果
			[CATransaction setValue:(id)kCFBooleanTrue
							 forKey:kCATransactionDisableActions];
			leftSparatorLayer.contents = (id)leftSparatorPushedImage();
			rightSparatorLayer.contents = (id)rightSparatorPushedImage();
			[CATransaction commit];

			[self popupMenu:textLayer.string location:NSMakePoint(textLayer.position.x, textLayer.position.y)];
			NSLog(@"popup done");
			
			[textLayer setValue:[NSNumber numberWithBool:NO] forKey:@"isMouseDown"];
			[textLayer setNeedsDisplay];
			[CATransaction begin];//临时关闭动画效果
			[CATransaction setValue:(id)kCFBooleanTrue
							 forKey:kCATransactionDisableActions];
			leftSparatorLayer.contents = (id)sparatorImage();
			rightSparatorLayer.contents = (id)sparatorImage();
			[CATransaction commit];
		}
	}
}
/*
- (void)mouseUp:(NSEvent *)theEvent
{
	CALayer * layer =  [self layerByLocationInWindow:theEvent];
	if(layer)
	{
		if([layer.name rangeOfString:@".5"].location == NSNotFound)
		{
			CATextLayer *textLayer = (CATextLayer*)layer;
			textLayer.foregroundColor = CGColorGetConstantColor(kCGColorBlack);
			[textLayer setValue:[NSNumber numberWithInt:0] forKey:@"isMouseDown"];
			[textLayer setNeedsDisplay];
			
			NSString *rightSparator,*leftSparator;
			NSString *layerName = layer.name;
			NSRange range = [layerName rangeOfString:@"textLayer"];
			NSString *layerId = [layerName substringFromIndex:range.length];
			leftSparator = [NSString stringWithFormat:@"%0.1f",[layerId floatValue]-0.5];
			rightSparator = [NSString stringWithFormat:@"%0.1f",[layerId floatValue]+0.5];
			CALayer *leftSparatorLayer = [self layerByName:leftSparator];
			CALayer *rightSparatorLayer = [self layerByName:rightSparator];
			[CATransaction begin];//临时关闭动画效果
			[CATransaction setValue:(id)kCFBooleanTrue
							 forKey:kCATransactionDisableActions];
			leftSparatorLayer.contents = (id)sparatorImage();
			rightSparatorLayer.contents = (id)sparatorImage();
			[CATransaction commit];
		}
	}
}*/

- (void)mouseEntered:(NSEvent *)theEvent
{
	NSLog(@"mouseEntered %@",[self layerByLocationInWindow:theEvent].name);
}

- (void)mouseExited:(NSEvent *)theEvent
{
	NSLog(@"mouseExited lastMoveLayer = %@",lastMoveLayer);
	[self resetBar];
}

- (void)mouseMoved:(NSEvent *)theEvent
{	
	CGFloat increaseWidth = 0;
	CALayer *inLayer = [self layerByLocationInWindow:theEvent];
	if(inLayer)
	{
		NSString *name = inLayer.name;
		//NSLog(@"mouseMoved %@ layer = %@",name,inLayer);
		if(name && ![name isEqualToString:lastMoveLayer])
		{
			[self resetBar];
			
			//CALayer *baseLayer = [self baseLayerFromTextLayerName:name];
			//NSAssert(baseLayer != nil,@"baseLayer == nil");
			
			BOOL bFound = NO;
			NSArray *sublayers = rootLayer.sublayers;
			NSEnumerator *enumerator = [sublayers objectEnumerator];
			CALayer *layer;
			while (layer = [enumerator nextObject])
			{
				if(layer == inLayer && [layer.name rangeOfString:@".5"].location ==NSNotFound)
				{
					CATextLayer *textLayer = (CATextLayer*)layer;
					NSMutableDictionary *attributes = [[[NSMutableDictionary alloc] init]autorelease];
					[attributes setObject:[NSFont fontWithName:@"Arial" size:14] forKey:NSFontAttributeName]; 					
					NSSize realSize = [textLayer.string sizeWithAttributes:attributes];
					
					CGSize newSize = layer.frame.size;
					increaseWidth = NSSizeToCGSize(realSize).width - CElL_MIX_WIDTH+30;
					newSize.width += increaseWidth;
					
					[textLayer setValue:[NSNumber numberWithBool:YES] forKey:@"isMouseOver"];
					
					
					[self resizeLayer:layer to:newSize];
					
					
					
//					CALayer *textLayer = [layer.sublayers objectAtIndex:0];
//					newSize = textLayer.frame.size;
//					newSize.width += 40;
//					[self resizeLayer:textLayer to:newSize];
					bFound = YES;
				}
				else
				{
					if(bFound)
					{
						CGPoint newPoint = layer.position;
						newPoint.x += increaseWidth;
						[self moveLayer:layer to:newPoint];
					}
				}

			}
			lastMoveLayer = [name retain];
			//NSLog(@"lastMoveLayer = %@",lastMoveLayer);
		}
	}
}

-(IBAction)menuItemSelected:(id)sender 
{
	
}

- (void)popupMenu:(NSString*)string location:(NSPoint)location
{
	NSPoint baseViewPoint = NSMakePoint(location.x, self.frame.origin.y);
	NSPoint screenPoint = [[[self window]contentView] convertPointToBase:baseViewPoint];
	screenPoint = [[self window] convertBaseToScreen:screenPoint];
	screenPoint.y -= 4;
	
	NSMenu *theMenu = [[[NSMenu alloc] initWithTitle:@"test"] autorelease];
	[theMenu setShowsStateColumn:NO];
	[theMenu setAutoenablesItems:NO];
	
	for (int i=0;i<10;i++) 
	{
		
		NSString *labelText = @"some text";
		
		NSMenuItem *theMenuItem = [[[NSMenuItem alloc] initWithTitle:labelText
															  action:@selector(menuItemSelected:)
													   keyEquivalent:@""] autorelease]; 
		
		[theMenuItem setTarget:self];

		//[theMenuItem setRepresentedObject:item];
		[theMenuItem setEnabled:YES];
		//[theMenuItem setImage:[NSImage imageNamed:@""]];
		[theMenu addItem:theMenuItem];
	}
	NSLog(@"screenPoint = %@",NSStringFromPoint(screenPoint));
	[theMenu popUpMenuPositioningItem:nil atLocation:screenPoint inView:nil];
}

@end
