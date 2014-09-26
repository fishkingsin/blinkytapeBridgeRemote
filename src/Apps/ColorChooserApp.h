//
//  ColorChooserApp.h
//  blinkytapeRPiRemote
//
//  Created by Kong king sin on 24/9/14.
//
//

#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"
#include "ofxBonjour.h"
#include "ofxNetwork.h"
using namespace ofxBonjour;
#define DELIM 1
#define MAX_LED (60)
#define MAX_LENGTH ((MAX_LED*3)+DELIM)
#define LINE 20

class ColorChooserApp : public ofxiOSApp {
    
    public:
    ColorChooserApp();
    ~ColorChooserApp();
    
    void setup();
    void update();
    void draw();
    void exit();
    
    void touchDown(ofTouchEventArgs &touch);
    void touchMoved(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);
    void touchDoubleTap(ofTouchEventArgs &touch);
    void touchCancelled(ofTouchEventArgs &touch);
    
    void lostFocus();
    void gotFocus();
    void gotMemoryWarning();
    void deviceOrientationChanged(int newOrientation);
    
    void discoveredServices( vector<NSNetService*> & services );
    void gotServiceData( Service & service );
    void setMode(int mode);
    Client bonjourClient;
    
    ofxUDPManager sender;
    string _host;
    int port;
    unsigned char LED[MAX_LENGTH];
    ofImage image;

};