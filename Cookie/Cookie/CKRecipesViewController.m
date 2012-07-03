//
//  CKRecipesViewController.m
//  Cookie
//
//  Created by Benjamin Lefebvre on 6/30/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import "CKRecipesViewController.h"

@interface CKRecipesViewController ()

@end

@implementation CKRecipesViewController
@synthesize tabView;
@synthesize platsTable;
@synthesize entreesTable;
@synthesize dessertsTable;
@synthesize searchField;
@synthesize numberOfCharacters;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"RecipesView loaded");
    }
    self.numberOfCharacters = 0;
    return self;
}

-(IBAction)updateFilter:(id)sender
{
    NSString *filter = [searchField stringValue];
    NSArray *tab = [filter componentsSeparatedByString:@" "];
    NSString *tabSelected = [[tabView selectedTabViewItem] label];
    NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString: filter];
    NSInteger *numberOfCharactersInFilter = [myCharSet count];
    
    if (numberOfCharactersInFilter >= numberOfCharacters)
    {
        if ([tabSelected isEqualToString:@"Entrées"])
        {
            NSLog(@"Entrées");
            CKRecipeDataSource *dataSource = [entreesTable dataSource];
            NSInteger numberOfItems = [dataSource.items count];
        
            for (int i = numberOfItems - 1; i >= 0; i--)
            {
                //NSLog([NSString stringWithFormat:@"%d", i]);
                CKRecipe *recipe = [dataSource.items objectAtIndex:i];
                NSArray *ingredients = recipe.ingredients;
                NSUInteger count = [ingredients count];
                
                for (int j = 0; j < [tab count]; j++)
                {
                    BOOL present = NO;
                    for(int k = 0; k < count; k++)
                    {
                        NSRange range = [[[ingredients objectAtIndex:k] lowercaseString] rangeOfString:[[tab objectAtIndex:j] lowercaseString]];
                        
                        if (range.location != NSNotFound)
                            present = YES;
                    }
                    if (!present)
                    {
                        [dataSource deleteRecipeAtIndex:i];
                        break;
                    }
                }
            }
            entreesTable.dataSource = (id<NSTableViewDataSource>)dataSource;
            [entreesTable reloadData];
        }
        else if ([tabSelected isEqualToString:@"Plats"])
        {
            NSLog(@"Plats");
            CKRecipeDataSource *dataSource = [platsTable dataSource];
        
            for (int i = 0; i < [dataSource.items count]; i++)
            {
                //NSLog([NSString stringWithFormat:@"%d", i]);
                CKRecipe *recipe = [dataSource.items objectAtIndex:i];
                NSArray *ingredients = recipe.ingredients;
                NSUInteger count = [ingredients count];
                
                for (int j = 0; j < [tab count]; j++)
                {
                    BOOL present = NO;
                    for(int k = 0; k < count; k++)
                    {
                        NSRange range = [[[ingredients objectAtIndex:k] lowercaseString] rangeOfString:[[tab objectAtIndex:j] lowercaseString]];
                        
                        if (range.location != NSNotFound)
                            present = YES;
                    }
                    if (!present)
                    {
                        [dataSource deleteRecipeAtIndex:i];
                        break;
                    }
                }
            }
            platsTable.dataSource = (id<NSTableViewDataSource>)dataSource;
            [platsTable reloadData];
        }
        else
        {
            NSLog(@"Desserts");
            CKRecipeDataSource *dataSource = [dessertsTable dataSource];
        
            for (int i = 0; i < [dataSource.items count]; i++)
            {
                //NSLog([NSString stringWithFormat:@"%d", i]);
                CKRecipe *recipe = [dataSource.items objectAtIndex:i];
                NSArray *ingredients = recipe.ingredients;
                NSUInteger count = [ingredients count];
                
                for (int j = 0; j < [tab count]; j++)
                {
                    BOOL present = NO;
                    for(int k = 0; k < count; k++)
                    {
                        NSRange range = [[[ingredients objectAtIndex:k] lowercaseString] rangeOfString:[[tab objectAtIndex:j] lowercaseString]];
                        
                        if (range.location != NSNotFound)
                            present = YES;
                    }
                    if (!present)
                    {
                        [dataSource deleteRecipeAtIndex:i];
                        break;
                    }
                }
            }
            dessertsTable.dataSource = (id<NSTableViewDataSource>)dataSource;
            [dessertsTable reloadData];
        }
        numberOfCharacters = numberOfCharactersInFilter;
    }
    else
    {
        NSLog(@"Filtre moins restrictif. Remettre les anciennes valeurs!");
    }
}

@end
