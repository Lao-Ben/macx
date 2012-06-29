//
//  CKRecipes.m
//  Cookie
//
//  Created by Benjamin Lefebvre on 6/29/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import "CKRecipes.h"

@implementation CKRecipes

- (id)init
{
    self = [super init];
    if (self) {
        recipeArray = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)dealloc
{
    [recipeArray release];
    [super dealloc];
}

- (void)add:(CKRecipe*)recipe {
    [recipeArray addObject:recipe];
}

- (NSDictionary*)toDictionnary {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for (CKRecipe *recipe in recipeArray) {
        NSLog(@"recipe: %@",recipe.name);
        
        NSArray *keys = [NSArray arrayWithObjects:@"UniqueID", @"Name", @"Category", @"PictureID", @"Rating", @"Summary", @"Ingredients", nil];
        NSArray *values = [NSArray arrayWithObjects:recipe.uniqueID, recipe.name, recipe.category, recipe.pictureID, recipe.rating, recipe.summary, recipe.ingredients, nil];
        
        NSLog(@"recipe: %@ nbKeys: %lu nbValues: %lu",recipe.name, keys.count, values.count);
        
        NSDictionary *recipeDict = [NSDictionary dictionaryWithObjects:values forKeys: keys]; 
        [tempArray addObject:recipeDict];
    }
    return [[NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: tempArray, nil] forKeys:[NSArray arrayWithObjects: @"Recipes", nil]] autorelease];
    [tempArray release];
}

@end
