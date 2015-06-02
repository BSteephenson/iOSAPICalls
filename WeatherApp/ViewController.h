//
//  ViewController.h
//  WeatherApp
//
//  Created by Benjamin Steephenson on 5/29/15.
//  Copyright (c) 2015 Benjamin Steephenson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *someLabel;
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) IBOutlet UITextField *textField;
- (IBAction)getWeather:(id)sender;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *progressCircle;

@end

