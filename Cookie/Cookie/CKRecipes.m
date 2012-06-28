//
//  CKRecipes.m
//  Cookie
//
//  Created by Benjamin Lefebvre on 6/29/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import "CKRecipes.h"

@implementation CKRecipes

- (NSDictionary*)toDictionnary {
    NSMutableArray *recipesArray = [[NSMutableArray alloc] init];
    
    for (CKRecipe *recipe in self) {
        NSDictionary *recipeDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: recipe.uniqueID, recipe.name, recipe.category, recipe.pictureID, recipe.rating, recipe.summary, recipe.ingredients nil] forKeys: [NSArray arrayWithObjects: @"UniqueID", @"Name", @"Category", @"PictureID", @"Rating", @"Summary", @"Ingredients"]]; 
        [recipesArray addObject:recipeDict];
    }
    
    return [[NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: recipesArray, nil] forKeys:[NSArray arrayWithObjects: @"Recipes", nil]] autorelease];
    
}

@end
