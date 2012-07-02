//
//  CKRecipesViewController.h
//  Cookie
//
//  Created by Benjamin Lefebvre on 6/30/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CKWindowController.h"

@protocol searchProto;

@interface CKRecipesViewController : NSViewController
@property (nonatomic) id<searchProto> delegate;

@end
