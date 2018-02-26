//
//  Modell.h
//  MVC
//
//  Created by Vera on 2/9/18.
//  Copyright © 2018 XeperTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Modell : NSObject


@property (strong, nonatomic) NSString *petName;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *typeofPet;

- (Modell*) initWithModell: (NSDictionary *)dict ;
@end
