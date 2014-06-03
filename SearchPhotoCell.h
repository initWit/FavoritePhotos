//
//  SearchPhotoCell.h
//  FavoritePhotos
//
//  Created by Robert Figueras on 6/2/14.
//
//

#import <UIKit/UIKit.h>

@interface SearchPhotoCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *photoCellImageView;
@property (strong, nonatomic) IBOutlet UIImageView *heartSelectionImageView;
- (void) setSelected:(BOOL)selected;
@end
