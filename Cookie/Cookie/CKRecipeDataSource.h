//
//  CKRecipeDataSource.h
//  Cookie
//
//  Created by Benjamin Lefebvre on 02/07/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKRecipe.h"
#import "CKRecipeCell.h"
#import "CKRecipeEditionViewController.h"

#define CKDidChange @"RecipeAdded"


@interface CKRecipeDataSource : NSObject <NSTableViewDataSource>

@property (retain) NSMutableArray *items;

- (void) addRecipeWithUniqueID:(NSString*)newUniqueID andName:(NSString*)newName andCategory:(NSNumber*)newCategory andPictureID:(NSString*)newPictureID andRating:(NSNumber*)newRating andSummary:(NSData*)newSummary andIngredients:(NSArray*)newIngredients;
- (void) deleteRecipeAtIndex:(NSInteger)row;
- (NSInteger) numberOfRowsInTableView:(NSTableView *) tableView;
-(id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex;
- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;
@end
