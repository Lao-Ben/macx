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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"RecipesView loaded");
    }
    return self;
}

-(IBAction)updateFilter:(id)sender
{
    NSString *filter = [searchField stringValue];
    NSString *tabSelected = [[tabView selectedTabViewItem] label];
    
    if ([tabSelected isEqualToString:@"Entrées"])
        NSLog(@"Entrées");
    else if ([tabSelected isEqualToString:@"Plats"])
        NSLog(@"Plats");
    else
        NSLog(@"Desserts");
}

@end
