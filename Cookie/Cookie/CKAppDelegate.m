//
//  CKAppDelegate.m
//  Cookie
//
//  Created by Benjamin Lefebvre on 6/28/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import "CKAppDelegate.h"

@implementation CKAppDelegate

- (void)dealloc
{
    [super dealloc];

}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [CKAppDelegate checkFoldersExistance];
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
    NSString* miniaturePath = [CKRecipeEditionViewController getMiniaturePath];
    NSString* picturesPath = [CKRecipeEditionViewController getPicturesPath];
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

@end
