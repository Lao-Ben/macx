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
           // NSLog(@"deserialize name : %@", recipe.name);
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
    for (CKRecipe *recipe in recipeArray) {
        if (recipe.category.intValue == category) {
            [recipes addObject:recipe];
        }
    }
    return [recipes retain];
}

- (CKRecipe*) recipeOfTheDay {
    if (recipeArray.count <= 0) {
        return nil;
    }
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    int time = year + month + day; 
    int rand = (time % recipeArray.count);
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
                //Probleme
                NSString *ingredientAtIndexK = [[ingredientsInRecipe objectAtIndex:1] objectAtIndex:k];
                ingredientAtIndexK = [ingredientAtIndexK lowercaseString];
                //CECI NEST PAS UNE STRING
                NSRange range = [ingredientAtIndexK rangeOfString:[[ingredients objectAtIndex:j] lowercaseString]];
            
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
    return recipes;
}

- (NSDictionary*)toDictionnary
{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for (CKRecipe *recipe in recipeArray) {
        NSLog(@"recipe: %@",recipe.name);
        
        NSArray *keys = [NSArray arrayWithObjects:@"UniqueID", @"Name", @"Category", @"PictureID", @"Rating", @"Summary", @"Ingredients", nil];
        NSArray *values = [NSArray arrayWithObjects:recipe.uniqueID, recipe.name, recipe.category, recipe.pictureID, recipe.rating, recipe.summary, recipe.ingredients, nil];
        
       // NSLog(@"recipe: %@ nbKeys: %lu nbValues: %lu",recipe.name, keys.count, values.count);
        
        NSDictionary *recipeDict = [NSDictionary dictionaryWithObjects:values forKeys: keys]; 
        [tempArray addObject:recipeDict];
    }
    return [[NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: tempArray, nil] forKeys:[NSArray arrayWithObjects: @"Recipes", nil]] autorelease];
    [tempArray release];
}


+ (NSMutableArray*) orderByRating:(NSMutableArray *)recipes {

    NSString * SORT_FIELD = @"rating";
    
    NSSortDescriptor *lastDescriptor =
    [[[NSSortDescriptor alloc]
      initWithKey:SORT_FIELD
      ascending:NO
      selector:@selector(compare:)] autorelease];
    
    NSArray * descriptors = [NSArray arrayWithObjects:lastDescriptor, nil];
    NSArray * sortedArray = [recipes sortedArrayUsingDescriptors:descriptors];
    
    return [NSMutableArray arrayWithArray:sortedArray];
}

+ (NSMutableArray*) orderById:(NSMutableArray *)recipes {
    
    NSString * SORT_FIELD = @"uniqueID";
    
    NSSortDescriptor *lastDescriptor =
    [[[NSSortDescriptor alloc]
      initWithKey:SORT_FIELD
      ascending:NO
      selector:@selector(compare:)] autorelease];
    
    NSArray * descriptors = [NSArray arrayWithObjects:lastDescriptor, nil];
    NSArray * sortedArray = [recipes sortedArrayUsingDescriptors:descriptors];
    
    return [NSMutableArray arrayWithArray:sortedArray];
}
@end
