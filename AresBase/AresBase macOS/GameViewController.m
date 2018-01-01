//
//  GameViewController.m
//  AresBase macOS
//
//  Created by Kenn Villegas on 1/1/18.
//  Copyright © 2018 Kenn Villegas. All rights reserved.
//

#import "GameViewController.h"
#import <SceneKit/SceneKit.h>
#import "GameController.h"

@interface GameViewController ()

@property (readonly) SCNView *gameView;
@property (strong, nonatomic) GameController *gameController;
/** OKAY Right, instead of - (SCNView *)gameView which is identical in both of these ocntrollers why not make this completely common havea KVCommonGameView AKA
self.gameController = [[GameController alloc] initWithSceneRenderer:self.gameView];
*/
@end

@implementation GameViewController

- (SCNView *)gameView {
    return (SCNView *)self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gameController = [[GameController alloc] initWithSceneRenderer:self.gameView];
    
    // Allow the user to manipulate the camera
    self.gameView.allowsCameraControl = YES;
    
    // Show statistics such as fps and timing information
    self.gameView.showsStatistics = YES;
    
    // Configure the view
    self.gameView.backgroundColor = [NSColor blackColor];
    
    // Add a click gesture recognizer
    NSClickGestureRecognizer *clickGesture = [[NSClickGestureRecognizer alloc] initWithTarget:self action:@selector(handleClick:)];
    NSMutableArray *gestureRecognizers = [NSMutableArray array];
    [gestureRecognizers addObject:clickGesture];
    [gestureRecognizers addObjectsFromArray:self.gameView.gestureRecognizers];
    self.gameView.gestureRecognizers = gestureRecognizers;
}

- (void) handleClick:(NSGestureRecognizer*)gestureRecognize {
    // Highlight the clicked nodes
    CGPoint p = [gestureRecognize locationInView:self.gameView];
    [self.gameController highlightNodesAtPoint:p];
}

@end
