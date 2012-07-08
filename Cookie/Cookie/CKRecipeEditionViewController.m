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
@synthesize addRecipeButton, ingredientsTable, nameField, categoryField, ratingIndicator, summaryField, imageView;
@synthesize quantity,measure, addIngredientButton;
//Data
@synthesize ingredients;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSMutableArray* quantities = [[NSMutableArray alloc] init];
        NSMutableArray* measures = [[NSMutableArray alloc] init];
        self.ingredients = [[NSMutableArray alloc] initWithObjects:measures, quantities, nil ];
        imageHash = 0;
        nameIsValid = NO;
        descIsValid = NO;
        hasIngredient = NO;
        isEditing = NO;
        fileEmplacement = nil;
        oldRecipeName = nil;
    }
    
    return self;
}

-(void) awakeFromNib
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
    [notif addObserver:self selector:@selector(controlTextDidChange:) 
                  name:NSTextDidChangeNotification
                object:summaryField];
}

- (void) initViewWithRecipe:(CKRecipe*) recipe
{
    oldRecipeName = [[NSString alloc] initWithString:[recipe name]];
    NSString* summurayData = [[NSString alloc] initWithData:[recipe summary] encoding:NSUTF8StringEncoding];
    [nameField setStringValue:[recipe name]];
    switch ([[recipe category] intValue]) {
        case 0:
            [categoryField setStringValue:@"Entrée"];
            break;
        case 1:
            [categoryField setStringValue:@"Plat"];
            break;
        default:
            [categoryField setStringValue:@"Dessert"];  
            break;
    }
    [ratingIndicator setIntValue:[[recipe rating] intValue]];
    [summaryField setString:summurayData];
    ingredients = [[NSMutableArray alloc] initWithArray:[recipe ingredients]];
    [ingredientsTable reloadData];
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    NSString* pathForPicture = [[CKAppDelegate getPicturesPath] 
                                stringByAppendingPathComponent:
                                [NSString stringWithFormat:@"%@.jpeg",[recipe pictureID]]
                                ];
    BOOL pictureExists = [fileMgr fileExistsAtPath:pathForPicture];
    if (pictureExists) {
        NSImage *image = [[NSImage alloc] initWithContentsOfFile:pathForPicture];
        [imageView setImage:image];
        imageHash = [[recipe pictureID] integerValue];
    }
    nameIsValid = YES;
    descIsValid = YES;
    hasIngredient = YES;
    [addRecipeButton setTitle:@"Mettre à jour"];
    [addRecipeButton setEnabled:YES];
    isEditing = YES;
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
        if (descIsValid && hasIngredient)
        {
            [addRecipeButton setEnabled:YES];   
        }
        nameIsValid = YES;
    }
    else {
        [addRecipeButton setEnabled:NO];
        nameIsValid = NO;
    }
}

- (void) controlTextDidChange: (NSNotification *) notification
{
    if (summaryField.string.length > 0)
    {
        if (nameIsValid && hasIngredient)
        {
            [addRecipeButton setEnabled:YES];   
        }
        descIsValid = YES;
    }
    else {
        [addRecipeButton setEnabled:NO];
        descIsValid = NO;
    }
}

- (BOOL) checkForRecipeNameBeforeAdd:(NSString*) name
{
    
    NSArray* recipes = [[[NSApp delegate] recipes] recipeArray];
    for (CKRecipe* recipe in recipes) {
        if ([[recipe name] isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}

- (void) alertExistingRecipeName
{
    NSAlert *alert = [[[NSAlert alloc] init] autorelease]; 
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:@"Un tel nom de recette existe déjà."];
    [alert setInformativeText:@"Merci de choisir autre chose."];
    [alert setAlertStyle:NSWarningAlertStyle];
    [alert beginSheetModalForWindow:[[self view] window]
                      modalDelegate:self
                     didEndSelector:nil
                        contextInfo:nil];
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

- (NSImage*) getResizedImage:(NSImage*) image
{
    NSBitmapImageRep *oldBitmap = [[image representations] objectAtIndex:0];
    NSBitmapImageRep *newBitmap = [[NSBitmapImageRep alloc]
                                   initWithBitmapDataPlanes:NULL pixelsWide:128
                                   pixelsHigh:128 bitsPerSample:8 samplesPerPixel:4 hasAlpha:YES
                                   isPlanar:NO colorSpaceName:NSCalibratedRGBColorSpace
                                   bitmapFormat:NSAlphaFirstBitmapFormat bytesPerRow:0 bitsPerPixel:32];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:[NSGraphicsContext
                                          graphicsContextWithBitmapImageRep:newBitmap]];
    [oldBitmap drawInRect:NSMakeRect(0,0,128,128)];
    [NSGraphicsContext restoreGraphicsState];
    NSImage *resized = [[NSImage alloc] initWithSize:[newBitmap size]];
    [resized addRepresentation: newBitmap];
    return [resized autorelease];
}


- (void) setImageToRecipeWithFile:(NSURL *) newFileEmplacement
{
    NSImage *image = [[NSImage alloc] initWithContentsOfURL:newFileEmplacement];
    [self saveOriginalImage:image];
    NSImage *reducedImage = [self getResizedImage:image];
    [imageView setImage:reducedImage];
    [self saveMiniatureImage:reducedImage];
}



- (void) saveOriginalImage:(NSImage*) image
{
    NSString *imageName = [NSString stringWithFormat:@"%u.jpeg",imageHash];
    NSString *fullPath =  [[CKAppDelegate getPicturesPath] stringByAppendingPathComponent:imageName];
    NSArray *representations = [image representations];
    NSData* imageData = [NSBitmapImageRep representationOfImageRepsInArray:representations usingType:NSJPEGFileType properties:nil];
    NSError *writeError = nil;
    [imageData writeToFile:fullPath options:NSDataWritingAtomic error:&writeError];
    
    if (writeError!=nil) {
        NSLog(@"%@: Error saving Full Picture: %@", [self class], [writeError localizedDescription]);
    }
}

- (void) saveMiniatureImage:(NSImage*) image
{
    NSString *imageName = [NSString stringWithFormat:@"%u.jpeg",imageHash];
    NSString *fullPath =  [[CKAppDelegate getMiniaturePath] stringByAppendingPathComponent:imageName];
    NSArray *representations = [image representations];
    NSData* imageData = [NSBitmapImageRep representationOfImageRepsInArray:representations usingType:NSJPEGFileType properties:nil];
    NSError *writeError = nil;
    [imageData writeToFile:fullPath options:NSDataWritingAtomic error:&writeError];
    
    if (writeError!=nil) {
        NSLog(@"%@: Error saving Miniature: %@", [self class], [writeError localizedDescription]);
    }
}


- (void)dealloc
{
    ingredients = nil;
    [super dealloc];
}

//Actions

- (IBAction)addIngredientAction:(id)sender {
    [self addIngredientWithMeasure:[measure stringValue] andQuantity:[quantity integerValue]];
    hasIngredient = YES;
    if (nameIsValid && descIsValid)
    {
        [addRecipeButton setEnabled:YES];
    }
}

- (IBAction)removeIngredientAction:(id)sender {
    NSInteger row = [ingredientsTable selectedRow];
    if (row != -1)
    {
        [self deleteIngredientAtIndex:row];
        if ([ingredientsTable numberOfRows] <= 1)
        {
            hasIngredient = NO;
            [addRecipeButton setEnabled:NO];
        }
    }
    [ingredientsTable reloadData];
}

- (IBAction)addRecipeAction:(id)sender {
    CKAppDelegate *appDelegate = [NSApp delegate];
    CKRecipes *recipes = [appDelegate recipes];
    NSInteger intId = [[recipes recipeArray] count];
    NSString *uniqueId = [NSString stringWithFormat:@"%i",intId]; 
    NSNumber* mealCategory = [NSNumber numberWithInteger:[categoryField indexOfItemWithObjectValue:[categoryField stringValue]]];
    NSNumber *rating = [NSNumber numberWithInt:[ratingIndicator intValue]];
    NSString *uniqueImageId = [NSString stringWithFormat:@"%i",imageHash];
    NSData* data = [[summaryField string] dataUsingEncoding:NSUTF8StringEncoding];
    CKRecipe* recipe = [[CKRecipe alloc] initWithUniqueID:uniqueId
                                                  andName:nameField.stringValue
                                              andCategory:mealCategory
                                             andPictureID:uniqueImageId
                                                andRating:rating
                                               andSummary:data
                                           andIngredients:ingredients];
    if (isEditing) {
        [recipes remove:oldRecipeName];
    }
    else
    {
        if ([self checkForRecipeNameBeforeAdd:nameField.stringValue]) {
            [self alertExistingRecipeName];
            [recipe release];
            return;
        }

    }
    [recipes add:recipe];
    CKWindowController* windowController = [[[self view] window] windowController];
    [windowController pushRecipesView];
}



- (IBAction)choosePictureDialog:(id)sender {
    NSOpenPanel *op = [NSOpenPanel openPanel];
    [op setTitle:@"Merci de choisir une image pour la recette"];
    NSArray *types = [[NSArray alloc] initWithObjects:@"jpeg",@"png",@"jpg", @"tiff", nil];
    [op setAllowedFileTypes:types];
    if ([op runModal] == NSOKButton)
    {
        fileEmplacement = [op URL];
        NSData* imgData = [NSData dataWithContentsOfURL:fileEmplacement];
        imageHash = [imgData hash];
        [self setImageToRecipeWithFile:fileEmplacement];
    }
}

@end
