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
            CKRecipe *recipe = [[CKRecipe alloc] initWithUniqueID:[[recipeDict objectForKey:@"UniqueID"] retain] andName:[[recipeDict objectForKey:@"Name"] retain] andCategory:[[recipeDict objectForKey:@"Category"] retain] andPictureID:[[recipeDict objectForKey:@"PictureID"] retain] andRating:[[recipeDict objectForKey:@"Rating"] retain] andSummary:[[recipeDict objectForKey:@"Summary"] retain] andIngredients:[[recipeDict objectForKey:@"Ingredients"] retain]];
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
    NSDictionary* dict = [self toDictionnary];
    [CKRecipesSerializer serialize:dict];
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
    int rand = (int)(arc4random() % recipeArray.count - 1);
    return [recipeArray objectAtIndex:rand];
}

- (NSMutableArray*) recipesInCategory:(NSUInteger)category withIngredients:(NSArray*)ingredients
{
    NSMutableArray *recipes = [self recipesInCategory:category];
    
    for (NSInteger i = [recipes count] - 1; i >= 0; i--)
    {
        CKRecipe *recipe = [recipes objectAtIndex:i];
        NSArray *ingredientsInRecipe = [recipe ingredients];
        NSInteger countIngredients = [ingredientsInRecipe count];
        
        for (int j = 0; j < [ingredients count]; j++)
        {
            BOOL present = NO;
            for(int k = 0; k < countIngredients; k++)
            {
                NSRange range = [[[ingredients objectAtIndex:k] lowercaseString] rangeOfString:[[ingredients objectAtIndex:j] lowercaseString]];
            
                if (range.location != NSNotFound)
                {
                    present = YES;
                    break;
                }
            }
            if (!present)
            {
                [recipes removeObjectAtIndex:i];
                break;
            }
        }
    }
    return [CKRecipes orderByRating:recipes];
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
    NSMutableArray *sortedArray = [[NSMutableArray alloc] initWithCapacity:[recipes count]];

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
