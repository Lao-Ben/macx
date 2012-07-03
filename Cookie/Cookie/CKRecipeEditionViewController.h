//
//  CKRecipeEditionViewController.h
//  Cookie
//
//  Created by Benjamin Lefebvre on 7/1/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CKRecipeEditionViewController : NSViewController <NSTableViewDataSource>
{
    NSMutableArray *ingredients;
}

//Properties

@property (retain) NSMutableArray *ingredients;
@property (assign) IBOutlet NSTextField *quantity;
@property (assign) IBOutlet NSTextField *measure;
@property (assign) IBOutlet NSTextField *nameField;
@property (assign) IBOutlet NSComboBoxCell *categoryField;
@property (assign) IBOutlet NSLevelIndicator *ratingIndicator;
@property (assign) IBOutlet NSTextView *summaryField;
@property (assign) IBOutlet NSImageView *imageView;
@property (assign) IBOutlet NSButton *addButton;
@property (assign) IBOutlet NSTableView *ingredientsTable;
@property (assign) IBOutlet NSButton *addIngredientButton;
@property (assign) IBOutlet NSButton *removeIngredientButton;

//Actions
- (IBAction)addIngredientAction:(id)sender;
- (IBAction)removeIngredientAction:(id)sender;


//Methods

- (void) addIngredientWithMeasure:(NSString*)measureString andQuantity:(NSInteger)quantityInteger;
- (void) deleteIngredientAtIndex:(NSInteger)row;
- (IBAction)choosePictureDialog:(id)sender;
+ (NSString*)getMiniaturePath;
+ (NSString*)getPicturesPath;
@end
