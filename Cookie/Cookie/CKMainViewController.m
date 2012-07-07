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
@synthesize dayImage;
@synthesize dayName;
@synthesize dayCategory;
@synthesize dayRating;
@synthesize lastTable;
@synthesize bestTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)viewWillLoad {
    // Here for subclasses to override.
}

- (void)viewDidLoad {    
    [CKAppDelegate checkFoldersExistance];
    CKAppDelegate *appDelegate = [NSApp delegate];
    CKRecipes *recipes = [[CKRecipes alloc] initWithDictionnary:[CKRecipesSerializer deserialize]];
    
    if (recipes.count <= 0) {
        NSData *data = [[NSData alloc] init];
        NSNumber *rating = [NSNumber numberWithInt:4];
        
        /*CKRecipe *recipe = [[CKRecipe alloc] initWithUniqueID:@"124332" andName:@"Entree 1" andCategory:[NSNumber numberWithInt:0] andPictureID:@"1243" andRating:rating andSummary:data andIngredients:[[NSArray arrayWithObject:@"Pomme"] retain]];
        
        CKRecipe *recipe2 = [[CKRecipe alloc] initWithUniqueID:@"124332" andName:@"Entree 2" andCategory:[NSNumber numberWithInt:0] andPictureID:@"1243" andRating:rating andSummary:data andIngredients:[[NSArray arrayWithObject:@"Pomme"] retain]];
        
        CKRecipe *recipe3 = [[CKRecipe alloc] initWithUniqueID:@"124332" andName:@"Plat 1" andCategory:[NSNumber numberWithInt:1] andPictureID:@"1243" andRating:rating andSummary:data andIngredients:[[NSArray arrayWithObject:@"Pomme"] retain]];
        
        CKRecipe *recipe4 = [[CKRecipe alloc] initWithUniqueID:@"124332" andName:@"Dessert 1" andCategory:[NSNumber numberWithInt:2] andPictureID:@"1243" andRating:rating andSummary:data andIngredients:[[NSArray arrayWithObject:@"Pomme"] retain]];
        [recipes add:recipe];
        [recipes add:recipe2];
        [recipes add:recipe3];
        [recipes add:recipe4];
        recipes.recipeArray = [CKRecipes orderByRating:recipes.recipeArray];
    }

    appDelegate.recipes = recipes;
    
    CKRecipe *recipe = [appDelegate.recipes recipeOfTheDay];
    if (recipe.name != nil) {
        dayName.stringValue = recipe.name;
        switch ([recipe.category intValue]) {
            case 0:
                dayCategory.stringValue = @"Entrée";
                break;
            case 1:
                dayCategory.stringValue = @"Plat";
                break;
            default:
                dayCategory.stringValue = @"Dessert";  
                break;
        }
        [dayRating setIntegerValue:[recipe.rating integerValue]];
        
        NSFileManager* fileMgr = [NSFileManager defaultManager];
        NSString* pathForPicture = [[CKAppDelegate getMiniaturePath] 
                                    stringByAppendingPathComponent:
                                    [NSString stringWithFormat:@"%@.jpeg",recipe.pictureID]
                                    ];
        BOOL pictureExists = [fileMgr fileExistsAtPath:pathForPicture];
        if (pictureExists) {
            NSImage *image = [[NSImage alloc] initWithContentsOfFile:pathForPicture];
            [dayImage setImage:image];
        }
    }
    
[self fillTables];
}

- (void)loadView {
    [self viewWillLoad];
    [super loadView];
    [self viewDidLoad];
}


- (void)fillTables {
    CKAppDelegate *appDelegate = [NSApp delegate];
    
    CKRecipeDataSource *dataSource = [[CKRecipeDataSource alloc] init];
    dataSource.items = [CKRecipes orderById:appDelegate.recipes.recipeArray];    
    [lastTable setDataSource:dataSource];  
    
    CKRecipeDataSource *dataSource2 = [[CKRecipeDataSource alloc] init];
    dataSource2.items = [CKRecipes orderByRating:appDelegate.recipes.recipeArray];
    [bestTable setDataSource:dataSource2];
    
    [lastTable reloadData];    
    [bestTable reloadData];
}

@end
