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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"RecipesEditionView loaded");
    }
    
    return self;
}

@synthesize nameField, categoryField, ratingIndicator, summaryField, ingredientsTable, imageView;

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

- (void) setImageToRecipeWithFile:(NSURL *) fileEmplacement
{
    NSImage *image = [[NSImage alloc] initWithContentsOfURL:fileEmplacement];
    [imageView setImage:image];
}

@end
