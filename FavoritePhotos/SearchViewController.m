//
//  SearchViewController.m
//  FavoritePhotos
//
//  Created by Robert Figueras on 6/2/14.
//
//

#import "SearchViewController.h"
#import "SearchPhotoCell.h"
#import "PhotoDataManager.h"
#import "Photo.h"
#import "FavoritesUICollectionViewCell.h"

@interface SearchViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, PhotoDataManagerDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *searchCollectionView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *searchActivityIndicator;
@property (strong, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property PhotoDataManager *photoDataManager;
@property NSMutableArray *searchResultsPhotoDataArray;
@property NSMutableArray *selectedPhotoDataArray;

@end

@implementation SearchViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.photoDataManager = [[PhotoDataManager alloc] init];
    self.photoDataManager.delegate = self;
    self.selectedPhotoDataArray = [NSMutableArray array];
}


- (void)photoDataManagerDidFinishGettingPhotos:(NSArray *)array
{
    self.searchResultsPhotoDataArray = [[NSMutableArray alloc] init];
    for (Photo *eachPhotoObj in array) {
        [self.searchResultsPhotoDataArray addObject:eachPhotoObj];
    }
    [self.searchActivityIndicator stopAnimating];
    [self.searchCollectionView reloadData];
}



- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.searchResultsPhotoDataArray.count;
}


- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"searchCell" forIndexPath:indexPath];

    Photo *photoObject = [self.searchResultsPhotoDataArray objectAtIndex:indexPath.row];
    UIImage *photoImageFromData = [UIImage imageWithData:photoObject.photoImageData];
    cell.photoCellImageView.image = photoImageFromData;
    return cell;
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.mySearchBar resignFirstResponder];
    [self.photoDataManager getArrayOfPhotoObjectsforTheSearchTerm:searchBar.text];
    [self.searchActivityIndicator startAnimating];
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    Photo *selectedPhotoObject = [self.searchResultsPhotoDataArray objectAtIndex:indexPath.row];
    NSData *dataOfSelectedObject = selectedPhotoObject.photoImageData;
    [self.selectedPhotoDataArray addObject:dataOfSelectedObject];
    SearchPhotoCell *selectedCell = (SearchPhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [selectedCell setSelected:YES];
    [self save];

}



- (void)save
{
    NSURL *plist = [[self documentsDirectory]URLByAppendingPathComponent:@"photoData.plist"];
    [self.selectedPhotoDataArray writeToURL:plist atomically:YES];
}


- (NSURL *)documentsDirectory
{
    return [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]firstObject];
}

@end
