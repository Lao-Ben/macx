//
//  CKRecipes.h
//  Cookie
//
//  Created by Benjamin Lefebvre on 6/29/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKRecipe.h"

@interface CKRecipes : NSObject {
    NSMutableArray *recipeArray;
}

- (id)init;
- (id)initWithDictionnary:(NSDictionary*)recipes;
- (void)add:(CKRecipe*)recipe;
- (NSDictionary*) toDictionnary;

@end
