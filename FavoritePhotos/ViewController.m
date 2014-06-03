//
//  ViewController.m
//  FavoritePhotos
//
//  Created by Robert Figueras on 6/2/14.
//
//

#import "ViewController.h"
#import "FavoritesUICollectionViewCell.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *favoritesCollectionView;
@property NSMutableArray *arrayOfImageDataObjects;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arrayOfImageDataObjects = [NSMutableArray array];
    [self load];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arrayOfImageDataObjects.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FavoritesUICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"faveCell" forIndexPath:indexPath];
    NSData *favoriteImageData = [self.arrayOfImageDataObjects objectAtIndex:indexPath.row];
    cell.favoritesImageView.image = [UIImage imageWithData:favoriteImageData];
    return cell;
    
}

- (void)load
{
    NSURL *plist = [[self documentsDirectory]URLByAppendingPathComponent:@"photoData.plist"];
    self.arrayOfImageDataObjects = [NSMutableArray arrayWithContentsOfURL:plist];
    if (!self.arrayOfImageDataObjects)
    {
        self.arrayOfImageDataObjects = [NSMutableArray array];
    }
}

- (NSURL *)documentsDirectory
{
    return [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
}

- (IBAction)unwindSegue:(UIStoryboardSegue *)segue
{
//    searchv *vc = segue.sourceViewController;
//    [self.toothPasteArray addObject:vc.pickedToothPaste];
//    [self.tableView reloadData];
//    [self save];
}

@end
