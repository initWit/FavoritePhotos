//
//  SearchPhotoCell.m
//  FavoritePhotos
//
//  Created by Robert Figueras on 6/2/14.
//
//

#import "SearchPhotoCell.h"

@implementation SearchPhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setSelected:(BOOL)selected
{
    if (selected == YES)
    {
        self.heartSelectionImageView.alpha = 1.0;
    }
    else
    {
        self.heartSelectionImageView.alpha = 0.0;
    }
}

@end
