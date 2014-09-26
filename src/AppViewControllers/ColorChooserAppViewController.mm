//
//  ColorChooserAppViewController.m
//  blinkytapeRPiRemote
//
//  Created by Kong king sin on 24/9/14.
//
//
#import "ofxiOSExtras.h"
#import "ColorChooserAppViewController.h"
#import "ColorChooserApp.h"
@implementation ColorChooserAppViewController
- (id)initWithCoder:(NSCoder*)aDecoder
{
    return self = [super initWithFrame:[[UIScreen mainScreen] bounds] app:new ColorChooserApp()];
}
- (id) initWithFrame:(CGRect)frame app:(ofxiOSApp *)app {
    
    ofxiOSGetOFWindow()->setOrientation( OF_ORIENTATION_DEFAULT );   //-- default portait orientation.
    
    return self = [super initWithFrame:frame app:app];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return NO;
}


@end
