//
//  CKRecipes.h
//  Cookie
//
//  Created by Benjamin Lefebvre on 6/29/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKRecipe.h"
#import "CKRecipesSerializer.h"

@interface CKRecipes : NSObject {
    NSMutableArray *recipeArray;
}

@property (retain) NSMutableArray *recipeArray;

- (id)initWithDictionnary:(NSDictionary*)recipes;
- (void)add:(CKRecipe*)recipe;
- (NSUInteger) count;
- (NSMutableArray*) recipesInCategory:(NSUInteger)category;
- (CKRecipe*) recipeOfTheDay;
- (NSMutableArray*) recipesInCategory:(NSUInteger)category withIngredients:(NSArray*)ingredients;
- (NSDictionary*) toDictionnary;

+ (NSMutableArray*) orderByRating:(NSMutableArray*)recipes;
+ (NSMutableArray*) orderById:(NSMutableArray*)recipes;

@end
