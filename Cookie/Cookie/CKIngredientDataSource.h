//
//  CKIngredientDataSource.h
//  Cookie
//
//  Created by Irenicus on 02/07/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CKIngredientDataSource : NSObject <NSTableViewDataSource>
{
    NSMutableArray *ingredients;
}
@property (retain) NSMutableArray *ingredients;
- (void) addIngredientWithMeasure:(NSString*)measure andQuantity:(NSInteger)quantity;
- (void) deleteIngredientAtIndex:(NSInteger)row;
@end
