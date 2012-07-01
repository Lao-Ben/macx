//
//  CKRecipeEditionViewController.h
//  Cookie
//
//  Created by Benjamin Lefebvre on 7/1/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CKRecipeEditionViewController : NSViewController 

@property (assign) IBOutlet NSTextField *nameField;
@property (assign) IBOutlet NSTextField *categoryField;
@property (assign) IBOutlet NSLevelIndicator *ratingIndicator;
@property (assign) IBOutlet NSTextView *summaryField;
@property (assign) IBOutlet NSTableView *ingredientsTable;
@property (assign) IBOutlet NSImageView *imageView;
- (IBAction)choosePictureDialog:(id)sender;
+ (NSString*)getMiniaturePath;
+ (NSString*)getPicturesPath;
@end
