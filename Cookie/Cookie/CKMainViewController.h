//
//  CKMainViewController.h
//  Cookie
//
//  Created by Benjamin Lefebvre on 6/30/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CKAppDelegate.h"
@interface CKMainViewController : NSViewController
@property (assign) IBOutlet NSImageView *dayImage;
@property (assign) IBOutlet NSTextField *dayName;
@property (assign) IBOutlet NSTextField *dayCategory;
@property (assign) IBOutlet NSLevelIndicator *dayRating;
@property (assign) IBOutlet NSTableView *lastTable;
@property (assign) IBOutlet NSTableView *bestTable;

- (void)fillTables;
- (void)doubleClickLastTable:(id)aTableView;
- (void)doubleClickBestTable:(id)aTableView;

- (IBAction)mainRecipeClickAction:(id)sender;

@end
