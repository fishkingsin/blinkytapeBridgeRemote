//
//  PatternPaintAppViewController.m
//  blinkytapeRPiRemote
//
//  Created by Kong king sin on 24/9/14.
//
//
#import "ofxiOSExtras.h"
#import "PatternPaintAppViewController.h"
#import "PatternPaintApp.h"
@interface PatternPaintAppViewController ()

@end

@implementation PatternPaintAppViewController
- (id)initWithCoder:(NSCoder*)aDecoder
{
    return self = [super initWithFrame:[[UIScreen mainScreen] bounds] app:new PatternPaintApp()];
}
- (id) initWithFrame:(CGRect)frame app:(ofxiOSApp *)app {
    
    ofxiOSGetOFWindow()->setOrientation( OF_ORIENTATION_DEFAULT );   //-- default portait orientation.
    
    return self = [super initWithFrame:frame app:app];
    
}
- (void)menuAction
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

    // Move origin by 100 on both axis
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self.navigationController.navigationItem setLeftBarButtonItem : [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(menuAction)] animated:YES];
    // Do any additional setup after loading the view from its nib.
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.topItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage: [UIImage imageNamed:@"menu"]style:UIBarButtonItemStylePlain target:self action:@selector(menuAction)];
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
