//
//  SlideImagesViewController.m
//  All Info
//
//  Created by iPhones on 6/22/16.
//  Copyright © 2016 PS.com. All rights reserved.
//

#import "SlideImagesViewController.h"

@interface SlideImagesViewController ()
{
    int pageIndex;
    NSMutableArray *BannersArr;
    NSInteger tagnew;
    BOOL isFirst;
}

@end

@implementation SlideImagesViewController
@synthesize HomeScrollView;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=YES;
    BannersArr=self.Imagearr;
    pageIndex=self.Tag;
    isFirst = YES;
     [self SetupBanners];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollBannerAutomacally
{
    if (pageIndex<BannersArr.count || pageIndex>=0) {
        CGRect frame;
        frame.origin.x = self.view.frame.size.width * (pageIndex);
        frame.origin.y = 0;
        frame.size = self.view.frame.size;
        if (pageIndex==0) {
            [self.HomeScrollView scrollRectToVisible:frame animated:NO];
        }else{
            if (isFirst == YES) {
                [self.HomeScrollView scrollRectToVisible:frame animated:NO];
            }else{
                [self.HomeScrollView scrollRectToVisible:frame animated:YES];
            }
            
        }
        pageIndex++;
        if (pageIndex==BannersArr.count) {
            pageIndex=0;
        }
        
    }
    [self performSelector:@selector(scrollBannerAutomacally) withObject:nil afterDelay:10000];
    
}

-(void)stopNanner
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scrollBannerAutomacally) object:nil];
    
}



-(void)SetupBanners
{
    for (int i=0; i<BannersArr.count; i++) {
        UIImageView *Banner=[[UIImageView alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height-130)];
        
        Banner.clipsToBounds=YES;
        Banner.layer.masksToBounds = YES;
        UIImageView *imageVi = (UIImageView*)BannersArr[i];
        Banner.image=imageVi.image;
        Banner.contentMode=UIViewContentModeScaleAspectFit;
        //[Banner sd_setImageWithURL:[NSURL URLWithString:[[[AppDelegate sharedInstance].BannersArr objectAtIndex:i] objectForKey:@"slide_url"]] ];
        [self.HomeScrollView addSubview:Banner];
        Banner.userInteractionEnabled=YES;
//        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HandleTapOnBanner:)];
//        [Banner addGestureRecognizer:tap];
    }
    [self.HomeScrollView setContentSize:CGSizeMake(self.view.frame.size.width*BannersArr.count, self.view.frame.size.height-250)];
//    CGRect frame;
//    frame.origin.x = (self.view.frame.size.width * (pageIndex))-40;
//    frame.origin.y = 0;
//    frame.size.width = self.view.frame.size.width;
//    frame.size.height = self.view.frame.size.height-135;
//
//    [self.HomeScrollView scrollRectToVisible:frame animated:YES];
   // pageIndex=1;
    
    [self performSelector:@selector(scrollBannerAutomacally) withObject:nil afterDelay:0];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ActionOnback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
