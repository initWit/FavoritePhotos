//
//  PhotoDataManager.m
//  WildKingdom
//
//  Created by Robert Figueras on 5/30/14.
//
//

#import "PhotoDataManager.h"
#import "Photo.h"

@implementation PhotoDataManager

- (void) getArrayOfPhotoObjectsforTheSearchTerm: (NSString *)searchTerm
{
//    NSMutableArray *arrayOfPhotoURLs = [[NSMutableArray alloc] init];
//    NSMutableArray *arrayOfPhotoImages = [[NSMutableArray alloc] init];
    NSMutableArray *arrayOfPhotoObjects = [[NSMutableArray alloc] init];

    NSString *urlConcatenatedString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=de8633ef359f7d429bada6a2c88e42b0&text=%@&per_page=10&format=json&nojsoncallback=1", searchTerm];
//    NSLog(@"urlConcatenatedString: %@",urlConcatenatedString);
    NSURL* url  = [NSURL URLWithString:urlConcatenatedString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        NSDictionary *returnedResults = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
//        NSLog(@"returnedResults:  %@",returnedResults);
        NSDictionary *photosKeyDictionary = [returnedResults objectForKey:@"photos"];
//        NSLog(@"photosKeyDictionary:  %@",photosKeyDictionary);
        NSArray *photoKeyArray = [photosKeyDictionary objectForKey:@"photo"];
//        NSLog(@"photoKeyArray:  %@",photoKeyArray);
        for (NSDictionary* eachPhotoDictionary in photoKeyArray)
        {
            Photo *photoObject = [[Photo alloc] init];
            photoObject.photoAnimalCategory = searchTerm;
            NSString *farm = [eachPhotoDictionary objectForKey:@"farm"];
            NSString *server = [eachPhotoDictionary objectForKey:@"server"];
            NSString *photoId = [eachPhotoDictionary objectForKey:@"id"];
            NSString *secret = [eachPhotoDictionary objectForKey:@"secret"];
//            NSString *httpThumbnailString = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_t.jpg", farm,server,photoId,secret];
//            NSURL *photoThumbnailURL = [NSURL URLWithString:httpThumbnailString];
//            UIImage *photoThumbnailImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:photoThumbnailURL]];
//            photoObject.photoThumbnailImage = photoThumbnailImage;
            NSString *httpString = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_m.jpg", farm,server,photoId,secret];
            photoObject.photoURLString = httpString;
            NSURL *photoURL = [NSURL URLWithString:httpString];
            UIImage *photoImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:photoURL]];
//            photoObject.photoImage = photoImage;
            NSData *convertedImageData = UIImagePNGRepresentation(photoImage);
            photoObject.photoImageData = convertedImageData;
            
            photoObject.photoTitle = [eachPhotoDictionary objectForKey:@"title"];
            photoObject.photographer = [eachPhotoDictionary objectForKey:@"owner"];
            [arrayOfPhotoObjects addObject:photoObject];
        }
        [self.delegate photoDataManagerDidFinishGettingPhotos:arrayOfPhotoObjects];
    }];
}


@end
