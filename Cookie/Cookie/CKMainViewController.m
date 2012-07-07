//
//  CKMainViewController.m
//  Cookie
//
//  Created by Benjamin Lefebvre on 6/30/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import "CKMainViewController.h"

@interface CKMainViewController ()

@end

@implementation CKMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)viewWillLoad {
    NSLog(@"WILL LOAD");
    // Here for subclasses to override.
}

- (void)viewDidLoad {
    NSLog(@"DID LOAD");
    
    // Here for subclasses to override.
}

- (void)loadView {
    [self viewWillLoad];
    [super loadView];
    [self viewDidLoad];
}

@end
