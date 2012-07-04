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
        self.numberOfCharacters = 0;
    }
    return self;
}

- (void)viewWillLoad {
    NSLog(@"WILL LOAD");
    // Here for subclasses to override.
}

- (void)viewDidLoad {
    NSLog(@"DID LOAD");
    [self fillTables];
    // Here for subclasses to override.
}

- (void)loadView {
    [self viewWillLoad];
    [super loadView];
    [self viewDidLoad];
}

- (void)fillTables {
    CKAppDelegate *appDelegate = [NSApp delegate];
  //  CKRecipeDataSource *dataSource = [[CKRecipeDataSource alloc] init];
   // dataSource.items = [appDelegate.recipes recipesInCategory:0];
   // [entreesTable setDataSource:dataSource];
    
 //   CKRecipeDataSource *dataSource2 = [[CKRecipeDataSource alloc] init];
  //  dataSource2.items = [appDelegate.recipes recipesInCategory:1];
   // [platsTable setDataSource:dataSource2];

    CKRecipeDataSource *dataSource3 = [[CKRecipeDataSource alloc] init];
    dataSource3.items = [appDelegate.recipes recipesInCategory:2];
    [dessertsTable setDataSource:dataSource3];

    [entreesTable reloadData];    
    [platsTable reloadData];
    [dessertsTable reloadData];
}

-(IBAction)updateFilter:(id)sender
{
    CKAppDelegate *appDelegate = [NSApp delegate];
    NSString *filter = [searchField stringValue];
    NSArray *tab = [filter componentsSeparatedByString:@" "];
    NSString *tabSelected = [[tabView selectedTabViewItem] label];
    
    if ([tabSelected isEqualToString:@"Entrées"])
    {
        NSLog(@"Entrées");
        NSMutableArray *results = [appDelegate.recipes recipesInCategory:0 withIngredients:tab];
        CKRecipeDataSource *dataSource = [[CKRecipeDataSource alloc] initWithRecipes:results];
            
        entreesTable.dataSource = (id<NSTableViewDataSource>)dataSource;
        [entreesTable reloadData];
    }
    else if ([tabSelected isEqualToString:@"Plats"])
    {
        NSLog(@"Plats");
        NSMutableArray *results = [appDelegate.recipes recipesInCategory:1 withIngredients:tab];
        CKRecipeDataSource *dataSource = [[CKRecipeDataSource alloc] initWithRecipes:results];
        
        platsTable.dataSource = (id<NSTableViewDataSource>)dataSource;
        [platsTable reloadData];
    }
    else
    {
        NSLog(@"Desserts");
        NSMutableArray *results = [appDelegate.recipes recipesInCategory:2 withIngredients:tab];
        CKRecipeDataSource *dataSource = [[CKRecipeDataSource alloc] initWithRecipes:results];
        
        dessertsTable.dataSource = (id<NSTableViewDataSource>)dataSource;
        [dessertsTable reloadData];
    }
}

@end
