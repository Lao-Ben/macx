//
//  CKRecipeViewController.m
//  Cookie
//
//  Created by Benjamin Lefebvre on 6/30/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import "CKRecipeViewController.h"

@interface CKRecipeViewController ()

@end

@implementation CKRecipeViewController
@synthesize recipeTitle;
@synthesize recipeCategory;
@synthesize guestSelector;
@synthesize instructionsSummary;
@synthesize ingredientsTable;
@synthesize recipeImage;
@synthesize recipeRate;
@synthesize editButton;
@synthesize ingredientsArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        numberOfGuest = 2;
        prevNumberOfGuest = 2;
    }
    
    return self;
}

- (void) awakeFromNib
{
    NSNotificationCenter *notif = [NSNotificationCenter defaultCenter];
    [notif addObserver:self selector:@selector(itemOfMenuDidChange:) 
                  name:NSMenuDidChangeItemNotification
                object:[guestSelector menu]];
}

- (void) itemOfMenuDidChange:(NSNotification *)notification
{
    prevNumberOfGuest = numberOfGuest;
    NSMenuItem *item = [guestSelector itemAtIndex:[guestSelector indexOfSelectedItem]];
    numberOfGuest = [[item title] integerValue];
    NSMutableArray *quantities = [ingredientsArray objectAtIndex:1];
    for (int i = 0; i < [quantities count]; i++) {
        id quantity = [quantities objectAtIndex:i];
        float quantityInteger = [quantity floatValue];
        float newQuantityValue = (quantityInteger * numberOfGuest);
        newQuantityValue /= prevNumberOfGuest;
        [quantities replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%.2f", newQuantityValue]];
    }
    [ingredientsTable reloadData];
}

- (void) setUpRecipeWithRecipe:(CKRecipe*) recipe
{
    [self initItemGuests];
    currentRecipe = recipe;
    NSString* summurayData = [[NSString alloc] initWithData:[recipe summary] encoding:NSUTF8StringEncoding];
    [recipeTitle setStringValue:[recipe name]];
    switch ([[recipe category] intValue]) {
        case 0:
            [recipeCategory setStringValue:@"Entrée"];
            break;
        case 1:
            [recipeCategory setStringValue:@"Plat"];
            break;
        default:
            [recipeCategory setStringValue:@"Dessert"];  
            break;
    }
    [recipeRate setIntValue:[[recipe rating] intValue]];
    [instructionsSummary setString:summurayData];
    [self setIngredientsArray:[recipe ingredients]];
    [ingredientsTable reloadData];
    
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    NSString* pathForPicture = [[CKAppDelegate getPicturesPath] 
                                stringByAppendingPathComponent:
                                [NSString stringWithFormat:@"%@.jpeg",[recipe pictureID]]
                                ];
    BOOL pictureExists = [fileMgr fileExistsAtPath:pathForPicture];
    if (pictureExists) {
        NSImage *image = [[NSImage alloc] initWithContentsOfFile:pathForPicture];
        [recipeImage setImage:image];
    }    
}

- (void) initItemGuests
{
    for (int i = 0; i < 200; ++i)
    {
        NSString *key = [NSString stringWithFormat:@"%i",i + 1];
        NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:key action:nil keyEquivalent:key];
        [[guestSelector menu] addItem:item];
    }
    [guestSelector setObjectValue:@"1"];
}

//DataSource (tableview)

- (NSInteger) numberOfRowsInTableView:(NSTableView *) tableView {
    return [[self.ingredientsArray objectAtIndex:0] count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn
            row:(NSInteger)rowIndex
{
    NSString *columnIdentifer = [aTableColumn identifier];
    if ([columnIdentifer isEqualToString:@"measure"]) {
        return [[ingredientsArray objectAtIndex:0] objectAtIndex:rowIndex];
    }
    else
    {
        return [[ingredientsArray objectAtIndex:1] objectAtIndex:rowIndex];
    }
}


- (IBAction)editAction:(id)sender {
    CKWindowController *windowController = [[[self view] window] windowController];
    [windowController pushEditionViewWithRecipe:currentRecipe];
}

- (IBAction)ratingChanged:(id)sender {
    currentRecipe.rating = [NSNumber numberWithInt:recipeRate.intValue];
}

@end
