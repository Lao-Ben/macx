//
//  CKRecipeViewController.h
//  Cookie
//
//  Created by Benjamin Lefebvre on 6/30/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CKAppDelegate.h"
#import "CKWindowController.h"
#import "CKRecipeEditionViewController.h"

@interface CKRecipeViewController : NSViewController
{
    CKRecipe* currentRecipe;
    NSArray *ingredientsArray;
    NSInteger numberOfGuest;
    NSInteger prevNumberOfGuest;
}

//Properties

@property (retain) NSArray *ingredientsArray;
@property (assign) IBOutlet NSTextField *recipeTitle;
@property (assign) IBOutlet NSTextField *recipeCategory;
@property (assign) IBOutlet NSPopUpButton *guestSelector;
@property (assign) IBOutlet NSTextView *instructionsSummary;
@property (assign) IBOutlet NSTableView *ingredientsTable;
@property (assign) IBOutlet NSImageView *recipeImage;
@property (assign) IBOutlet NSLevelIndicator *recipeRate;
@property (assign) IBOutlet NSButton *editButton;

- (IBAction)editAction:(id)sender;

// Methods
- (IBAction)ratingChanged:(id)sender;

- (void) setUpRecipeWithRecipe:(CKRecipe*) recipe;
- (void) initItemGuests;
- (void) itemOfMenuDidChange:(NSNotification *)notification;

@end
