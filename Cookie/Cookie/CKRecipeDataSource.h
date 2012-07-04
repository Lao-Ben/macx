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


@interface CKRecipeDataSource : NSObject

@property (retain) NSMutableArray *items;

- (void) addRecipeWithUniqueID:(NSString*)newUniqueID andName:(NSString*)newName andCategory:(NSNumber*)newCategory andPictureID:(NSString*)newPictureID andRating:(NSNumber*)newRating andSummary:(NSData*)newSummary andIngredients:(NSArray*)newIngredients;
- (void) deleteRecipeAtIndex:(NSInteger)row;

@end
