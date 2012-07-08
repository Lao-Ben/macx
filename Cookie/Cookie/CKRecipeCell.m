//
//  CKRecipeCell.m
//  Cookie
//
//  Created by Benjamin Lefebvre on 7/1/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import "CKRecipeCell.h"

@implementation CKRecipeCell

@synthesize image, rating;

- (id)copyWithZone:(NSZone *)zone
{
    CKRecipeCell *cell = [super copyWithZone:zone];
    if (cell == nil) {
        return nil;
    }
        
    // Clear the image and rating as they won't be retained
    cell->image = nil;
    cell->rating = nil;
    [cell setImage:[self image]];
    [cell setRating:[self rating]];
    
    return cell;
}

#define BORDER_SIZE 5
#define IMAGE_SIZE 64

- (NSAttributedString *)attributedRatingValue
{
    NSAttributedString *astr = nil;
    
    if (rating) {
        NSColor *textColour = [self isHighlighted] ? [NSColor lightGrayColor] : [NSColor grayColor];
        NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:textColour,
                               NSForegroundColorAttributeName, nil];
        astr = [[[NSAttributedString alloc] initWithString:rating attributes:attrs] autorelease];
    }
    
    return astr;
}

-(NSRect) ratingRectForBounds:(NSRect)bounds forTitleBounds:(NSRect)titleBounds
{
    NSRect ratingRect = bounds;
    
    if (!rating) {
        return NSZeroRect;
    }
    
    ratingRect.origin.x = NSMinX(titleBounds);
    ratingRect.origin.y = NSMaxY(titleBounds) + BORDER_SIZE;
    
    CGFloat amountPast = NSMaxX(ratingRect) - NSMaxX(bounds);
    if (amountPast > 0) {
        ratingRect.size.width -= amountPast;
    }
    return ratingRect;
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
  
    if (rating) {
        for (int i = 0, decal = 0; i < rating.intValue; i++, decal += 13) {
            NSRect ratingRect = [self ratingRectForBounds:cellFrame withDecal:[NSNumber numberWithInt:decal]];
            NSImage *starImage = [NSImage imageNamed:@"ico-star-grey.png"];
            [starImage drawInRect:ratingRect 
                         fromRect:NSZeroRect 
                        operation:NSCompositeSourceOver
                         fraction:1.0
                   respectFlipped:YES 
                            hints:nil];
        }
    }
    
//    NSRect ratingRect = [self ratingRectForBounds:cellFrame forTitleBounds:titleRect];
//    NSAttributedString *arating = [self attributedRatingValue];
//    if ([arating length] > 0) {
//        [arating drawInRect:ratingRect];
//        //NSImage *star = [NSImage imageNamed:@""];
//        
//    }
}

- (NSRect)imageRectForBounds:(NSRect)bounds
{
    NSRect imageRect = bounds;
    
    imageRect.origin.x += BORDER_SIZE;
    imageRect.origin.y += BORDER_SIZE;
    imageRect.size.width = IMAGE_SIZE;
    imageRect.size.height = IMAGE_SIZE;
    
    return imageRect;
}

- (NSRect)ratingRectForBounds:(NSRect)bounds withDecal:(NSNumber *)decal
{
    NSRect ratingRect = bounds;
    
    ratingRect.origin.x += BORDER_SIZE * 2 + IMAGE_SIZE + decal.doubleValue;
    ratingRect.origin.y += BORDER_SIZE + IMAGE_SIZE / 2;
    ratingRect.size.width = 12;
    ratingRect.size.height = 11;
    
    return ratingRect;
}

- (NSRect)titleRectForBounds:(NSRect)bounds
{
    NSRect titleRect = bounds;
    
    titleRect.origin.x += IMAGE_SIZE + (BORDER_SIZE * 2);
    titleRect.origin.y += BORDER_SIZE * 2;
    
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

@end
