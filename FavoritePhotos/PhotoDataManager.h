//
//  PhotoDataManager.h
//  WildKingdom
//
//  Created by Robert Figueras on 5/30/14.
//
//

#import <Foundation/Foundation.h>

@protocol PhotoDataManagerDelegate
- (void) photoDataManagerDidFinishGettingPhotos: (NSArray *)array;
@end

@interface PhotoDataManager : NSObject
@property id<PhotoDataManagerDelegate>delegate;
- (void) getArrayOfPhotoObjectsforTheSearchTerm: (NSString *)searchTerm;
@end
