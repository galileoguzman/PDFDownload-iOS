//
//  ViewController.h
//  PDFDownload
//
//  Created by Galileo Guzman on 9/5/18.
//  Copyright © 2018 Galileo Guzman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIDocumentInteractionControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnDownload;

- (IBAction)btnDownloadPressed:(id)sender;

@end

