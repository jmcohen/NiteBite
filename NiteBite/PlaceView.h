//
//  PlaceView.h
//  NiteBite
//
//  Created by Jeremy Cohen on 2/2/13.
//  Copyright (c) 2013 Jeremy Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Place;

@interface PlaceView : UIView {
    Place *place;
}

@property (nonatomic, strong) Place *place;

@end
