//
//  pageCell.h
//  bigCollectionViewTest
//
//  Created by hank.chang on 2016/12/27.
//  Copyright © 2016年 hank.chang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pageCell : UICollectionViewCell<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
float beginScoller;

}
@property (strong, nonatomic) IBOutlet UIButton *backbutton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)NSArray *imaArr;
@property (nonatomic, assign)NSInteger indexPath;
@property UINavigationController *nav;
@property (strong, nonatomic) IBOutlet UIImageView *headerimageView;
- (void)cellOncollectionView:(UICollectionView *)collectionView didScrollOnView:(UIView *)view;





    
 


@end
