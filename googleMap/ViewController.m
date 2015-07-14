//
//  ViewController.m
//  googleMap
//
//  Created by Gagandeep Kaur on 09/07/15.
//  Copyright (c) 2015 Gagandeep Kaur. All rights reserved.
//

#import "ViewController.h"
#import <googleMaps/googleMaps.h>

@interface ViewController ()
{
    GMSMapView *map;
    GMSCameraPosition *camera;
    GMSMarker *marker;
    NSMutableArray * arrPredictions;
    
    NSString * location;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    camera = [GMSCameraPosition cameraWithLatitude:30.733315 longitude:76.779418 zoom:15];
    map = [GMSMapView mapWithFrame:_myMap.bounds camera:camera];
    marker = [[GMSMarker alloc] init];
    marker.position = camera.target;
    marker.snippet = @"Chandigarh";
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = map;
    [self.myMap addSubview:map];
    _tablePredictions.hidden = YES;
    
}

-(void)viewWillLayoutSubviews
{
    [map removeFromSuperview];
    [map setFrame:self.myMap.bounds];
    [self.myMap addSubview:map];
}

- (void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
       name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
       name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

#pragma mark - button actions and geocoding

- (IBAction)actionBtnSearchLoc:(id)sender {
    
    [_TFSearcLoc endEditing:YES];
    _tablePredictions.hidden = YES;
    location = _TFSearcLoc.text;
    [self geocode:(location)];
}

- (void)geocode : (NSString *) address{
    
    if(self.geocoder == nil)
    {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if(placemarks.count > 0)
        {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            CLLocationCoordinate2D coordinate = placemark.location.coordinate;
            camera = [GMSCameraPosition cameraWithTarget:coordinate zoom:15];
            marker.position = camera.target;
            [map animateToCameraPosition:camera];
            
        }
        else if (error.domain == kCLErrorDomain)
        {
            switch (error.code)
            {
                case kCLErrorDenied:
                    NSLog(@"Location Services Denied by User");
                    break;
                case kCLErrorNetwork:
                    NSLog(@"No Network");
                    break;
                case kCLErrorGeocodeFoundNoResult:
                    NSLog(@"No Result Found");
                    break;
                default:
                    NSLog(@"%@",error.localizedDescription);
                    break;
            }
        }
        else
        {
            NSLog(@"%@",error.localizedDescription);
            
        }
        
    }];

}

#pragma mark - keyboard methods

- (void)keyboardDidShow:(NSNotification*)notification
{
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGRect rect = _tablePredictions.frame;
    rect.size.height = _tablePredictions.frame.size.height - kbSize.height - 20;
    _tablePredictions.frame = rect;
    NSLog(@"%f", _tablePredictions.frame.size.height);
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGRect rect = _tablePredictions.frame;
    rect.size.height = _tablePredictions.frame.size.height + kbSize.height;
    _tablePredictions.frame = rect;
}

#pragma mark - textfield delegates

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

- (void)APIrequest : (NSString *) address{
   
    address = _TFSearcLoc.text;
    DataModal * dataModal= [[DataModal alloc] init];
    [dataModal callAPI:(address) :^(NSDictionary *response_success) {
        
        NSLog(@"%@",response_success);
        arrPredictions = [[response_success valueForKey:@"predictions"] mutableCopy];
        [_tablePredictions reloadData];
        NSLog(@"%d",[arrPredictions count]);
    }:^(NSError *response_error) {
        NSLog(@"Couldn't Load Images");
        
    }];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *address = textField.text;
    if(address == NULL){
        
        return NO;
    }
    else if (address.length > 0){
        [self APIrequest:(textField.text)];
        _tablePredictions.hidden = NO;
    }
    return YES;
}

#pragma mark - table view delegates and datasources

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (customTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    customTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"customTableViewCell"];
    cell.labelPredictions.text = [[arrPredictions objectAtIndex:indexPath.row] valueForKey:@"description"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    customTableViewCell *selectedCell=[tableView cellForRowAtIndexPath:indexPath];
    _tablePredictions.hidden = YES;
    location = selectedCell.labelPredictions.text;
    [self geocode:(location)];
    [self.view endEditing:YES];
    
}


@end
