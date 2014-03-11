//
//  SBViewController.m
//  SampleScrollTest
//
//  Created by Suraj on 10/03/14.
//  Copyright (c) 2014 Suraj. All rights reserved.
//

#import "SBViewController.h"

static CGSize const kICEChannelItemSize = {.width = 80.0, .height = 80.0};

@interface SBViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *datasourceArray;

@end

@implementation SBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    self.datasourceArray = [NSMutableArray new];
    for (int i=0; i<20; i++) {
        NSNumber  *aNumber = [NSNumber numberWithInt:i];
        [self.datasourceArray addObject:aNumber];
    }
    
    LXReorderableCollectionViewFlowLayout *layout =
    [[LXReorderableCollectionViewFlowLayout alloc] init];
	[layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
	[layout setItemSize:kICEChannelItemSize];
	[layout setMinimumLineSpacing:10.0];
    
    [self.collectionView setCollectionViewLayout:layout];
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datasourceArray.count;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"
                                                                           forIndexPath:indexPath];
    
    NSNumber *aNumber = self.datasourceArray[indexPath.item];
    
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:101];
    if (nil == titleLabel) {
        titleLabel = [UILabel new];
        [titleLabel setFrame:cell.bounds];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setTag:101];
        [cell.contentView addSubview:titleLabel];
    }
    
    [titleLabel setFrame:cell.bounds];
    [titleLabel setText:[NSString stringWithFormat:@"%d", aNumber.intValue]];
    cell.backgroundColor =[UIColor greenColor];
    return cell;
}

-(void) collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath
{
    NSNumber *aNumber = self.datasourceArray[fromIndexPath.item];
    [self.datasourceArray removeObject:aNumber];
    [self.datasourceArray insertObject:aNumber atIndex:toIndexPath.item];
}
@end
