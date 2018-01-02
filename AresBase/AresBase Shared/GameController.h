//
//  GameController.h
//  AresBase Shared
//
//  Created by Kenn Villegas on 1/1/18.
//  Copyright © 2018 Kenn Villegas. All rights reserved.
//

#import <SceneKit/SceneKit.h>


@interface GameController : NSObject <SCNSceneRendererDelegate>
@property (strong, nonatomic) SCNScene * scene; // Ok I kill't the other scene
//@property (strong, readonly) SCNScene *scene; whoops this is supposed to be r\o
@property (strong, readonly) id <SCNSceneRenderer> sceneRenderer;

- (instancetype)initWithSceneRenderer:(id <SCNSceneRenderer>)sceneRenderer;

- (void)highlightNodesAtPoint:(CGPoint)point;

@end
