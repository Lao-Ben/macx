//
//  CKAppDelegate.h
//  Cookie
//
//  Created by Benjamin Lefebvre on 6/28/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CKRecipeEditionViewController.h"
#import "CKRecipes.h"
#import "CKRecipesSerializer.h"

@interface CKAppDelegate : NSObject <NSApplicationDelegate>
@property (retain) CKRecipes *recipes;
+ (void) checkFoldersExistance;
+ (NSString*) getApplicationPath;
@end
