//
//  CKIngredientDataSource.m
//  Cookie
//
//  Created by Irenicus on 02/07/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import "CKIngredientDataSource.h"

@implementation CKIngredientDataSource

@synthesize ingredients;

- (id)init
{
    self = [super init];
    if (self) {
        NSMutableArray* quantities = [[NSMutableArray alloc] init];
        NSMutableArray* measures = [[NSMutableArray alloc] init];
        self.ingredients = [[NSMutableArray alloc] initWithObjects:measures, quantities, nil ];
        [[ingredients objectAtIndex:0] addObject:@"q"];
        [[ingredients objectAtIndex:1] addObject:[NSNumber numberWithInteger:1]];
        
        [[ingredients objectAtIndex:0] addObject:@"f"];
        [[ingredients objectAtIndex:1] addObject:[NSNumber numberWithInteger:2]];
        
        [[ingredients objectAtIndex:0] addObject:@"w"];
        [[ingredients objectAtIndex:1] addObject:[NSNumber numberWithInteger:3]];
    }
    return self;
}

- (NSInteger) numberOfRowsInTableView:(NSTableView *) tableView {
    return [[self.ingredients objectAtIndex:0] count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn
            row:(NSInteger)rowIndex
{
    NSString *columnIdentifer = [aTableColumn identifier];
    if ([columnIdentifer isEqualToString:@"measure"]) {
        return [[ingredients objectAtIndex:0] objectAtIndex:rowIndex];
    }
    else
    {
        return [[ingredients objectAtIndex:1] objectAtIndex:rowIndex];
    }
}

- (void) addIngredientWithMeasure:(NSString*)measure andQuantity:(NSInteger)quantity
{
    NSLog(@"%@",@"test");
    NSLog(@"%@",measure);
    [[ingredients objectAtIndex:0] addObject:measure];
    [[ingredients objectAtIndex:1] addObject:[NSNumber numberWithInteger:quantity]];
}

- (void) deleteIngredientAtIndex:(NSInteger)row
{
    [[ingredients objectAtIndex:0] removeObjectAtIndex:row];
    [[ingredients objectAtIndex:1] removeObjectAtIndex:row];
    
}

- (void)dealloc
{
    ingredients = nil;
    [super dealloc];
}
@end
