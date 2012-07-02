//
//  CKRecipeCell.m
//  Cookie
//
//  Created by Benjamin Lefebvre on 7/1/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import "CKRecipeCell.h"

@implementation CKRecipeCell

@synthesize image, indicator;

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    CKRecipeCell *cell = [super copyWithZone:zone];
    if (cell == nil) {
        return nil;
    }
    
    // Clear the image and subtitle as they won't be retained
    cell->image = nil;
    cell->indicator = nil;
    [cell setImage:[self image]];
    [cell setIndicator:[self indicator]];
    
    return cell;
}

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
    NSRect imageRect = [self imageRectForBounds:cellFrame];
    if (image) {
        [image drawInRect:imageRect 
                 fromRect:NSZeroRect 
                operation:NSCompositeSourceOver
                 fraction:1.0 
           respectFlipped:YES 
                    hints:nil];
    } else {
        NSBezierPath *path = [NSBezierPath bezierPathWithRect:imageRect];
        [[NSColor grayColor] set];
        [path fill];
    }
    
    NSRect titleRect = [self titleRectForBounds:cellFrame];
    NSAttributedString *aTitle = [self attributedStringValue];
    if ([aTitle length] > 0) {
        [aTitle drawInRect:titleRect];
    }
    
 //   NSRect indicatorRect = [self indicatorRectForBounds:cellFrame forTitleBounds:titleRect];
//    NSAttributedString *aSubtitle = [self attributedSubtitleValue];
    /* 
    if ([aSubtitle length] > 0) {
        [aSubtitle drawInRect:indicatorRect];
    }
    */
}

#define BORDER_SIZE 5
#define IMAGE_SIZE 64

- (NSRect)imageRectForBounds:(NSRect)bounds
{
    NSRect imageRect = bounds;
    
    imageRect.origin.x += BORDER_SIZE;
    imageRect.origin.y += BORDER_SIZE;
    imageRect.size.width = IMAGE_SIZE;
    imageRect.size.height = IMAGE_SIZE;
    
    return imageRect;
}

- (NSRect)titleRectForBounds:(NSRect)bounds
{
    NSRect titleRect = bounds;
    
    titleRect.origin.x += IMAGE_SIZE + (BORDER_SIZE * 2);
    titleRect.origin.y += BORDER_SIZE;
    
    NSAttributedString *title = [self attributedStringValue];
    if (title) {
        titleRect.size = [title size];
    } else {
        titleRect.size = NSZeroSize;
    }
    
    CGFloat maxX = NSMaxX(bounds);
    CGFloat maxWidth = maxX - NSMinX(titleRect);
    if (maxWidth < 0) {
        maxWidth = 0;
    }
    
    titleRect.size.width = MIN(NSWidth(titleRect), maxWidth);
    
    return titleRect;
}

- (NSRect)indicatorRectForBounds:(NSRect)bounds forTitleBounds:(NSRect)titleBounds
{
    NSRect indicatorRect = bounds;
    
    if (!indicator) {
        return NSZeroRect;
    }
    
    indicatorRect.origin.x = NSMinX(titleBounds);
    indicatorRect.origin.y = NSMaxY(titleBounds) + BORDER_SIZE;
    
    CGFloat amountPast = NSMaxX(indicatorRect) - NSMaxX(bounds);
    if (amountPast > 0) {
        indicatorRect.size.width -= amountPast;
    }
    
    return indicatorRect;
}



@end
