//
//  CKRecipeDataSource.m
//  Cookie
//
//  Created by Benjamin Lefebvre on 02/07/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import "CKRecipeDataSource.h"

@implementation CKRecipeDataSource

@synthesize items;

- (id)init
{
    self = [super init];
    if (self) {
        self.items = [NSMutableArray array];
        
        NSData *data = [[NSData alloc] init];
        NSNumber *rating = [NSNumber numberWithInt:4];
        
        CKRecipe *recipe = [[CKRecipe alloc] initWithUniqueID:@"124332" andName:@"Yop" andCategory:rating andPictureID:@"1243" andRating:rating andSummary:data andIngredients:[NSArray arrayWithObject:@"Pomme"]];
        
        CKRecipe *recipe2 = [[CKRecipe alloc] initWithUniqueID:@"124332" andName:@"Yop" andCategory:rating andPictureID:@"1243" andRating:rating andSummary:data andIngredients:[NSArray arrayWithObject:@"Pomme"]];
        
        CKRecipe *recipe3 = [[CKRecipe alloc] initWithUniqueID:@"124332" andName:@"Yop" andCategory:rating andPictureID:@"1243" andRating:rating andSummary:data andIngredients:[NSArray arrayWithObject:@"Pomme"]];
        [items addObject:recipe];
        [items addObject:recipe2];
        [items addObject:recipe3];
    }
    return self;
}

- (void) addRecipeWithUniqueID:(NSString*)newUniqueID andName:(NSString*)newName andCategory:(NSNumber*)newCategory andPictureID:(NSString*)newPictureID andRating:(NSNumber*)newRating andSummary:(NSData*)newSummary andIngredients:(NSArray*)newIngredients {
    [self.items addObject:[[CKRecipe alloc] initWithUniqueID:newUniqueID andName:newName andCategory:newCategory andPictureID:newPictureID andRating:newRating andSummary:newSummary andIngredients:newIngredients]];
    [[NSNotificationCenter defaultCenter] postNotificationName:CKDidChange object:self];
}

- (void)deleteRecipeAtIndex:(NSInteger)row {
	[self.items removeObjectAtIndex:row];
    [[NSNotificationCenter defaultCenter] postNotificationName:CKDidChange object:self];
}

- (NSInteger) numberOfRowsInTableView:(NSTableView *) tableView {
    return [self.items count];
}

- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {

    CKRecipe *recipe = [self.items objectAtIndex:row];
    CKRecipeCell *recipeCell = (CKRecipeCell *)cell;

    [recipeCell setTitle:recipe.name];
    [recipeCell setRating:recipe.rating.stringValue];
    NSString *imgPath = [CKRecipeEditionViewController getPicturesPath];
    imgPath = [imgPath stringByAppendingString:recipe.pictureID];
    [recipeCell setImage:[[NSImage alloc] initWithContentsOfFile:imgPath]];
}

- (void)dealloc
{
    self.items = nil;
    [super dealloc];
}


@end
