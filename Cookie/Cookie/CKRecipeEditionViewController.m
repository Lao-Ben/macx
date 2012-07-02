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
@synthesize addButton;
@synthesize nameField, categoryField, ratingIndicator, summaryField, ingredientsTable, imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"RecipesEditionView loaded");
    }
    
    return self;
}

- (void) awakeFromNib
{
    NSNotificationCenter *notif = [NSNotificationCenter defaultCenter];
    [notif addObserver:self selector:@selector(textDidChange:) 
                  name:NSControlTextDidChangeNotification
                object:nameField];
}

- (void) textDidChange:(NSNotification *)notification
{
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

- (IBAction)addIngredient:(id)sender {
    CKRecipeDialogWindowController *dialog = [[CKRecipeDialogWindowController alloc] initWithWindowNibName:@"CKRecipeDialog" owner: self andIngredientsTable:ingredientsTable];
    [dialog showWindow:dialog];
}

+ (NSString*)getPicturesPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *appSupportPath = [paths objectAtIndex:0];
    NSString *appName = [[NSRunningApplication currentApplication] localizedName];
    return [[appSupportPath stringByAppendingPathComponent:appName]stringByAppendingPathComponent:@"Pictures"];
}

@end
