//
//  CKRecipesViewController.h
//  Cookie
//
//  Created by Benjamin Lefebvre on 6/30/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CKWindowController.h"
#import "CKRecipeDataSource.h"

@interface CKRecipesViewController : NSViewController
@property (assign) IBOutlet NSTabView *tabView;
@property (assign) IBOutlet NSTableView *platsTable;
@property (assign) IBOutlet NSTableView *entreesTable;
@property (assign) IBOutlet NSTableView *dessertsTable;
@property (assign) IBOutlet NSSearchField *searchField;
@property (assign) IBOutlet NSButton *suppressButton;

-(IBAction)updateFilter:sender;
-(IBAction)deleteRecipes:sender;
- (void)doubleClick:(id)aTableView;
- (void)fillTables;
- (void) didDeletionAlert:(NSAlert*)alert returnCode:(int)button;
@end
