//
//  ColorChooserApp.cpp
//  blinkytapeRPiRemote
//
//  Created by Kong king sin on 24/9/14.
//
//

#include "ColorChooserApp.h"
int n;
//--------------------------------------------------------------
ColorChooserApp :: ColorChooserApp () {
    cout << "creating ColorChooserApp" << endl;
}

//--------------------------------------------------------------
ColorChooserApp :: ~ColorChooserApp () {
    cout << "destroying ColorChooserApp" << endl;
    _host = "";

    
    sender.Close();
    
    image.clear();
    //have to remove listener with deallocate
    ofRemoveListener(ofxBonjour::Events().onServicesDiscovered, this, &ColorChooserApp::discoveredServices);
    ofRemoveListener(ofxBonjour::Events().onServiceDiscovered, this, &ColorChooserApp::gotServiceData );
}

//--------------------------------------------------------------
void ColorChooserApp::setup() {
    ofBackground(127);
    n = ofGetWidth()*ofGetHeight();
    ofSetLogLevel(OF_LOG_VERBOSE);
    ofAddListener(ofxBonjour::Events().onServicesDiscovered, this, &ColorChooserApp::discoveredServices);
    ofAddListener(ofxBonjour::Events().onServiceDiscovered, this, &ColorChooserApp::gotServiceData );
    port = 11999;
    bonjourClient.discover("_blinkytape._tcp.");
    
    sender.Create();
    sender.SetNonBlocking(true);

    
    
    _host = "";
    memset(LED, 0, MAX_LENGTH);

    image.allocate(ofGetWidth(), ofGetHeight(), OF_IMAGE_COLOR);
    setMode(4);
    
}
void ColorChooserApp::setMode(int mode) {
    float w = ofGetWidth();
    float h = ofGetHeight();
    float cx = w/2;
    float cy = h/2;
    float hue,sat,bri,angle,dist;
    ofColor c;
    
    for (float y=0; y<h; y++) {
        for (float x=0; x<w; x++) {
            switch (mode) {
                case 1: //linear hue gradient
                    c = ofColor::fromHsb(x/w*255,255,255);
                    break;
                    
                case 2: //linear hsb gradient
                    hue = x/w*255;
                    sat = ofMap(y,0,h/2,0,255,true);
                    bri = ofMap(y,h/2,h,255,0,true);
                    c = ofColor::fromHsb(hue,sat,bri);
                    break;
                    
                case 3: //radial hue gradient
                    angle = atan2(y-w/2,x-h/2)+PI;
                    c = ofColor::fromHsb(angle/TWO_PI*255,255,255);
                    break;
                    
                case 4: //radial hsb gradient
                    angle = atan2(y-h/2,x-w/2)+PI;
                    dist = ofDist(x,y,w/2,h/2);
                    hue = angle/TWO_PI*255;
                    sat = ofMap(dist,0,w/4,0,255,true);
                    bri = ofMap(dist,w/4,w/2,255,0,true);
                    c = ofColor::fromHsb(hue,sat,bri);
                    break;
            }
            
            image.setColor(x,y,c);
        }
    }
    image.update();
}
//--------------------------------------------------------------
void ColorChooserApp::update(){
    
}

//--------------------------------------------------------------
void ColorChooserApp::draw() {
    ofPushStyle();
    ofSetColor(255);
    image.draw(0, 0, ofGetWidth(), ofGetHeight());
    ofPopStyle();
}

//--------------------------------------------------------------
void ColorChooserApp::exit() {
    //
}

//--------------------------------------------------------------
void ColorChooserApp::touchDown(ofTouchEventArgs &touch){
    
}

//--------------------------------------------------------------
void ColorChooserApp::touchMoved(ofTouchEventArgs &touch){

    ofColor c = image.getColor(touch.x, touch.y);
    for(int i = 0 ; i < MAX_LED ; i ++)
    {

        LED[i*3] = (c.r>254)?254:c.r;
        LED[i*3+1] = (c.g>254)?254:c.g;
        LED[i*3+2] = (c.b>254)?254:c.b;
    }
    LED[MAX_LENGTH-1] = 255;
    sender.Send((char*)LED,MAX_LENGTH);

}

//--------------------------------------------------------------
void ColorChooserApp::touchUp(ofTouchEventArgs &touch){
    
}

//--------------------------------------------------------------
void ColorChooserApp::touchDoubleTap(ofTouchEventArgs &touch){
    
}

//--------------------------------------------------------------
void ColorChooserApp::lostFocus(){
    
}

//--------------------------------------------------------------
void ColorChooserApp::gotFocus(){
    
}

//--------------------------------------------------------------
void ColorChooserApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void ColorChooserApp::deviceOrientationChanged(int newOrientation){
    
}


//--------------------------------------------------------------
void ColorChooserApp::touchCancelled(ofTouchEventArgs& args){
    
}

//--------------------------------------------------------------
void ColorChooserApp::discoveredServices( vector<NSNetService*> & services ){
    for (int i=0; i<services.size(); i++){
        ofLogVerbose(__PRETTY_FUNCTION__)<< [services[i].description cStringUsingEncoding:NSUTF8StringEncoding] << endl;
    }
}

//--------------------------------------------------------------
void ColorChooserApp::gotServiceData( Service & service ){
    ofLogVerbose(__PRETTY_FUNCTION__)<< service.ipAddress << ":" << service.port << endl;
    if(service.ipAddress != "0.0.0.0")
    {
        _host = service.ipAddress;
        
        sender.Connect(_host.c_str(),port);
        
    }
}
