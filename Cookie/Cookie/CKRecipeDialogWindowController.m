//
//  CKRecipeDialogWindowController.m
//  Cookie
//
//  Created by Irenicus on 01/07/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import "CKRecipeDialogWindowController.h"

@interface CKRecipeDialogWindowController ()

@end

@implementation CKRecipeDialogWindowController
@synthesize measure;
@synthesize quantity;
@synthesize addIngredient;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
    }
    
    return self;
}

- (IBAction)didAddIngredient:(id)sender {
}

- (id)initWithWindowNibName:(NSString *)windowNibPath
                      owner:(id)owner
               andTableView:(NSTableView*)ingredients
{
    self = [super initWithWindowNibName:windowNibPath owner:owner];
    if (self) {
        ingredientsTable = ingredients;
    }
    
    return self;
}


- (void)windowDidLoad
{
    [super windowDidLoad];
}


- (void) awakeFromNib
{
    NSNotificationCenter *notif = [NSNotificationCenter defaultCenter];
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
        [addIngredient setEnabled:YES];
    }
    else {
        [addIngredient setEnabled:NO];
    }
}

@end
