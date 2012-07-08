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
    //double Click target
    [[self lastTable] setTarget:self];
    [[self bestTable] setTarget:self];
    [[self lastTable] setDoubleAction:@selector(doubleClickLastTable:)];
    [[self bestTable] setDoubleAction:@selector(doubleClickBestTable:)];
    
    [CKAppDelegate checkFoldersExistance];
    CKAppDelegate *appDelegate = [NSApp delegate];
    CKRecipes *recipes = [[CKRecipes alloc] initWithDictionnary:[CKRecipesSerializer deserialize]];
    
    if (recipes.count <= 0) {
        [self addDefaultRecipes:recipes];
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
- (void)doubleClickLastTable:(id)aTableView
{
    CKWindowController* windowController = [[[self view] window] windowController];
    CKRecipeDataSource* dataSource = lastTable.dataSource;
    NSInteger selectedRow = lastTable.selectedRow;
    NSArray* recipesArray = dataSource.items;
    CKRecipe* selectedRecipe = [recipesArray objectAtIndex:selectedRow];
    [windowController pushRecipeViewWithRecipe:selectedRecipe];
}

- (void)doubleClickBestTable:(id)aTableView
{
    CKWindowController* windowController = [[[self view] window] windowController];
    CKRecipeDataSource* dataSource = bestTable.dataSource;
    NSInteger selectedRow = bestTable.selectedRow;
    NSArray* recipesArray = dataSource.items;
    CKRecipe* selectedRecipe = [recipesArray objectAtIndex:selectedRow];
    [windowController pushRecipeViewWithRecipe:selectedRecipe];
}

- (void)addDefaultRecipes:(CKRecipes *)recipes {
    NSData *data2 = [[NSString stringWithString:@"Mettez l'huile d'olive à chauffer dans une cocotte bien chaude. Ajoutez les rondelles de poireaux et de courgettes dans la cocotte et faites-les revenir 5 minutes.\n\nAjoutez ensuite la tablette de bouillon et le curry. Salez et poivrez. Ajoutez environ un litre d'eau froide dans la cocotte. Laissez cuire la préparation pendant 20 minutes environ.\n\nMixez la préparation. Dégustez bien chaud."] dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data3 = [[NSString stringWithString:@"Eplucher et couper les légumes en julienne (cuisson plus rapide)\n\nAjouter les légumes, les faire revenir pendant environ 5 à 6 minutes en remuant, mettre le sel et le poivre. Verser l'eau jusqu'à ce que les légumes soient recouverts environ 2 cm au-dessus des légumes, porter à ébullition, remettre ensuite sur feu doux 15 minutes pour une petite ébullition. Remuer de temps en temps, rectifier la quantité de l'eau si besoin.\n\nBien mouliner pour un velouté la soupe encore tiède de manière de façon rectifier plus facilement avec le sel et le poivrer si besoin. Rectifier la quantité d'eau si nécessaire pour une soupe plus ou moins liquide.\n\nServir bien chaud sans beurre et sans crème fraiche pour le coté diététique."] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSArray *measures2 = [NSArray arrayWithObjects:[NSNumber numberWithInt:400], [NSNumber numberWithInt:500], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:3], nil];
    NSArray *measures3 = [NSArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:2], nil];
    
    NSArray *name2 = [NSArray arrayWithObjects:@"g de courgette", @"g de poireaux", @"bloc de bouillon", @"cac. de curry", @"cas. d'huile d'olive", nil];
    NSArray *name3 = [NSArray arrayWithObjects:@"Poireaux", @"Pommes de terres", nil];
    
    NSNumber *rating2 = [NSNumber numberWithInt:2];
    NSNumber *rating3 = [NSNumber numberWithInt:4];
    
    NSImage *image2 = [NSImage imageNamed:@"soupe_curry.png"];
    NSArray *representations = [image2 representations];
    
    NSData *imgData2 = [NSBitmapImageRep representationOfImageRepsInArray:representations usingType:NSJPEGFileType properties:nil];
    NSUInteger imageHash2 = [imgData2 hash];
    NSString *imageName2 = [NSString stringWithFormat:@"%u.jpeg",imageHash2];
    NSString *uniqueImageId2 = [NSString stringWithFormat:@"%i",imageHash2];
    
    NSString *fullPath =  [[CKAppDelegate getPicturesPath] stringByAppendingPathComponent:imageName2];
    NSData* imageData = [NSBitmapImageRep representationOfImageRepsInArray:representations usingType:NSJPEGFileType properties:nil];
    NSError *writeError = nil;
    [imageData writeToFile:fullPath options:NSDataWritingAtomic error:&writeError];
    
    if (writeError!=nil) {
        NSLog(@"%@: Error saving Full Picture: %@", [self class], [writeError localizedDescription]);
    }
    
    NSBitmapImageRep *oldBitmap = [[image2 representations] objectAtIndex:0];
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
    
    fullPath =  [[CKAppDelegate getMiniaturePath] stringByAppendingPathComponent:imageName2];
    representations = [resized representations];
    imageData = [NSBitmapImageRep representationOfImageRepsInArray:representations usingType:NSJPEGFileType properties:nil];
    writeError = nil;
    [imageData writeToFile:fullPath options:NSDataWritingAtomic error:&writeError];
    
    if (writeError!=nil) {
        NSLog(@"%@: Error saving Miniature: %@", [self class], [writeError localizedDescription]);
    }
    
    NSImage *image3 = [NSImage imageNamed:@"soupe_poireaux.jpg"];
    representations = [image3 representations];
    imageData = [NSBitmapImageRep representationOfImageRepsInArray:representations usingType:NSJPEGFileType properties:nil];
    
    NSUInteger imageHash3 = [imageData hash];
    NSString *imageName3 = [NSString stringWithFormat:@"%u.jpeg",imageHash3];
    NSString *uniqueImageId3 = [NSString stringWithFormat:@"%i",imageHash3];
    
    fullPath =  [[CKAppDelegate getPicturesPath] stringByAppendingPathComponent:imageName3];
    
    writeError = nil;
    [imageData writeToFile:fullPath options:NSDataWritingAtomic error:&writeError];
    
    if (writeError!=nil) {
        NSLog(@"%@: Error saving Full Picture: %@", [self class], [writeError localizedDescription]);
    }
    
    oldBitmap = [[image3 representations] objectAtIndex:0];
    newBitmap = [[NSBitmapImageRep alloc]
                 initWithBitmapDataPlanes:NULL pixelsWide:128
                 pixelsHigh:128 bitsPerSample:8 samplesPerPixel:4 hasAlpha:YES
                 isPlanar:NO colorSpaceName:NSCalibratedRGBColorSpace
                 bitmapFormat:NSAlphaFirstBitmapFormat bytesPerRow:0 bitsPerPixel:32];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:[NSGraphicsContext
                                          graphicsContextWithBitmapImageRep:newBitmap]];
    [oldBitmap drawInRect:NSMakeRect(0,0,128,128)];
    [NSGraphicsContext restoreGraphicsState];
    resized = [[NSImage alloc] initWithSize:[newBitmap size]];
    [resized addRepresentation: newBitmap];
    
    fullPath =  [[CKAppDelegate getMiniaturePath] stringByAppendingPathComponent:imageName3];
    
    representations = [resized representations];
    imageData = [NSBitmapImageRep representationOfImageRepsInArray:representations usingType:NSJPEGFileType properties:nil];
    writeError = nil;
    [imageData writeToFile:fullPath options:NSDataWritingAtomic error:&writeError];
    
    if (writeError!=nil) {
        NSLog(@"%@: Error saving Miniature: %@", [self class], [writeError localizedDescription]);
    }
    
    
    CKRecipe *recipe2 = [[CKRecipe alloc] initWithUniqueID:@"Velouté de poireaux au curry" andName:@"Velouté de poireaux au curry" andCategory:[NSNumber numberWithInt:0] andPictureID:uniqueImageId2 andRating:rating2 andSummary:data2 andIngredients:[[NSArray arrayWithObjects:name2, measures2, nil] retain]];
    CKRecipe *recipe3 = [[CKRecipe alloc] initWithUniqueID:@"Soupe de légumes diététique" andName:@"Soupe de légumes diététique" andCategory:[NSNumber numberWithInt:0] andPictureID:uniqueImageId3 andRating:rating3 andSummary:data3 andIngredients:[[NSArray arrayWithObjects:name3, measures3, nil] retain]];
    
    [recipes add:recipe2];
    [recipes add:recipe3];
    
    recipes.recipeArray = [CKRecipes orderByRating:recipes.recipeArray];
    
    NSDictionary* dict = [recipes toDictionnary];
    [CKRecipesSerializer serialize:dict];

}

@end
