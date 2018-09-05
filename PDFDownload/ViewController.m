//
//  ViewController.m
//  PDFDownload
//
//  Created by Galileo Guzman on 9/5/18.
//  Copyright © 2018 Galileo Guzman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIDocumentInteractionController* documentInteractionController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnDownloadPressed:(id)sender {
    
    self.btnDownload.enabled = NO;
    
    [self.btnDownload setTitle:@"Loading ..." forState:UIControlStateDisabled];
    
    [self initDownloadFile];
}


-(void) initDownloadFile{
    
    
    // UNIQUE NAME
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];
    
    // GET STRING NAME FOR SANDBOX
    NSString* documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    // FILE NAME
    NSString* stFilePath = [documentDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",timeStampObj]];
    
    // NEW REQUEST OBJ
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.bowers-wilkins.co.uk/Admin/Downloads/Product/Support/Zeppelin/ENG_FP28495_Zeppelin_Connectivity.pdf"]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            NSLog(@"ERROR HAPPENED %@", error);
        }
        if (data) {
            [data writeToFile:stFilePath atomically:YES];
            
            [self showFileDownloadedWithPath:stFilePath];
        }
    }];
}

-(void)showFileDownloadedWithPath:(NSString*)pathFile{
    NSURL *URL = [NSURL fileURLWithPath:pathFile];
    
    
    self.btnDownload.enabled = YES;
    [self.btnDownload setTitle:@"Download" forState:UIControlStateNormal];
    
    if (URL) {
        // Initialize Document Interaction Controller
        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
        
        // Configure Document Interaction Controller
        [self.documentInteractionController setDelegate:self];
        
        // Preview PDF
        [self.documentInteractionController presentPreviewAnimated:YES];
    }
}

# pragma mark - UIDocumentInteractionControllerDelegate
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller
{
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller
{
    return self.view.frame;
}
@end
