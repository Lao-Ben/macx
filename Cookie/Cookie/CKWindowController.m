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

- (void) pushRecipeViewWithRecipe:(CKRecipe*)recipe
{
    CKRecipeViewController *recipeViewController = [[CKRecipeViewController alloc] initWithNibName:@"CKRecipeView" bundle:nil];    
    [self.window setContentView:[recipeViewController view]];
    [self showWindow:self];

    [recipeViewController setUpRecipeWithRecipe:recipe] ;

    
    
    //Test of the Display Recipe --- To Be Remove ---
    //    NSMutableArray* ingredients;
    //    NSMutableArray* quantities = [[NSMutableArray alloc] init];
    //    [quantities addObject:@"50"];
    //    NSMutableArray* measures = [[NSMutableArray alloc] init];
    //    [measures addObject:@"du bon gros choux"];
    //    ingredients = [[NSMutableArray alloc] initWithObjects:measures, quantities, nil ];
    //    
    //    
    //    NSData* data = [@"C'est bon et c'est pas cher" dataUsingEncoding:NSUTF8StringEncoding];
    //    [recipeViewController setUpRecipeWithName:@"Soupe aux Choux"
    //                  andCategory:[NSNumber numberWithInt:1]
    //                      andRate:[NSNumber numberWithInt:5]
    //                   andSummary:data
    //               andIngredients:ingredients
    //                   andPicture:@"193757280"];
}

- (void) pushAddView
{	  	
    CKRecipeEditionViewController *recipeEditionViewController = [[CKRecipeEditionViewController alloc] initWithNibName:@"CKRecipeEditionView" bundle:nil];    
	  	
    [self.window setContentView:[recipeEditionViewController view]];
	  	
    [self showWindow:self];
	  	
}

- (IBAction)pushEditionView:(id)sender {
    [self pushAddView];
}

- (void) pushRecipesView
{
    CKRecipesViewController *recipesViewController = [[CKRecipesViewController alloc] initWithNibName:@"CKRecipesView" bundle:nil];    
    [self.window setContentView:[recipesViewController view]];
    [self showWindow:self];
}

- (void) pushEditionViewWithRecipe:(CKRecipe*)recipe
{
    CKRecipeEditionViewController *recipeEditionViewController = [[CKRecipeEditionViewController alloc] initWithNibName:@"CKRecipeEditionView" bundle:nil];    
    [self.window setContentView:[recipeEditionViewController view]];
    [self showWindow:self];
    [recipeEditionViewController initViewWithRecipe:recipe] ;
}
@end
