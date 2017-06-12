//
//  AllImgesViewController.m
//  All Info
//
//  Created by Mahendra Suryavanshi on 3/8/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import "AllImgesViewController.h"
#import "UIImageView+WebCache.h"
@interface AllImgesViewController ()
{
    int pageNo;
    int pageNo2;
    int pageIndex;
    int pageIndex2;
    BOOL scrollDirectionDetermined;
    BOOL scrollDirectionDetermined2;
    CGRect frame;
}

@end

@implementation AllImgesViewController
@synthesize Showimgs,ImagesArr,Img2New;

- (void)viewDidLoad {
    [super viewDidLoad];
    pageIndex=0;
    pageNo=1;
    pageIndex2=0;
    pageNo2=1;
    for (int i=0; i<ImagesArr.count; i++)
    {
        UIImageView* ImageView=[[UIImageView alloc]initWithFrame:CGRectMake((i*self.Showimgs.frame.size.width)+20, 10, 200, 200)];
        NSString *imageToLoad = [ImagesArr objectAtIndex:i];
        [ImageView sd_setImageWithURL:[NSURL URLWithString:imageToLoad] placeholderImage:[UIImage imageNamed:@"Red_header_dark.png"]];
        [ImageView setUserInteractionEnabled:YES];
        [self.Showimgs addSubview:ImageView];
    }
    self.Showimgs.contentSize=CGSizeMake(self.Showimgs.frame.size.width*ImagesArr.count, self.Showimgs.frame.size.height);
   
    // Do any additional setup after loading the view.
}
#pragma mark - scrollview delegates

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!scrollDirectionDetermined) {
        CGFloat pageWidth = self.Showimgs.frame.size.width;
        int page = floor((self.Showimgs.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        pageIndex = page;
        if (pageIndex==0) {
            
        }else{
            }
        if (pageIndex==ImagesArr.count-1)
        {
            
        }
        else{
        }
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    scrollDirectionDetermined = NO;
    scrollDirectionDetermined2 = NO;
}

-(void)LeftGestureForView:(id)sender
{
    
    UISwipeGestureRecognizer *Swipe=(UISwipeGestureRecognizer*)sender;
   // frame;
    if (Swipe.direction==UISwipeGestureRecognizerDirectionLeft) {
        if (pageIndex<ImagesArr.count) {
            
            //PreviousButton.alpha=1;
            if (ImagesArr.count==1) {
                // self.NextButton.alpha=0;
                //self.PreviousButton.alpha=0;
            }

            frame.origin.x = self.Showimgs.frame.size.width * (pageIndex+1);
            frame.origin.y = 0;
            frame.size = self.Showimgs.frame.size;
            [self.Showimgs scrollRectToVisible:frame animated:YES];
            pageIndex++;
            if (pageIndex==ImagesArr.count-1) {
                // NextButton.alpha=0;
            }
        }
        
    }
    
}

-(void)RightGestureForView:(id)sender
{
    UISwipeGestureRecognizer *Swipe=(UISwipeGestureRecognizer*)sender;
    if (Swipe.direction==UISwipeGestureRecognizerDirectionRight) {
        
        frame;
        if (pageIndex>0) {
            
            // NextButton.alpha=1;
            if (ImagesArr.count==1) {
                // self.NextButton.alpha=0;
                // self.PreviousButton.alpha=0;
            }
            frame.origin.x = self.Showimgs.frame.size.width * (pageIndex-1);
            frame.origin.y = 0;
            frame.size = self.Showimgs.frame.size;
            [self.Showimgs scrollRectToVisible:frame animated:YES];
            pageIndex--;
            
            if (pageIndex==0) {
                // PreviousButton.alpha=0;
            }
            
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
