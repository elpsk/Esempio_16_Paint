//
//  ViewController.h
//  Lezione_15_Paint
//
//  Created by Alberto Pasca on 17/11/11.
//  Copyright (c) 2011 Cutaway SRL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
  float R;
  float G;
  float B;
} Color;

CG_INLINE Color ColorMake(float r, float g, float b) {
  Color col;
  col.R = r;
  col.G = g;
  col.B = b;
  return col;
}

@interface ViewController : UIViewController {
  
  CGPoint lastPoint;
	UIImageView *drawImage;
	BOOL mouseSwiped;	
	int mouseMoved;

  float PenWidth;
 
  Color col;

}

@property (retain, nonatomic) IBOutlet UISlider *Slider;

- (IBAction)SetColor:(id)sender;
- (IBAction)SetPenWidth:(id)sender;

@end
