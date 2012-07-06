//
//  CKWindowController.m
//  Cookie
//
//  Created by Benjamin Lefebvre on 7/1/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import "CKWindowController.h"

@interface CKWindowController ()

@end

@implementation CKWindowController

- (void)windowDidLoad
{   
    [super windowDidLoad];
}

- (void) awakeFromNib {    
 /*   
    NSNumber *rating = [NSNumber numberWithInt:4];
    NSData *data = [[NSData alloc] init];
    CKRecipes *recipes = [[CKRecipes alloc] init];
    CKRecipe *recipe = [[CKRecipe alloc] initWithUniqueID:@"124332" andName:@"Yop" andCategory:rating andPictureID:@"1243" andRating:rating andSummary:data andIngredients:[NSArray arrayWithObject:@"Pomme"]];
    [recipes add:recipe];
    
    
    NSDictionary* dict = [recipes toDictionnary];
    [CKRecipesSerializer serialize:dict];
    NSLog(@"SERIALIZED");
    
    NSDictionary *dict2 = [CKRecipesSerializer deserialize];
    
  //  CKRecipes *recipes2 = [[CKRecipes alloc] initWithDictionnary:dict2];
    
    NSLog(@"count: %lu", dict2.count);
   */
    
    CKMainViewController *mainViewController = [[CKMainViewController alloc] initWithNibName:@"CKMainView" bundle:nil];
    
    [self.window setContentView:[mainViewController view]];
    [self showWindow:self];
    
}
- (IBAction)pushMainView:(id)sender {
    CKMainViewController *mainViewController = [[CKMainViewController alloc] initWithNibName:@"CKMainView" bundle:nil];    
    [self.window setContentView:[mainViewController view]];
    [self showWindow:self];

}

- (IBAction)pushRecipesView:(id)sender {
    [self pushRecipesView];
}

- (IBAction)pushRecipeEditionView:(id)sender {
    [self pushEditionView];
}

- (void) pushRecipesView
{
    CKRecipesViewController *recipesViewController = [[CKRecipesViewController alloc] initWithNibName:@"CKRecipesView" bundle:nil];    
    [self.window setContentView:[recipesViewController view]];
    [self showWindow:self];
}

- (void) pushEditionView
{
    CKRecipeEditionViewController *recipeEditionViewController = [[CKRecipeEditionViewController alloc] initWithNibName:@"CKRecipeEditionView" bundle:nil];    
    [self.window setContentView:[recipeEditionViewController view]];
    [self showWindow:self];
}

@end
