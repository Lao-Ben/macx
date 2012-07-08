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
    }
    return self;
}

- (void) addRecipeWithUniqueID:(NSString*)newUniqueID andName:(NSString*)newName andCategory:(NSNumber*)newCategory andPictureID:(NSString*)newPictureID andRating:(NSNumber*)newRating andSummary:(NSData*)newSummary andIngredients:(NSArray*)newIngredients {
    [self.items addObject:[[CKRecipe alloc] initWithUniqueID:newUniqueID andName:newName andCategory:newCategory andPictureID:newPictureID andRating:newRating andSummary:newSummary andIngredients:newIngredients]];
    [[NSNotificationCenter defaultCenter] postNotificationName:CKDidChange object:self];
}

- (void) deleteRecipeAtIndex:(NSInteger)row {
	[self.items removeObjectAtIndex:row];
    [[NSNotificationCenter defaultCenter] postNotificationName:CKDidChange object:self];
}

- (NSInteger) numberOfRowsInTableView:(NSTableView *) tableView {
    return items.count;
}

- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row { 
    CKRecipeCell *recipeCell = (CKRecipeCell *)cell;
    CKAppDelegate *appDelegate = [NSApp delegate];
  
    for (CKRecipe *recipe in appDelegate.recipes.recipeArray) {
        if ([recipe.name isEqualToString:recipeCell.title]) {
            NSFileManager* fileMgr = [NSFileManager defaultManager];
            NSString* pathForPicture = [[CKAppDelegate getMiniaturePath] 
                                        stringByAppendingPathComponent:
                                        [NSString stringWithFormat:@"%@.jpeg",recipe.pictureID]
                                        ];
            BOOL pictureExists = [fileMgr fileExistsAtPath:pathForPicture];
            if (pictureExists) {
                NSImage *image = [[[NSImage alloc] initWithContentsOfFile:pathForPicture] retain];
                [recipeCell setImage:image];
            }
            [recipeCell setRating: recipe.rating.stringValue];
        }
    }
}

-(id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
    CKRecipe *recipe = [self.items objectAtIndex:rowIndex];
    CKRecipeCell *recipeCell = [[CKRecipeCell alloc] init];
    recipeCell.title = recipe.name;
    return recipeCell;
}

- (void)dealloc
{
    self.items = nil;
    [super dealloc];
}


@end
