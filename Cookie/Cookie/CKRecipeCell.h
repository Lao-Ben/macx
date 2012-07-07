//
//  CKRecipeCell.h
//  Cookie
//
//  Created by Benjamin Lefebvre on 7/1/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "CKRecipe.h"

@interface CKRecipeCell : NSTextFieldCell {
    NSImage *image;
    NSString *rating;
}

@property (readwrite, retain) NSImage *image;
@property (readwrite, copy) NSString *rating;

@end
