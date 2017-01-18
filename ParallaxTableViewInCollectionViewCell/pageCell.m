//
//  pageCell.m
//  bigCollectionViewTest
//
//  Created by hank.chang on 2016/12/27.
//  Copyright © 2016年 hank.chang. All rights reserved.
//
#define headerImageHeight [UIScreen mainScreen].bounds.size.width/16*9
#import "pageCell.h"
#import "CollectionPageViewController.h"
@implementation pageCell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell;
    if(indexPath.row == 0){
        static NSString * headerId = @"headerCell";
        cell = [tableView dequeueReusableCellWithIdentifier:headerId];
        if(!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:headerId];
            cell.backgroundColor = [UIColor clearColor];
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,[UIScreen mainScreen].bounds.size.width,headerImageHeight)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.tag = 11;
            imageView.clipsToBounds = YES;
            imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            UIScrollView * scrollViewImage = [[UIScrollView alloc]initWithFrame:imageView.frame];
            scrollViewImage.delegate = self;
            scrollViewImage.userInteractionEnabled = NO;
            
            [scrollViewImage addSubview:imageView];
            
            scrollViewImage.tag = 22;
            scrollViewImage.backgroundColor = [UIColor blackColor];
            scrollViewImage.zoomScale = 1.0f;
            scrollViewImage.minimumZoomScale = 1.0f;
            scrollViewImage.maximumZoomScale = 2.0f;
            [cell.contentView addSubview:scrollViewImage];

        }
        UIImageView *imageView = (UIImageView*)[cell viewWithTag:11];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.imaArr objectAtIndex:self.indexPath]]];
        return cell;
        
    }else{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%lu",indexPath.row];
        cell.highlighted = NO;
    return cell;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return headerImageHeight;
    }
    return 200.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return;
    }else{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CollectionPageViewController *page = [storyboard instantiateViewControllerWithIdentifier:@"CollectionPageViewController"];
    page.imageArr = self.imaArr;

    page.indexPath = indexPath;
    
    [self.nav pushViewController:page animated:YES];
    }
}
- (void)cellOncollectionView:(UICollectionView *)collectionView didScrollOnView:(UIView *)view
{
    CGRect rectInSuperview = [collectionView convertRect:self.frame toView:view];
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    UIScrollView * svImage = (UIScrollView*)[cell viewWithTag:22];
    float distanceFromCenter = CGRectGetWidth(view.frame)/2 - CGRectGetMinX(rectInSuperview);
    float difference = CGRectGetWidth(svImage.frame) - CGRectGetWidth(self.frame)/16*9;
    float move = (distanceFromCenter / CGRectGetWidth(view.frame)) * difference;
    
    CGRect imageRect = svImage.frame;
    imageRect.origin.x = -(difference/2)+move;
    svImage.frame = imageRect;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.tag == 22) return;
    UITableView * tabViewScrollView = (UITableView*) scrollView;
    UITableViewCell * cell = [tabViewScrollView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    UIScrollView * scrollViewImage = (UIScrollView*)[cell viewWithTag:22];
    CGRect frame = scrollViewImage.frame;
    frame.size.height =  MAX((headerImageHeight-tabViewScrollView.contentOffset.y),0);
    frame.origin.y = tabViewScrollView.contentOffset.y;
    scrollViewImage.frame = frame;
    scrollViewImage.zoomScale = 1 + (fabs(MIN(tabViewScrollView.contentOffset.y,0))/320.0f);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [scrollView viewWithTag:11];
}



@end
