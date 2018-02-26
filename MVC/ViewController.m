//
//  ViewController.m
//  MVC
//
//  Created by Vera on 2/9/18.
//  Copyright © 2018 XeperTechnologies. All rights reserved.
//

#import "ViewController.h"
#import "Modell.h"
#import "CustomCell.h"
#import "SecViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tblVC;
@property(nonatomic,strong) Modell *model;
@end

@implementation ViewController
{
    NSMutableArray *petsData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [Modell new];
    self.tblVC.delegate = self;
    self.tblVC.dataSource = self;
    petsData = [NSMutableArray new];
   
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
   
}
-(void)getFetcingPetsData{
    
    NSString *mystring = [NSString stringWithFormat:@"method=%@&profile_id=%@",@"fetchingpets",@"1000000002"];
    
    //NSString *mystring = [NSString stringWithFormat:@"mobile_number=%@",_mobile_num_txt.text];
    NSData *bodyData = [mystring dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSMutableDictionary *dictionnary = [NSMutableDictionary dictionary];
    [dictionnary setObject:mystring forKey:@"method"];
    [dictionnary setObject:mystring forKey:@"profile_id"];
    //URL CONFIG
    NSString *serverURL = @"https://www.healthaadhar.com/login/health_core_files/json.php";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: serverURL]];
    //POST DATA SETUP
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:bodyData];
    NSLog(@"Trying to call us %@",serverURL);
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          NSString *responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
          NSLog(@"Data received: %@", responseStr);
          NSError *erro = nil;
          
          if (data!=nil) {
              
              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&erro ];
              NSLog(@"Data received: %@", json);
              NSArray * info = [json valueForKey:@"info"];
              NSLog(@"info received: %@", info);
              for ( int i = 0; i <  info.count; i++ ){
               id data = [self.model initWithModell:info[i]];
                  NSLog(@"%@",[data typeofPet]);
                  [petsData addObject:data];
                  NSLog(@"%lu",(unsigned long)petsData.count);
                 // NSLog(@"%@",[])
              }
              //dispatch_async(dispatch_get_main_queue()
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.tblVC reloadData];
                  
              });
          }
          
      }] resume];
    
}
- (IBAction)apiCall:(UIButton *)sender {
     [self getFetcingPetsData];
}

//Mark:- uitableview delegates and datasource
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellId = @"CustomCell";

    CustomCell *customCell = [self.tblVC dequeueReusableCellWithIdentifier:
                            cellId];
    customCell.name.text = [[petsData objectAtIndex:indexPath.row] typeofPet];
     return customCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return petsData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecViewController *secVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SecViewController"];
    [self.navigationController pushViewController:secVC animated:YES];
}




@end
