//
//  GameController.m
//  AresBase Shared
//
//  Created by Kenn Villegas on 1/1/18.
//  Copyright © 2018 Kenn Villegas. All rights reserved.
//

#import "GameController.h"
//#import "KVGameScene.h"

#if TARGET_OS_WATCH
#import <WatchKit/WatchKit.h>
#endif

@interface GameController ()


@property (strong, nonatomic) id <SCNSceneRenderer> sceneRenderer;
// OKay so I am in the shared folder and I have , oops I just made KVGameView let me add this to the project.
//@property (strong, nonatomic) KVGameScene *gameScene;

@property (strong, nonatomic) SCNView * view;
@property (strong, nonatomic) SCNNode * node;
@property (strong, nonatomic) SCNNode * cameraNode;
//@property  NSTimeInterval *aTimerInerval;

@end

@implementation GameController

@synthesize scene = _scene;
@synthesize view = _view;
@synthesize node = _node;
@synthesize cameraNode = _cameraNode;
//@synthesize aTimerInterval = _aTimerInterval;
#pragma mark -Powa
/**
As best I can figure this is where the application starts
_obviously it is a delegate
 
Dox-Wise, the GVCon in ios and osx have a pointer to here I just tagged them  with the idea to move the renderer clean out of the GUI Agan that is just a side effect. Either way I will want a KVCommonGameView or µ/Common/KVGameView
 Now that I have it how do I make it work in the view. I mean I have to init a KVGameView acutal not the one in the
OIC I made a initTest… and I can call it with the new API ¡Yay!
*/
- (instancetype)initWithOLDSceneRenderer:(id <SCNSceneRenderer>)sceneRenderer {
    self = [super init];
    if (self) {
        self.sceneRenderer = sceneRenderer;
        self.sceneRenderer.delegate = self;
        
        // create a new scene
        SCNScene *scene = [SCNScene sceneNamed:@"Art.scnassets/ship.scn"];
        
        // retrieve the ship node
        SCNNode *ship = [scene.rootNode childNodeWithName:@"ship" recursively:YES];
        
        // animate the 3d object
        [ship runAction:[SCNAction repeatActionForever:[SCNAction rotateByX:0 y:2 z:0 duration:1]]];
        
        self.scene = scene;
        self.sceneRenderer.scene = scene;
    }
    return (self);
}
/**
Classy bit of funk
*/
- (instancetype)initWithSceneRenderer:(id <SCNSceneRenderer>)sceneRenderer {
  self = [super init];
  if (!self){
    return nil;
  }
  self.sceneRenderer = sceneRenderer;
  self.sceneRenderer.delegate = self;

  SCNScene *jScene = [[SCNScene alloc]init];
  // retrieve the ship node
//  SCNNode *ship = [scene.rootNode childNodeWithName:@"ship" recursively:YES];
  //Make a fucking polygon
  self.scene = jScene;
  self.sceneRenderer.scene = jScene;
  return(self);
}

- (void)highlightNodesAtPoint:(CGPoint)point {
    NSArray<SCNHitTestResult *> *hitResults = [self.sceneRenderer hitTest:point options:nil];
    for (SCNHitTestResult *result in hitResults) {
        // get its material
        SCNMaterial *material = result.node.geometry.firstMaterial;
        
        // highlight it
        [SCNTransaction begin];
        [SCNTransaction setAnimationDuration:0.5];
        
        // on completion - unhighlight
        [SCNTransaction setCompletionBlock:^{
            [SCNTransaction begin];
            [SCNTransaction setAnimationDuration:0.5];
            
            material.emission.contents = [SCNColor blackColor];
            
            [SCNTransaction commit];
        }];
        
        material.emission.contents = [SCNColor redColor];
        
        [SCNTransaction commit];
    }
}

- (void)renderer:(id <SCNSceneRenderer>)renderer updateAtTime:(NSTimeInterval)time {
    // Called before each frame is rendered
}

@end
