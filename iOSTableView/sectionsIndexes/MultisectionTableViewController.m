//
//  MultisectionTableViewController.m
//  iOSTableView
//
//  Created by alex on 13/7/21.
//  Copyright © 2021 alex. All rights reserved.
//

#import "MultisectionTableViewController.h"
#import "MultisectionTableViewCell.h"
#import "Car.h"



@interface MultisectionTableViewController ()

/*We define core as a Dictionary that stores Sections where the key->value pairs will be for instance:
    Nissan -> [{ "model": "Sentra", "door":"4", "price": 176999.99}, {... ]
    Ford -> [{ ...]
 **/
@property (nonatomic, retain) NSMutableDictionary *core;
@property (nonatomic, retain) NSArray * alphabetIndexArray;

@end

@implementation MultisectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    /*
     In many cases you will get a Json datastructure to deal with.
     Let's suppose you have to deal with deal with the following json structure to populate your table.

     {
       "cars": {
         "Nissan": [
           {
             "model": "Sentra",
             "doors": 4,
             "price": 17699.99
           },
           {
             "model": "Maxima",
             "doors": 4,
             "price": 18399.99
           },
           {
             "model": "Skyline",
             "doors": 2,
             "price": 25400.00
           }
         ],
         "Ford": [
           {
             "model": "Taurus",
             "doors": 4,
             "price": 38000.00
           },
           {
             "model": "Escort",
             "doors": 4,
             "price": 34000.00
           }
         ],
         "Cheverolet": [
           {
             "model": "Alero",
             "doors": 4,
             "price": 15000.00
           },
           {
             "model": "Aveo",
             "doors": 4,
             "price": 13000.00
           }
         ],
         "Porsche": [
           {
             "model": "911 Carrera",
             "doors": 2,
             "price": 240000.00
           },
           {
             "model": "Cayenne",
             "doors": 4,
             "price": 190000.00
           },
           {
             "model": "Cayman",
             "doors": 4,
             "price": 200000.00
           }
         ],
         "Jaguar": [
           {
             "model": "Daimler",
             "doors": 4,
             "price": 250000.00
           },
           {
             "model": "X-type Estate",
             "doors": 4,
             "price": 245000.00
           }
         ]
       }
     }
     
     Therefore:
     
     The Title of your first section: "Nissan"
        First  Row in this section: "Sentra" and 4
        Second Row in this section: "Maxima" and 4
        Third  Row in this section: "Skyline" and 2
     
     The Title of your second section: "Ford"
        First  Row in this section: "Taurus" and 4
        Second Row in this section: "Escort" and 4
     */
    
    //Dictionary methods:  https://developer.apple.com/documentation/foundation/nsdictionary?language=objc
    
    //data example: https://github.com/matthlavacka/car-list/blob/master/car-list.json
    
    /**
        Objective-c working with JSON
       https://developpaper.com/detailed-explanation-of-objective-c-json-example/
     */
    
/*
    Start with a json with a few elements, later on use the next json containing more data:
    NSString* jsonString = @"{ \"cars\": { \"Nissan\": [{\"model\": \"Sentra\",\"doors\": 4,\"price\": 17699.99},{\"model\": \"Maxima\",\"doors\": 4,\"price\": 18399.99},{\"model\": \"Skyline\",\"doors\": 2,\"price\": 25400.00}],\"Ford\": [{\"model\": \"Taurus\",\"doors\": 4,\"price\": 38000.00},{\"model\": \"Escort\",\"doors\": 4,\"price\": 34000.00}]}}";

 */
    
    NSString* jsonString = @"{ \"cars\": { \"Nissan\": [{\"model\": \"Sentra\",\"doors\": 4,\"price\": 17699.99},{\"model\": \"Maxima\",\"doors\": 4,\"price\": 18399.99},{\"model\": \"Skyline\",\"doors\": 2,\"price\": 25400.00}],\"Ford\": [{\"model\": \"Taurus\",\"doors\": 4,\"price\": 38000.00},{\"model\": \"Escort\",\"doors\": 4,\"price\": 34000.00}],\"Chevrolet\": [{\"model\": \"Alero\",\"doors\": 4,\"price\": 15000.00},{\"model\": \"Aveo\",\"doors\": 4,\"price\": 13000.00}],\"Porsche\": [{\"model\": \"911 Carrera\",\"doors\": 2,\"price\": 240000.00},{\"model\": \"Cayenne\",\"doors\": 4,\"price\": 190000.00},{\"model\": \"Cayman\",\"doors\": 4,\"price\": 200000.00}],\"Jaguar\": [{\"model\": \"Daimler\",\"doors\": 4,\"price\": 250000.00},{\"model\": \"X-type Estate\",\"doors\": 4,\"price\": 245000.00}],\"Hyundai\": [{\"model\": \"Accent\",\"doors\": 4,\"price\": 10000.00},{\"model\": \"Elantra\",\"doors\": 4,\"price\": 13000.00},{\"model\": \"Altos\",\"doors\": 4,\"price\": 12999.99},{\"model\": \"Veloster\",\"doors\": 2,\"price\": 19000.00}],\"Hummer\": [{\"model\": \"H2\",\"doors\": 4,\"price\": 125000.00},{\"model\": \"H3\",\"doors\": 4,\"price\": 148000.00}],\"MINI\": [{\"model\": \"Cooper\",\"doors\": 2,\"price\": 48000.00},{\"model\": \"Cooper S\",\"doors\": 2,\"price\": 50000.00},{\"model\": \"Cooper D \",\"doors\": 2,\"price\": 54000.00}]}}";

     
    //We encode the information using UTF-8 in NSData which is a data object
    NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    //IMPORTANT: The object that is returned back by JSONObjectWithData method will be either a dictionary or an array
    //Therefore just use JSONObjectWithData and after check by using isKindOfClass

    NSError* error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    
    if(jsonObject != nil && error == nil){
        if([jsonObject isKindOfClass:[NSDictionary class]]){
            NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
            NSLog(@"Deserialized JSON Dictionary = %@", deserializedDictionary);
            
            _core = [deserializedDictionary valueForKey:@"cars"];
            NSLog(@"core: %@ ", [self core]);
            /*
             notice the absence of the pointer * this is because NSInteger is a enhance primitice data type, you can use the pointer if you want
             but you need to assign a memory address using the & symbol, like this: NSInteger *pointerToProcessID = &processID;
             */
            NSUInteger numberOfSections = [[self core] count];
            /**
             You can make use of the z and t modifiers to handle NSInteger and NSUInteger without warnings, on all architectures.

             You want to use %zd for signed, %tu for unsigned, and %tx for hex.
             **/
            
            NSLog(@"number of sections in my tableView: %tu", numberOfSections);
            
            /*
             next we need to find the number of elements in the Json per secction, given the section number
             Nissan (0),  Ford (1)  ...etc
            */
            
            NSArray* arrayWithSectionElements = [[self core] allValues][0];
            NSLog(@"Number of elements in the first section (element of the array at position 0) %tu", [arrayWithSectionElements count]);
            
            arrayWithSectionElements = [[self core] allValues][1];
            NSLog(@"Number of elements in the Second section (element of the array at position 1) %tu", [arrayWithSectionElements count]);
            
        }else
            if([jsonObject isKindOfClass:[NSArray class]]){
                NSArray * deserializedArray = (NSArray*) jsonObject;
                NSLog(@"Deserialized JSON Array = %@", deserializedArray);
            } else {
                NSLog(@"Ooops, we don't know how to deal with this issue");
            }
    }else
        if(error != nil){
            NSLog(@"There was an error when trying to deserialize the json string");
        }

    //creates an Array with the First Letter of each section
    [self createAlphabetArray];


}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [[self core] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[[self core] allValues][section] count];

}


//Here we will add the titleForHeaderInSection's method
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[self core] allKeys][section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* cellIdentifier = @"CarCellIdentifier";
    MultisectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if(cell == nil){
        cell = [[MultisectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    //getthe section name:
    NSString* brand = [[self core] allKeys][section];
    
    NSDictionary* myDictionary = [[self core] allValues][section][row];
    
    NSString* model = [myDictionary objectForKey:@"model"];
    NSNumber* doors = [myDictionary objectForKey:@"doors"];
    NSNumber* price = [myDictionary objectForKey:@"price"];
    
    
    
    NSLog(@"brand: %@, model: %@, doors: %@, price: %@", brand, model, doors, price);
    
    [[cell modelLabel] setText:model];
    [[cell doorsLabel] setText:[doors stringValue]];
    [[cell priceLabel] setText:[price stringValue] ];
    
    
    return cell;
}

/**
 Creates an array with Index of the car brands (Sections) [N, F, J ... ] N for Nissan, F for Ford, etc.
 */
-(void) createAlphabetArray{

    //we will initially use a NSMutableArray since works faster than NSArray
    NSMutableArray<NSString *> * tempFirstLetterArray = [[NSMutableArray alloc] init];

    NSArray* sectionsArray = [[self core] allKeys];
    for (NSString *section in sectionsArray) {
        NSString *firstLetter = [section substringToIndex:1];
        if(![tempFirstLetterArray containsObject:firstLetter]){
            [tempFirstLetterArray addObject:firstLetter];
        }
    }

    // Sort the array
    [tempFirstLetterArray sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    // Type casting NSMutableArray to NSArray
    // NSArray* myArray = [NSArray arrayWithArray:tempFirstLetterArray];
    _alphabetIndexArray = [NSArray arrayWithArray:tempFirstLetterArray];
}

//Let's add the indexTitles for the whole TableView, we need to implement the sectionIndexTitlesForTableView
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return [self alphabetIndexArray];
}


/**
    Whenever you press an item in the index table, we will need to implement the  sectionForSectionIndexTitle method.
    ios will provide us the index and value(title parameter) in the indexArray the user tapped
    We will have to return the index of the section that matches the value(title parameter) tapped
        If you want to perform this table scroll programmatically, use the following method:
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i] atScrollPosition:UITableViewScrollPositionTop
 
     Definition for:  tableView:sectionForSectionIndexTitle:atIndex:
     https://developer.apple.com/documentation/uikit/uitableviewdatasource/1614933-tableview?language=objc
 */
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    NSLog(@"title: %@, index: %li", title, index);
    NSArray* sectionsArray = [[self core] allKeys];
    
    NSInteger totalNumberOfSections = [sectionsArray count];
    for (int i = 0; i < totalNumberOfSections; i++) {
        NSString * sectionName = sectionsArray[i];
        NSString *letterString = [sectionName substringToIndex:1];
        if([letterString isEqualToString:title]){
            return i;
        }
    }
    return -1;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}`
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
