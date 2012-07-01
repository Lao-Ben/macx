//
//  CKRecipeEditionViewController.h
//  Cookie
//
//  Created by Benjamin Lefebvre on 7/1/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CKRecipeDialogWindowController.h"

@interface CKRecipeEditionViewController : NSViewController 

@property (assign) IBOutlet NSTextField *nameField;
@property (assign) IBOutlet NSComboBoxCell *categoryField;
@property (assign) IBOutlet NSLevelIndicator *ratingIndicator;
@property (assign) IBOutlet NSTextView *summaryField;
@property (assign) IBOutlet NSTableView *ingredientsTable;
@property (assign) IBOutlet NSImageView *imageView;
@property (assign) IBOutlet NSButton *addButton;
- (IBAction)choosePictureDialog:(id)sender;
- (IBAction)addIngredient:(id)sender;
+ (NSString*)getMiniaturePath;
+ (NSString*)getPicturesPath;
@end
