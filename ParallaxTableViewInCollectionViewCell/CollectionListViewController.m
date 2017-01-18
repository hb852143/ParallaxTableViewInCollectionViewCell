//
//  CollectionListViewController.m
//  bigCollectionViewTest
//
//  Created by hank.chang on 2016/12/27.
//  Copyright © 2016年 hank.chang. All rights reserved.
//

#import "CollectionListViewController.h"
#import "ItemCell.h"
#import "CollectionPageViewController.h"
@interface CollectionListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UICollectionView *listCollectionView;
@property(strong,nonatomic)NSArray *imageArr;

@end

@implementation CollectionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    self.imageArr =[ NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4", nil];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
 
    return self.imageArr.count;

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCell" forIndexPath:indexPath];
    cell.itemImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.imageArr objectAtIndex:indexPath.row]]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CollectionPageViewController *page = [storyboard instantiateViewControllerWithIdentifier:@"CollectionPageViewController"];
    page.imageArr = self.imageArr;
    page.indexPath = indexPath;
    [self.navigationController pushViewController:page animated:YES];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  CGSizeMake(self.listCollectionView.frame.size.width, self.listCollectionView.frame.size.width/16*9);

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
