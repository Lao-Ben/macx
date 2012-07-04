//
//  CKRecipes.m
//  Cookie
//
//  Created by Benjamin Lefebvre on 6/29/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import "CKRecipes.h"

@implementation CKRecipes

@synthesize recipeArray;

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
            NSLog(@"deserialize name : %@", recipe.name);
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

- (NSUInteger) count {
    return recipeArray.count;
}

- (NSMutableArray*) recipesInCategory:(NSUInteger)category {
    NSMutableArray *recipes = [[NSMutableArray alloc] init];
    NSLog(@"inCategory");
    for (CKRecipe *recipe in recipeArray) {
        if (recipe.category.intValue == category) {
            NSLog(@"added recipe");
            [recipes addObject:recipe];
        }
    }
    NSLog(@"cpt recipes : %li", recipes.count);

    return [recipes retain];
}

- (CKRecipe*) recipeOfTheDay {
    if (recipeArray.count <= 0) {
        return nil;
    }
    int rand = (arc4random() % recipeArray.count - 1);
    return [recipeArray objectAtIndex:rand];
}

- (NSMutableArray*) recipesWithIngredients:(NSArray*)ingredients {
    NSMutableArray *recipes = [[NSMutableArray alloc] init];

    // FIXME: ..............
    
    return recipes;
}

- (NSMutableArray*) recipesInCategory:(NSUInteger)category withIngredients:(NSArray*)ingredients {
    NSMutableArray *recipes = [self recipesInCategory:category];
    
    // FIXME: ..............
    
    return recipes;
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


+ (NSMutableArray*) orderByRating:(NSMutableArray *)recipes {
    NSMutableArray *sortedArray = [NSMutableArray alloc];

    [sortedArray arrayByAddingObjectsFromArray: [recipes sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSNumber *first = [(CKRecipe*)a rating];
        NSNumber *second = [(CKRecipe*)b rating];
        return -[first compare:second];
    }] ];
    
    return sortedArray;
}

+ (NSMutableArray*) orderById:(NSMutableArray *)recipes {
    NSMutableArray *sortedArray = [NSMutableArray alloc];
    
    [sortedArray arrayByAddingObjectsFromArray: [recipes sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSNumber *first = [NSNumber numberWithInteger: [[(CKRecipe*)a uniqueID] integerValue]];
        NSNumber *second =[NSNumber numberWithInteger: [[(CKRecipe*)b uniqueID] integerValue]];
        return [first compare:second];
    }] ];
    
    return sortedArray;
}
@end
