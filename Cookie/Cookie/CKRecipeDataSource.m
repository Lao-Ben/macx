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
        CKRecipe *recipe = [[CKRecipe alloc] initWithUniqueID:@"124332" andName:@"DataSource error" andCategory:[NSNumber numberWithInt:0] andPictureID:@"1243" andRating:rating andSummary:data andIngredients:[[NSArray arrayWithObject:@"Pomme"] retain]];
        [items addObject:recipe];
    }
    return self;
}

- (void) addRecipeWithUniqueID:(NSString*)newUniqueID andName:(NSString*)newName andCategory:(NSNumber*)newCategory andPictureID:(NSString*)newPictureID andRating:(NSNumber*)newRating andSummary:(NSData*)newSummary andIngredients:(NSArray*)newIngredients {
    [self.items addObject:[[CKRecipe alloc] initWithUniqueID:newUniqueID andName:newName andCategory:newCategory andPictureID:newPictureID andRating:newRating andSummary:newSummary andIngredients:newIngredients]];
    [[NSNotificationCenter defaultCenter] postNotificationName:CKDidChange object:self];
    NSLog(@"datasource size : %li", items.count);
}

- (void) deleteRecipeAtIndex:(NSInteger)row {
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
    NSString *imgPath = [CKAppDelegate getPicturesPath];
    imgPath = [imgPath stringByAppendingString:recipe.pictureID];
    [recipeCell setImage:[[NSImage alloc] initWithContentsOfFile:imgPath]];
}

- (void)dealloc
{
    self.items = nil;
    [super dealloc];
}


@end
