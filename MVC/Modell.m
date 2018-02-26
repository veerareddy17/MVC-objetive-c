//
//  Modell.m
//  MVC
//
//  Created by Vera on 2/9/18.
//  Copyright © 2018 XeperTechnologies. All rights reserved.
//

#import "Modell.h"

@implementation Modell
@synthesize petName,typeofPet,gender;
- (Modell*) initWithModell: (NSDictionary *)dict {
    
    Modell *modell = [Modell new];
    
    if (modell) {
        modell.petName = dict[@"1302"];
        modell.gender = dict[@"1307"];;
        modell.typeofPet = dict[@"1304"];;
    }
    return modell;
}
@end
