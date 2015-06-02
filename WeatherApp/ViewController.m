//
//  ViewController.m
//  WeatherApp
//
//  Created by Benjamin Steephenson on 5/29/15.
//  Copyright (c) 2015 Benjamin Steephenson. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSString *url = @"http://api.openweathermap.org/data/2.5/weather?q=Andover,ma&APPID=913cc0d4d446251a48b609496e946977";
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//    NSError *err;
//    if(data != nil)
//    {
//        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
//        if([json isKindOfClass:[NSArray class]]){
//            NSLog(@"array");
//        }
//        else if([json isKindOfClass:[NSDictionary class]]){
//            NSDictionary *dict = json;
//            self.someLabel.text = [[[dict objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"description"];
//        }
//    }
//    else
//    {
//        self.someLabel.text = @"Invalid request";
//    }
//
    self.textField.delegate = self;
//    [self.textField becomeFirstResponder];
    self.progressCircle.hidesWhenStopped = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)getWeather:(id)sender {

    self.progressCircle.hidden = NO;
    [self.progressCircle startAnimating];

    NSString *place = self.textField.text;

    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&APPID=913cc0d4d446251a48b609496e946977", place];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [urlSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [self performSelectorOnMainThread:@selector(afterDataTaskIsFinishedWithData:) withObject:data waitUntilDone:NO];
        
    }];
    
    [task resume];
    
}

- (void)afterDataTaskIsFinishedWithData:(NSData *)data
{
    NSError *err;
    if(data != nil)
    {
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        if([json isKindOfClass:[NSArray class]]){
            NSLog(@"array");
        }
        else if([json isKindOfClass:[NSDictionary class]]){
            NSDictionary *dict = json;
            self.someLabel.text = [[[dict objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"description"];
            float longitude =  [[[dict objectForKey:@"coord"] objectForKey:@"lon"] floatValue];
            float latitude =  [[[dict objectForKey:@"coord"] objectForKey:@"lat"] floatValue];
            
            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latitude, longitude);
            
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, pow(10, 5), pow(10, 5));
            [self.map setRegion:region animated:YES];
            
            
        }
    }
    else
    {
        self.someLabel.text = @"Invalid request";
    }
    
    [self.progressCircle stopAnimating];

}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    return YES;
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
