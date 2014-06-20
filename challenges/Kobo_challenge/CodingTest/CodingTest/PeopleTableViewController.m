//
//  PeopleTableViewController.m
//  CodingTest
//
//  Created by Charles Joseph on 2014-06-09.
//  Copyright (c) 2014 Kobo Inc. All rights reserved.
//

#import "PeopleTableViewController.h"

typedef enum displayType {
    PEOPLE,
    SUBJECTS,
    SUBJECT_PEOPLE
} TableType;

@interface PeopleTableViewController () <UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
    UISegmentedControl *_segmentedControl;
    NSArray *_allPeople;
    NSArray *_filteredPeople;

    TableType tableDisplayType;
    NSArray *_allSubjects;
    NSMutableArray *_subject_people;
    UIButton *_backToSubjectsButton;
}
@end

@implementation PeopleTableViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tableDisplayType = PEOPLE;
    
    CGRect rect;
    
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"All", @"Students", @"Teachers", @"Subjects"]];
    rect = _segmentedControl.frame;
    rect.origin.x = 0; //(self.view.frame.size.width - rect.size.width) / 2;
    rect.origin.y = 25;
    _segmentedControl.frame = rect;
    _segmentedControl.selectedSegmentIndex = 0;
    [_segmentedControl addTarget:self action:@selector(segmentChanged) forControlEvents:UIControlEventValueChanged];
    
    _backToSubjectsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_backToSubjectsButton setTitle:@"Back" forState:UIControlStateNormal];
    rect = CGRectMake(_segmentedControl.frame.origin.x + _segmentedControl.frame.size.width, 25, self.view.frame.size.width-_segmentedControl.frame.size.width, _segmentedControl.frame.size.height);
    _backToSubjectsButton.frame = rect;
    [_backToSubjectsButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _backToSubjectsButton.hidden = YES;
    
    rect = self.view.bounds;
    rect.origin.y = CGRectGetMaxY(_segmentedControl.bounds) + 25;
    rect.size.height -= rect.origin.y;
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    //Debugging frame positioning
//    _segmentedControl.layer.borderColor = [UIColor blueColor].CGColor;
//    _segmentedControl.layer.borderWidth = 3;
//    _backToSubjectsButton.layer.borderColor = [UIColor redColor].CGColor;
//    _backToSubjectsButton.layer.borderWidth = 3;
//    _tableView.layer.borderColor = [UIColor greenColor].CGColor;
//    _tableView.layer.borderWidth = 3;
    
    
    [self.view addSubview:_tableView];
    [self.view addSubview:_segmentedControl];
    [self.view addSubview:_backToSubjectsButton];
}

- (void)viewDidAppear:(BOOL)animated {
    if (_allPeople == nil) {
        
        NSMutableArray *allSubjects = [[NSMutableArray alloc] init];
        
        NSDictionary *testData = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"testData" ofType:@"plist"]];
        NSArray *peopleData = [testData valueForKey:@"people"];
        NSMutableArray *allPeople = [NSMutableArray arrayWithCapacity:peopleData.count];
        for (NSDictionary *personDictionary in peopleData) {
            if ([personDictionary valueForKey:@"tuition"] != nil) {
                Student *student = [[Student alloc] initWithName:personDictionary[@"name"]
                                                         tuition:personDictionary[@"tuition"]
                                                        subjects:personDictionary[@"subjects"]];
                [allPeople addObject:student];
            }
            else {
                Teacher *teacher = [[Teacher alloc] initWithName:personDictionary[@"name"]
                                                          salary:personDictionary[@"salary"]
                                                        subjects:personDictionary[@"subjects"]];
                [allPeople addObject:teacher];
            }
            
            // find all subjects
            for (NSString *subject in personDictionary[@"subjects"]) {
                [allSubjects addObject:subject];
            }
        }
        
        // remove duplicate subjects
        for (int i=0; i<allSubjects.count; i++) {
            NSString *aSubject = [allSubjects objectAtIndex:i];
            for (int j=i+1; j<allSubjects.count; j++) {
                NSString *anotherSubject = [allSubjects objectAtIndex:j];
                if ([aSubject isEqualToString:anotherSubject] == YES) {
                    [allSubjects removeObjectAtIndex:j];
                    j--;
                }
            }
        }
        
        _allSubjects = [allSubjects sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
        _allPeople = allPeople;
        _filteredPeople = _allPeople;
    }

    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    _allPeople = nil;
    _filteredPeople = nil;
}

-(void)buttonPressed:(UIButton*)pressedBtn {
    if (pressedBtn == _backToSubjectsButton) {
        tableDisplayType = SUBJECTS;
    }
    [_tableView reloadData];
}

- (void)segmentChanged {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (_segmentedControl.selectedSegmentIndex == 0) {
            _filteredPeople = _allPeople;
            tableDisplayType = PEOPLE;
        }
        else if (_segmentedControl.selectedSegmentIndex == 1) {
            NSMutableArray *filtered = [NSMutableArray array];
            for (id object in _allPeople) {
                if ([object isKindOfClass:[Student class]]) {
                    [filtered addObject:object];
                }
            }
            _filteredPeople = filtered;
            tableDisplayType = PEOPLE;
        }
        else if (_segmentedControl.selectedSegmentIndex == 2) {
            NSMutableArray *filtered = [NSMutableArray array];
            for (id object in _allPeople) {
                if ([object isKindOfClass:[Teacher class]]) {
                    [filtered addObject:object];
                }
            }
            _filteredPeople = filtered;
            tableDisplayType = PEOPLE;
        }
        else if (_segmentedControl.selectedSegmentIndex == 3) {
            tableDisplayType = SUBJECTS;
        }
        
        
        // should do UI changes on main thread
        dispatch_sync(dispatch_get_main_queue(), ^{
            _backToSubjectsButton.hidden = YES;
            [_tableView reloadData];
        });


    });
}

#pragma mark - UITableViewDelegate implementations
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    tableDisplayType = SUBJECT_PEOPLE;
    NSString *selectedSubject = _allSubjects[indexPath.row];
    
    if (_subject_people == nil) {
        _subject_people = [[NSMutableArray alloc] init];
    }
    [_subject_people removeAllObjects];
    
    for (int i=0; i<_allPeople.count; i++) {
        NSArray *subjects = [[_allPeople objectAtIndex:i] subjects];
        for (NSString *aSubject in subjects) {
            if ([selectedSubject isEqualToString:aSubject] == YES) {
                [_subject_people addObject:[[_allPeople objectAtIndex:i] name]];
            }
        }
    }
    
    _backToSubjectsButton.hidden = NO;
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource implementations
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rowCount = 0;
    if (tableDisplayType == PEOPLE) {
        rowCount = _filteredPeople.count;
    } else if (tableDisplayType == SUBJECTS) {
        rowCount = _allSubjects.count;
    } else if (tableDisplayType == SUBJECT_PEOPLE) {
        rowCount = _subject_people.count;
    }
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    if (tableDisplayType == PEOPLE) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellID_subtitle"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID_subtitle"];
        }
        
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", [_filteredPeople[indexPath.row] name], [_filteredPeople[indexPath.row] isKindOfClass:[Student class]] ? @"Student" : @"Teacher"];
        NSString *subjects = @"";
        for (NSString *subject in [_filteredPeople[indexPath.row] subjects]) {
            subjects = [subjects stringByAppendingFormat:@"%@, ", subject];
        }
        cell.detailTextLabel.text = subjects;
        
        [cell.textLabel sizeToFit];
        [cell.detailTextLabel sizeToFit];
    }
    else if (tableDisplayType == SUBJECTS) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellID_default"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID_default"];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [_allSubjects objectAtIndex:indexPath.row]];
        [cell.textLabel sizeToFit];
    }
    else if (tableDisplayType == SUBJECT_PEOPLE) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellID_default"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID_default"];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [_subject_people objectAtIndex:indexPath.row]];
        [cell.textLabel sizeToFit];
    }
    
    return cell;
}

@end
