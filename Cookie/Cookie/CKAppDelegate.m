//
//  CKAppDelegate.m
//  Cookie
//
//  Created by Benjamin Lefebvre on 6/28/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import "CKAppDelegate.h"

@implementation CKAppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  /*  
    NSNumber *rating = [NSNumber numberWithInt:4];
    NSData *data = [[NSData alloc] init];
    CKRecipes *recipes = [[CKRecipes alloc] init];
    CKRecipe *recipe = [[CKRecipe alloc] initWithName:@"" andCategory:rating andPictureID:@"" andRating:rating andSummary:data andIngredients:[NSArray arrayWithObject:@""]];
    [recipes addObject:recipe];
    
    [CKRecipesSerializer serialize:[recipes toDictionnary]];
    
    NSDictionary *dict = [CKRecipesSerializer deserialize];
    NSLog(@"count: %lu", dict.count);
   */
}

@end
