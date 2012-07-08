//
//  CKWindowController.h
//  Cookie
//
//  Created by Benjamin Lefebvre on 7/1/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CKRecipes.h"
#import "CKRecipesSerializer.h"
#import "CKMainViewController.h"
#import "CKRecipesViewController.h"
#import "CKRecipeEditionViewController.h"
#import "CKRecipeViewController.h"

@interface CKWindowController : NSWindowController
- (IBAction)pushMainView:(id)sender;
- (IBAction)pushRecipesView:(id)sender;
- (IBAction)pushEditionView:(id)sender;
- (void) pushRecipesView;
- (void) pushEditionView;
- (void) pushAddView;
- (void) pushRecipeViewWithRecipe:(CKRecipe*)recipe;
- (void) pushEditionViewWithRecipe:(CKRecipe*)recipe;
@end
