//
//  CKRecipeEditionViewController.m
//  Cookie
//
//  Created by Benjamin Lefebvre on 7/1/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import "CKRecipeEditionViewController.h"


@interface CKRecipeEditionViewController ()

@end

@implementation CKRecipeEditionViewController
@synthesize removeIngredientButton;

//View
@synthesize addButton, ingredientsTable, nameField, categoryField, ratingIndicator, summaryField, imageView;
@synthesize quantity,measure, addIngredientButton;
//Data
@synthesize ingredients;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"RecipesEditionView loaded");
        NSMutableArray* quantities = [[NSMutableArray alloc] init];
        NSMutableArray* measures = [[NSMutableArray alloc] init];
        self.ingredients = [[NSMutableArray alloc] initWithObjects:measures, quantities, nil ];
        [self addIngredientWithMeasure:@"g de miel" andQuantity:100];
        [self addIngredientWithMeasure:@"g de nutella" andQuantity:800];
        [self addIngredientWithMeasure:@"kg de chocapic" andQuantity:50];
    }
    
    return self;
}

- (void) awakeFromNib
{
    NSNotificationCenter *notif = [NSNotificationCenter defaultCenter];
    [notif addObserver:self selector:@selector(textDidChange:) 
                  name:NSControlTextDidChangeNotification
                object:nameField];
    [notif addObserver:self selector:@selector(textDidChange:) 
                  name:NSControlTextDidChangeNotification
                object:measure];
    [notif addObserver:self selector:@selector(textDidChange:) 
                  name:NSControlTextDidChangeNotification
                object:quantity];
}

- (void) textDidChange:(NSNotification *)notification
{
    if (quantity.stringValue.length > 0 && measure.stringValue.length > 0)
    {
        [addIngredientButton setEnabled:YES];
    }
    else {
        [addIngredientButton setEnabled:NO];
    }
    
    if (nameField.stringValue.length > 0)
    {
        [addButton setEnabled:YES];
    }
    else {
        [addButton setEnabled:NO];
    }
}

- (NSImage*) getResizedImage:(NSImage*) image
{
    [image setScalesWhenResized:YES];
    [image setSize:NSMakeSize(120., 120.)];
    return image;
}

- (void) setImageToRecipeWithFile:(NSURL *) fileEmplacement
{
    NSImage *image = [[NSImage alloc] initWithContentsOfURL:fileEmplacement];
    [imageView setImage:[self getResizedImage:image]];
}

- (void) saveOriginalImage:(NSImage*) image
{

}

- (void) saveMiniatureImage:(NSImage*) image
{
    
}

+ (NSString*)getMiniaturePath { 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *appSupportPath = [paths objectAtIndex:0];
    NSString *appName = [[NSRunningApplication currentApplication] localizedName];
    return [[appSupportPath stringByAppendingPathComponent:appName]stringByAppendingPathComponent:@"Miniatures"];
}

+ (NSString*)getPicturesPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *appSupportPath = [paths objectAtIndex:0];
    NSString *appName = [[NSRunningApplication currentApplication] localizedName];
    return [[appSupportPath stringByAppendingPathComponent:appName]stringByAppendingPathComponent:@"Pictures"];
}

//Delegate Protocol
- (void)tableViewSelectionIsChanging:(NSNotification *)aNotification
{
    [removeIngredientButton setEnabled:YES];
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
    NSInteger row = [ingredientsTable selectedRow];
    if (row == -1)
    {
        [removeIngredientButton setEnabled:NO];
    }
}

//DataSource Protocol

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

- (void) tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSString *columnIdentifer = [tableColumn identifier];
    if ([columnIdentifer isEqualToString:@"measure"]) {
        [[ingredients objectAtIndex:0] replaceObjectAtIndex:row withObject:object];
    }
    else
    {
        [[ingredients objectAtIndex:1] replaceObjectAtIndex:row withObject:object];
    }
    [ingredientsTable reloadData];
}

- (void) addIngredientWithMeasure:(NSString*)measureString andQuantity:(NSInteger)quantityInteger
{
    [[ingredients objectAtIndex:0] addObject:measureString];
    [[ingredients objectAtIndex:1] addObject:[NSNumber numberWithInteger:quantityInteger]];
    [ingredientsTable reloadData];
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

//Actions

- (IBAction)addIngredientAction:(id)sender {
    [self addIngredientWithMeasure:[measure stringValue] andQuantity:[quantity integerValue]];
}

- (IBAction)removeIngredientAction:(id)sender {
    NSInteger row = [ingredientsTable selectedRow];
    if (row != -1)
    {
        [self deleteIngredientAtIndex:row];
    }
    [ingredientsTable reloadData];
}



- (IBAction)choosePictureDialog:(id)sender {
    NSOpenPanel *op = [NSOpenPanel openPanel];
    [op setTitle:@"Merci de choisir une image pour la recette"];
    NSArray *types = [[NSArray alloc] initWithObjects:@"jpeg",@"png",@"jpg", @"tiff", nil];
    [op setAllowedFileTypes:types];
    if ([op runModal] == NSOKButton)
    {
        NSURL *filename = [op URL];
        [self setImageToRecipeWithFile:filename];
        NSLog(@"%@",filename);
    }
}

@end
