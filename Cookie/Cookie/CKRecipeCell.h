//
//  CKRecipeCell.h
//  Cookie
//
//  Created by Benjamin Lefebvre on 7/1/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CKRecipeCell : NSTextFieldCell {
    NSImage *image;
    NSLevelIndicator *indicator;
}

@property (assign) IBOutlet NSImage *image;
@property (assign) IBOutlet NSLevelIndicator *indicator;

@end
