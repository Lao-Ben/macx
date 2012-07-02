//
//  CKRecipeDialogWindowController.h
//  Cookie
//
//  Created by Irenicus on 01/07/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CKRecipeEditionViewController.h"
#import "CKIngredientDataSource.h"

@interface CKRecipeDialogWindowController : NSWindowController
{
    NSTableView* ingredients;
}
@property (assign) IBOutlet NSTextField *measure;
@property (assign) IBOutlet NSTextField *quantity;
@property (assign) IBOutlet NSButton *addIngredient;
- (IBAction)didAddIngredient:(id)sender;
- (id)initWithWindowNibName:(NSString *)windowNibPath
                      owner:(id)owner
        andIngredientsTable:(NSTableView*)ingredientsTable;
@end
