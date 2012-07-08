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
@synthesize suppressButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewWillLoad {
    // Here for subclasses to override.
}

- (void)viewDidLoad {
    [self fillTables];
}

- (void)loadView {
    [self viewWillLoad];
    [super loadView];
    [self viewDidLoad];
    [[self entreesTable] setTarget:self];
    [[self dessertsTable] setTarget:self];
    [[self platsTable] setTarget:self];
    [[self dessertsTable] setDoubleAction:@selector(doubleClick:)];
    [[self platsTable] setDoubleAction:@selector(doubleClick:)];
    [[self entreesTable] setDoubleAction:@selector(doubleClick:)];

}

- (void)fillTables {
    CKAppDelegate *appDelegate = [NSApp delegate];
  
    CKRecipeDataSource *dataSource = [[CKRecipeDataSource alloc] init];
    dataSource.items = [CKRecipes orderByRating:[appDelegate.recipes recipesInCategory:0]];
    [entreesTable setDataSource:dataSource];  
    
    CKRecipeDataSource *dataSource2 = [[CKRecipeDataSource alloc] init];
    dataSource2.items = [CKRecipes orderByRating:[appDelegate.recipes recipesInCategory:1]];;
    [platsTable setDataSource:dataSource2];

    CKRecipeDataSource *dataSource3 = [[CKRecipeDataSource alloc] init];
    dataSource3.items = [CKRecipes orderByRating:[appDelegate.recipes recipesInCategory:2]];
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
        NSMutableArray *results;
        if ([filter isEqualToString:@""])
            results = [appDelegate.recipes recipesInCategory:0];
        else
            results = [appDelegate.recipes recipesInCategory:0 withIngredients:tab];
        
        CKRecipeDataSource *dataSource = [[CKRecipeDataSource alloc] init];
        dataSource.items = results;
            
        entreesTable.dataSource = (id<NSTableViewDataSource>)dataSource;
        [entreesTable reloadData];
    }
    else if ([tabSelected isEqualToString:@"Plats"])
    {
        NSMutableArray *results;
        if ([filter isEqualToString:@""])
            results = [appDelegate.recipes recipesInCategory:1];
        else
            results = [appDelegate.recipes recipesInCategory:1 withIngredients:tab];
        CKRecipeDataSource *dataSource = [[CKRecipeDataSource alloc] init];
        dataSource.items = results;
        
        platsTable.dataSource = (id<NSTableViewDataSource>)dataSource;
        [platsTable reloadData];
    }
    else
    {
        NSMutableArray *results;
        if ([filter isEqualToString:@""])
            results = [appDelegate.recipes recipesInCategory:2];
        else
            results = [appDelegate.recipes recipesInCategory:2 withIngredients:tab];
        CKRecipeDataSource *dataSource = [[CKRecipeDataSource alloc] init];
        dataSource.items = results;
        
        dessertsTable.dataSource = (id<NSTableViewDataSource>)dataSource;
        [dessertsTable reloadData];
    }
}

-(IBAction)deleteRecipes:sender
{
    NSAlert *alert = [[[NSAlert alloc] init] autorelease]; 
    [alert addButtonWithTitle:@"Supprimer"];
    [alert addButtonWithTitle:@"Conserver"];
    [alert setMessageText:@"Etes vous certain de vouloir supprimer \rles recettes ?"];
    [alert setInformativeText:@"La suppression est définitive !"];
    [alert setAlertStyle:NSWarningAlertStyle];
    SEL callback = @selector(didDeletionAlert:returnCode:);
    [alert beginSheetModalForWindow:[[self view] window]
                      modalDelegate:self
                     didEndSelector:callback
                        contextInfo:nil];
}

- (void) didDeletionAlert:(NSAlert*)alert returnCode:(int)button
{
    if (button == NSAlertFirstButtonReturn)
    {
        
        CKAppDelegate *appDelegate = [NSApp delegate];
        CKRecipes *recipes = [appDelegate recipes];
        NSString *tabSelected = [[tabView selectedTabViewItem] label];
        NSIndexSet* indexSet = nil;
        CKRecipeDataSource* dataSource = nil;
        if ([tabSelected isEqualToString:@"Entrées"])
        {
                    NSLog(@"entree");
            dataSource = entreesTable.dataSource;
            indexSet = [entreesTable selectedRowIndexes];
        }
        else if ([tabSelected isEqualToString:@"Plats"])
        {
                             NSLog(@"plat");
            dataSource = platsTable.dataSource;
            indexSet = [platsTable selectedRowIndexes];
        }
        else
        {
            dataSource = dessertsTable.dataSource;
            indexSet = [dessertsTable selectedRowIndexes];
        }
        NSUInteger index = [indexSet firstIndex];
        while (index != NSNotFound) {
            NSString* recipeName =[[dataSource.items objectAtIndex:index] name];
            [recipes remove:recipeName];
            [dataSource.items removeObjectAtIndex:index];
            index = [indexSet indexGreaterThanIndex:index];
        }
        [entreesTable reloadData];
        [platsTable reloadData];
        [dessertsTable reloadData];
    }
}

- (void)doubleClick:(id)aTableView
{
    NSString *tabSelected = [[tabView selectedTabViewItem] label];
    CKWindowController* windowController = [[[self view] window] windowController];
    CKRecipeDataSource* dataSource = nil;
    NSInteger selectedRow = 0;
    
    if ([tabSelected isEqualToString:@"Entrées"])
    {
        dataSource = entreesTable.dataSource;
        selectedRow = [entreesTable selectedRow];
    }
    else if ([tabSelected isEqualToString:@"Plats"])
    {
        dataSource = platsTable.dataSource;
        selectedRow = [platsTable selectedRow];
    }
    else
    {
        dataSource = dessertsTable.dataSource;
        selectedRow = [dessertsTable selectedRow];
    }
    NSArray* recipesArray = dataSource.items;
    CKRecipe* selectedRecipe = [recipesArray objectAtIndex:selectedRow];
    [windowController pushRecipeViewWithRecipe:selectedRecipe];
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
    NSString *tabSelected = [[tabView selectedTabViewItem] label];
    CKRecipeDataSource* dataSource = nil;
    NSInteger selectedRow = -1;
    
    if ([tabSelected isEqualToString:@"Entrées"])
    {
        NSLog(@"Entrée");
        dataSource = entreesTable.dataSource;
        selectedRow = [entreesTable selectedRow];
    }
    else if ([tabSelected isEqualToString:@"Plats"])
    {
                NSLog(@"Plats");
        dataSource = platsTable.dataSource;
        selectedRow = [platsTable selectedRow];
    }
    else
    {
        NSLog(@"Dessert");
        dataSource = dessertsTable.dataSource;
        selectedRow = [dessertsTable selectedRow];
    }
    if (selectedRow != -1) {
        [suppressButton setEnabled:YES];
    }
    else
    {
        [suppressButton setEnabled:NO];  
    }
}

- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    [((CKRecipeDataSource *)tableView.dataSource) tableView:tableView willDisplayCell:cell forTableColumn:tableColumn row:row];
}
@end
