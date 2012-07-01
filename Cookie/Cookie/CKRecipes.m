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

- (id)initWithDictionnary:(NSDictionary*)dictionnary {
    self = [super init];
    if (self) {
        recipeArray = [[NSMutableArray alloc] init];
        NSArray *array = [dictionnary objectForKey:@"Recipes"];
        for (NSDictionary *recipeDict in array) {
            CKRecipe *recipe = [[CKRecipe alloc] initWithUniqueID:[recipeDict objectForKey:@"UniqueID"] andName:[recipeDict objectForKey:@"Name"] andCategory:[recipeDict objectForKey:@"Category"] andPictureID:[recipeDict objectForKey:@"PictureID"] andRating:[recipeDict objectForKey:@"Rating"] andSummary:[recipeDict objectForKey:@"Summary"] andIngredients:[recipeDict objectForKey:@"Ingredients"]];
            [recipeArray addObject:recipe];
        }
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

- (NSDictionary*)toDictionnary
{
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
