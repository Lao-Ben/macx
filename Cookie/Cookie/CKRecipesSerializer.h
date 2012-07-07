//
//  CKRecipesSerializer.h
//  Cookie
//
//  Created by Benjamin Lefebvre on 6/28/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CKRecipesSerializer : NSObject

+ (void)serialize:(NSDictionary*)recipes;
+ (NSDictionary*)deserialize;
+ (NSString*)getPListPath;
@end
