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

@protocol searchProto <NSObject>    
-(void) changeSearchState;
@end

@interface CKWindowController : NSWindowController <searchProto>
- (IBAction)pushMainView:(id)sender;
- (IBAction)pushRecipesView:(id)sender;
@property (assign) IBOutlet NSSearchField *searchBar;

@end
