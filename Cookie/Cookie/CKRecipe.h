//
//  CKRecipe.h
//  Cookie
//
//  Created by Benjamin Lefebvre on 6/28/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CKRecipe : NSObject {
    NSString *uniqueID;
    NSString *name;
    NSNumber *category;
    NSString *pictureID;
    NSNumber *rating;
    NSData *summary;
    NSArray *ingredients;
}

@property (nonatomic, retain) NSString *uniqueID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *category;
@property (nonatomic, retain) NSString *pictureID;
@property (nonatomic, retain) NSNumber *rating;
@property (nonatomic, retain) NSData *summary;
@property (nonatomic, retain) NSArray *ingredients;

- (id) initWithUniqueID:(NSString*)newUniqueID andName:(NSString*)newName andCategory:(NSNumber*)newCategory andPictureID:(NSString*)newPictureID andRating:(NSNumber*)newRating andSummary:(NSData*)newSummary andIngredients:(NSArray*)newIngredients;

- (id)copyWithZone:(NSZone *)zone;

@end
