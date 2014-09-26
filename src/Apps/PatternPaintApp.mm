//
//  PatternPaintApp.cpp
//  blinkytapeRPiRemote
//
//  Created by Kong king sin on 24/9/14.
//
//

#include "PatternPaintApp.h"
int step = 0;
PatternPaintApp::PatternPaintApp()
{
    
}
PatternPaintApp::~PatternPaintApp()
{
    
}
//--------------------------------------------------------------
void PatternPaintApp::setup(){
    isConnected = false;
    step = ofGetWidth()/MAX_LED;
    ofAddListener(ofxBonjour::Events().onServicesDiscovered, this, &PatternPaintApp::discoveredServices);
    ofAddListener(ofxBonjour::Events().onServiceDiscovered, this, &PatternPaintApp::gotServiceData );
    port = 11999;
    bonjourClient.discover("_blinkytape._tcp.");
    
    sender.Create();
    sender.SetNonBlocking(true);
    
    
    
    _host = "";
    currentCol = 0;
    pixel.allocate(MAX_LED, MAX_LED, OF_IMAGE_COLOR);
    pixel.setColor(ofColor::black);
//    for(int i = 0 ; i < MAX_LED ; i++)
//    {
//        for(int j = 0 ; j < MAX_LED ; j++)
//        {
//            pixel.setColor(i, j, ofColor((sin(j*1.0f/MAX_LED))*(255),(cos(i*1.0f/MAX_LED))*(255),0));
//        }
//        
//    }
    img.setFromPixels(pixel);
}

//--------------------------------------------------------------
void PatternPaintApp::update(){
    currentCol++;
    currentCol%=MAX_LED;
    if(isConnected)
    {
        unsigned char LED[MAX_LENGTH];
        
        for(int i = 0 ; i < MAX_LED ; i ++)
        {
            ofColor c = pixel.getColor(currentCol,i);
            LED[i*3] = (c.r>254)?254:c.r;
            LED[i*3+1] = (c.g>254)?254:c.g;
            LED[i*3+2] = (c.b>254)?254:c.b;
        }
        LED[MAX_LENGTH-1] = 255;
        sender.Send((char*)LED,MAX_LENGTH);
    }
}

//--------------------------------------------------------------
void PatternPaintApp::draw(){
    img.draw(0, 0, ofGetWidth(),ofGetWidth());
    ofPushStyle();
    ofNoFill();
    ofSetLineWidth(1);
    ofSetColor(255);
    ofRect(currentCol*step, 0, step, ofGetWidth());
    ofPopStyle();
}

//--------------------------------------------------------------
void PatternPaintApp::exit(){
    //have to remove listener with deallocate
    _host = "";
    
    
    sender.Close();
    img.clear();
    pixel.clear();
    //have to remove listener with deallocate
    ofRemoveListener(ofxBonjour::Events().onServicesDiscovered, this, &PatternPaintApp::discoveredServices);
    ofRemoveListener(ofxBonjour::Events().onServiceDiscovered, this, &PatternPaintApp::gotServiceData );
}

//--------------------------------------------------------------
void PatternPaintApp::touchDown(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void PatternPaintApp::touchMoved(ofTouchEventArgs & touch){
    int x = ofMap(touch.x, 0, ofGetWidth(), 0, MAX_LED);
    int y = ofMap(touch.y, 0, ofGetWidth(), 0, MAX_LED);
    pixel.setColor(x, y, ofColor::white);
    img.setFromPixels(pixel);
}

//--------------------------------------------------------------
void PatternPaintApp::touchUp(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void PatternPaintApp::touchDoubleTap(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void PatternPaintApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void PatternPaintApp::lostFocus(){
    
}

//--------------------------------------------------------------
void PatternPaintApp::gotFocus(){
    
}

//--------------------------------------------------------------
void PatternPaintApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void PatternPaintApp::deviceOrientationChanged(int newOrientation){
    
}

//--------------------------------------------------------------
void PatternPaintApp::discoveredServices( vector<NSNetService*> & services ){
    for (int i=0; i<services.size(); i++){
        ofLogVerbose(__PRETTY_FUNCTION__)<< [services[i].description cStringUsingEncoding:NSUTF8StringEncoding] << endl;
    }
}

//--------------------------------------------------------------
void PatternPaintApp::gotServiceData( Service & service ){
    ofLogVerbose(__PRETTY_FUNCTION__)<< service.ipAddress << ":" << service.port << endl;
    if(service.ipAddress != "0.0.0.0")
    {
        _host = service.ipAddress;
        
        isConnected = sender.Connect(_host.c_str(),port);
        
    }
}
