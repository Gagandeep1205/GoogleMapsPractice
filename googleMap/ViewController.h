//
//  ViewController.h
//  googleMap
//
//  Created by Gagandeep Kaur on 09/07/15.
//  Copyright (c) 2015 Gagandeep Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <googleMaps/googleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import "DataModal.h"
#import "customTableViewCell.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, UIKeyInput>

@property (weak, nonatomic) IBOutlet UITextField *TFSearcLoc;
@property (weak, nonatomic) IBOutlet UIButton *btnSearchLoc;
- (IBAction)actionBtnSearchLoc:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *myMap;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (weak, nonatomic) IBOutlet UITableView *tablePredictions;
@property (weak, nonatomic) IBOutlet customTableViewCell *actionCustomCell;

@end

