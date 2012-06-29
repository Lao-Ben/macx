//
//  CKRecipe.m
//  Cookie
//
//  Created by Benjamin Lefebvre on 6/28/12. 
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import "CKRecipe.h"

@implementation CKRecipe

@synthesize uniqueID, name, category, pictureID, rating, summary, ingredients;

- (id) initWithName:(NSString*)newName andCategory:(NSNumber*)newCategory andPictureID:(NSString*)newPictureID andRating:(NSNumber*)newRating andSummary:(NSData*)newSummary andIngredients:(NSArray*)newIngredients {
	self = [super init];
    name = newName;
    category = newCategory;
    pictureID = newPictureID;
    rating = newRating;
    summary = newSummary;
    ingredients = newIngredients;
    return self;
}

@end
