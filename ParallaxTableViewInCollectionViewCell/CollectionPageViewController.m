//
//  CollectionPageViewController.m
//  bigCollectionViewTest
//
//  Created by hank.chang on 2016/12/27.
//  Copyright © 2016年 hank.chang. All rights reserved.
//

#import "CollectionPageViewController.h"
#import "pageCell.h"


@interface CollectionPageViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,CAAnimationDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *pageCollectionView;

@end

@implementation CollectionPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self.pageCollectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imageArr.count;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    pageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pageCell" forIndexPath:indexPath];

    [cell.tableView setContentOffset:CGPointZero];
    cell.imaArr = self.imageArr;
    cell.indexPath = indexPath.row;
    [cell.backbutton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    cell.nav =self.navigationController;
    [cell.tableView reloadData];
    
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  CGSizeMake(self.pageCollectionView.frame.size.width, self.pageCollectionView.frame.size.height);
    
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    NSArray *visibleCells = [self.pageCollectionView visibleCells];
    
    for (pageCell *cell in visibleCells) {
        [cell cellOncollectionView:self.pageCollectionView didScrollOnView:self.view];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
