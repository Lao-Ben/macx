//
//  CKRecipesSerializer.m
//  Cookie
//
//  Created by Benjamin Lefebvre on 6/28/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import "CKRecipesSerializer.h"

@implementation CKRecipesSerializer

+ (void)serialize:(NSDictionary*)recipes {
    
    NSString *error = nil;
    
    // create NSData from dictionary
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:recipes format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
    
    // check is plistData exists
    if(plistData) {
        // write plistData to our Data.plist file
        NSLog(@"path: %@", [self getPListPath]);
        [plistData writeToFile:[self getPListPath] atomically:YES];
    } else {
        NSLog(@"Error in serialization: %@", error);
        [error release];
    }
}

+ (NSDictionary*)deserialize {
    
    NSString *plistPath = [self getPListPath];
    
    // check to see if recipes plist exists in documents
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
        return nil;
     
    // read property list into memory as an NSData object
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    // convert static property list into dictionary object
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    if (!temp) {
        NSLog(@"Error in deserialization: %@", errorDesc);
        return nil;
    } else {
        return temp;
    }
}

+ (NSString*)getPListPath {
    // find the path to ~/Library/Application Support/    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    // get the Application Support path
    NSString *appSupportPath = [paths objectAtIndex:0];
    NSString *appName = [[NSRunningApplication currentApplication] localizedName];
    appSupportPath = [appSupportPath stringByAppendingPathComponent:appName];
    // get the path to the recipes data file
    return [appSupportPath stringByAppendingPathComponent:@"Recipes.plist"];
}

@end
