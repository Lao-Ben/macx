//
//  CKAppDelegate.m
//  Cookie
//
//  Created by Benjamin Lefebvre on 6/28/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import "CKAppDelegate.h"

@implementation CKAppDelegate
@synthesize recipes;

- (void)dealloc
{
    [super dealloc];

}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [CKAppDelegate checkFoldersExistance];
    recipes = [[CKRecipes alloc] initWithDictionnary:[CKRecipesSerializer deserialize]];
    
    if (recipes.count <= 0) {
        NSData *data = [[NSData alloc] init];
        NSNumber *rating = [NSNumber numberWithInt:4];
        
        CKRecipe *recipe = [[CKRecipe alloc] initWithUniqueID:@"124332" andName:@"Entree 1" andCategory:[NSNumber numberWithInt:0] andPictureID:@"1243" andRating:rating andSummary:data andIngredients:[[NSArray arrayWithObject:@"Pomme"] retain]];
        
        CKRecipe *recipe2 = [[CKRecipe alloc] initWithUniqueID:@"124332" andName:@"Entree 2" andCategory:[NSNumber numberWithInt:0] andPictureID:@"1243" andRating:rating andSummary:data andIngredients:[[NSArray arrayWithObject:@"Pomme"] retain]];
        
        CKRecipe *recipe3 = [[CKRecipe alloc] initWithUniqueID:@"124332" andName:@"Plat 1" andCategory:[NSNumber numberWithInt:1] andPictureID:@"1243" andRating:rating andSummary:data andIngredients:[[NSArray arrayWithObject:@"Pomme"] retain]];
        
        CKRecipe *recipe4 = [[CKRecipe alloc] initWithUniqueID:@"124332" andName:@"Dessert 1" andCategory:[NSNumber numberWithInt:2] andPictureID:@"1243" andRating:rating andSummary:data andIngredients:[[NSArray arrayWithObject:@"Pomme"] retain]];
        [recipes add:recipe];
        [recipes add:recipe2];
        [recipes add:recipe3];
        [recipes add:recipe4];
    }
}

+ (NSString*) getApplicationPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *appSupportPath = [paths objectAtIndex:0];
    NSString *appName = [[NSRunningApplication currentApplication] localizedName];
    return [appSupportPath stringByAppendingPathComponent:appName];

}

+ (void) checkFoldersExistance
{
    NSString* miniaturePath = [CKAppDelegate getMiniaturePath];
    NSString* picturesPath = [CKAppDelegate getPicturesPath];
    NSString* applicationPath = [self getApplicationPath];
    
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    BOOL isMiniatureFolder = [fileMgr fileExistsAtPath:miniaturePath];
    BOOL isPictureFolder = [fileMgr fileExistsAtPath:picturesPath];
    BOOL isApplicationPath = [fileMgr fileExistsAtPath:applicationPath];
    
    if (!isApplicationPath)
    {
        [fileMgr createDirectoryAtPath:applicationPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    if (!isMiniatureFolder)
    {
        [fileMgr createDirectoryAtPath:miniaturePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    if (!isPictureFolder)
    {
        [fileMgr createDirectoryAtPath:picturesPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
}

+ (NSString*)getMiniaturePath { 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *appSupportPath = [paths objectAtIndex:0];
    NSString *appName = [[NSRunningApplication currentApplication] localizedName];
    return [[appSupportPath stringByAppendingPathComponent:appName]stringByAppendingPathComponent:@"Miniatures"];
}

+ (NSString*)getPicturesPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *appSupportPath = [paths objectAtIndex:0];
    NSString *appName = [[NSRunningApplication currentApplication] localizedName];
    return [[appSupportPath stringByAppendingPathComponent:appName]stringByAppendingPathComponent:@"Pictures"];
}

@end
