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
    }
    return self;
}

- (NSInteger) numberOfRowsInTableView:(NSTableView *) tableView {
    return [[self.ingredients objectAtIndex:0] count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
//    NSString* measure = [[ingredients objectAtIndex:0] objectAtIndex:row];
//    NSString* quantity = [[ingredients objectAtIndex:1] objectAtIndex:row];
//    [cell setTitle:quantity ofColumn:0];
//    [cell setTitle:measure ofColumn:1];
//    return self;
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
