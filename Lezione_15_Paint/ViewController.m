//
//  ViewController.m
//  Lezione_15_Paint
//
//  Created by Alberto Pasca on 17/11/11.
//  Copyright (c) 2011 Cutaway SRL. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize Slider;

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  drawImage = [[UIImageView alloc] initWithImage:nil];
	drawImage.frame = self.view.frame; // CGRectMake(0, 0, 320, 200); PER UNA PARTE DI SCHERMO
	[self.view addSubview:drawImage];
	self.view.backgroundColor = [UIColor lightGrayColor];
	mouseMoved = 0;

  PenWidth = 1.0;
  col = ColorMake(1.0, 1.0, 0.0);
  
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	mouseSwiped = NO;
	UITouch *touch = [touches anyObject];
	
	if ([touch tapCount] == 2) {
		drawImage.image = nil;
    col = ColorMake(1.0, 1.0, 0.0);
		return;
	}
  
	lastPoint = [touch locationInView:self.view];
	lastPoint.y -= 20;
  
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	mouseSwiped = YES;
	
	UITouch *touch = [touches anyObject];	
	CGPoint currentPoint = [touch locationInView:self.view];
	currentPoint.y -= 20;
	
	UIGraphicsBeginImageContext(self.view.frame.size);
  
	[drawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
  
	CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
	CGContextSetLineWidth(UIGraphicsGetCurrentContext(), PenWidth);
	CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), col.R, col.G, col.B, 1.0);
	CGContextBeginPath(UIGraphicsGetCurrentContext());
	CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
	CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
	CGContextStrokePath(UIGraphicsGetCurrentContext());
  
	drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
  
	UIGraphicsEndImageContext();
	
	lastPoint = currentPoint;
	mouseMoved++;
	if (mouseMoved == 10) mouseMoved = 0;
  
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];	
	if ([touch tapCount] == 2) {
		drawImage.image = nil;
    col = ColorMake(1.0, 1.0, 0.0);
		return;
	}
	
	if ( !mouseSwiped ) 
  {
		UIGraphicsBeginImageContext(self.view.frame.size);

		[drawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];

		CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
		CGContextSetLineWidth(UIGraphicsGetCurrentContext(), PenWidth);
		CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), col.R, col.G, col.B, 1.0);
		CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
		CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
		CGContextStrokePath(UIGraphicsGetCurrentContext());
		CGContextFlush(UIGraphicsGetCurrentContext());
    
		drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    
		UIGraphicsEndImageContext();
	}
  
}

- (void)viewDidUnload {
  [self setSlider:nil];
  [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
  [Slider release];
  [super dealloc];
}

- (IBAction)SetColor:(id)sender {
  UIButton *btn = (UIButton*)sender;

  switch ( btn.tag ) {
    case 0: col = ColorMake(1.0, 0.0, 0.0); break;
    case 1: col = ColorMake(0.0, 1.0, 0.0); break;
    case 2: col = ColorMake(0.0, 0.0, 1.0); break;
  }
}

- (IBAction)SetPenWidth:(id)sender {
  UISlider *s = (UISlider*)sender;
  PenWidth = s.value;
}

@end
