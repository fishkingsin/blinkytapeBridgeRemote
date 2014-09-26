//
//  MenuViewController.m
//  Created by lukasz karluk on 12/12/11.
//

#import "MyAppViewController.h"
#import "ColorChooserAppViewController.h"
#import "ColorChooserApp.h"
#import "PatternPaintAppViewController.h"
#import "PatternPaintApp.h"

@implementation MyAppViewController

- (UIButton*) makeButtonWithFrame:(CGRect)frame 
                          andText:(NSString*)text {
    
    UILabel *label;
    label = [[ UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)] ;
    label.backgroundColor = [UIColor colorWithWhite:1 alpha:0.95];
    label.textColor = [UIColor colorWithWhite:0 alpha:1];
    label.text = [text uppercaseString];
    label.textAlignment = NSTextAlignmentCenter;

    label.userInteractionEnabled = NO;
    label.exclusiveTouch = NO;
    
    UIButton* button = [[UIButton alloc] initWithFrame:frame] ;
    [button setBackgroundColor:[UIColor clearColor]];
    [button addSubview:label];
    
    return button;
}

- (void)loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor clearColor];
    

    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    CGRect scrollViewFrame = CGRectMake(0.f,
                                        0.f,
                                        screenRect.size.width,
                                        screenRect.size.height);
    
    UIScrollView* containerView = [[UIScrollView alloc] initWithFrame:scrollViewFrame] ;
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    containerView.showsHorizontalScrollIndicator = NO;
    containerView.showsVerticalScrollIndicator = YES;
    containerView.alwaysBounceVertical = YES;
    [self.view addSubview:containerView];

    NSArray *buttonTitles;
    buttonTitles = [NSArray arrayWithObjects: @"ColorChooser",@"PatternPaint", nil];
    
    NSInteger buttonY = 0;     // make room for navigation bar.
    NSInteger buttonGap = 2;
    NSInteger buttonHeight = (screenRect.size.height - 44) / [buttonTitles count] - buttonGap * ([buttonTitles count] - 1);
    CGRect buttonRect = CGRectMake(0, 0, screenRect.size.width, buttonHeight);
    
    for (int i = 0; i < [buttonTitles count]; i++) {
        UIButton *button;
        button = [self makeButtonWithFrame:CGRectMake(0, buttonY, buttonRect.size.width, buttonRect.size.height)
                                   andText:[buttonTitles objectAtIndex:i]];
        [containerView addSubview:button ];
        
        switch(i)
        {
            case 0:
            [button addTarget:self action:@selector(button1Pressed:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 1:
            [button addTarget:self action:@selector(button2Pressed:) forControlEvents:UIControlEventTouchUpInside];
                break;
        }
        
        buttonY += buttonRect.size.height;
        buttonY += buttonGap;
    }
    
    containerView.contentSize = CGSizeMake(buttonRect.size.width, buttonRect.size.height * buttonTitles.count);
   
}

- (void)button1Pressed:(id)sender {
    ColorChooserAppViewController *viewController;
    viewController = [[ColorChooserAppViewController alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                                                 app:new ColorChooserApp()] ;
    
    [self.navigationController pushViewController:viewController animated:YES];
    //self.navigationController.navigationBar.topItem.title = @"ColorChooserApp";
}

- (void)button2Pressed:(id)sender {
    
    PatternPaintAppViewController *viewController;
    viewController = [[PatternPaintAppViewController alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                                                       app:new PatternPaintApp()] ;

    [self.navigationController pushViewController:viewController animated:YES];
    //self.navigationController.navigationBar.topItem.title = @"ColorChooserApp";
    

}

- (void)menuAction
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    BOOL bRotate = NO;
    bRotate = bRotate || (toInterfaceOrientation == UIInterfaceOrientationPortrait);
    bRotate = bRotate || (toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
    return bRotate;
}

@end
