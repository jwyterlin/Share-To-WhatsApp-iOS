//
//  ViewController.m
//  Share to WhatsApp iOS
//
//  Created by Jhonathan Wyterlin on 03/11/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "ViewController.h"

#import "Alert.h"

@interface ViewController()<UIDocumentInteractionControllerDelegate>

@property(nonatomic,strong) UIDocumentInteractionController *documentInteractionController;

@end

@implementation ViewController

#pragma mark - View Lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private methods

-(void)shareImage {
    
    if ( [[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:@"whatsapp://app"]] ) {
        
        UIImage *iconImage = [UIImage imageNamed:@"YOUR IMAGE"];
        NSString *savePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/whatsAppTmp.wai"];
        
        [UIImageJPEGRepresentation(iconImage, 1.0) writeToFile:savePath atomically:YES];
        
        _documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:savePath]];
        _documentInteractionController.UTI = @"net.whatsapp.image";
        _documentInteractionController.delegate = self;
        
        [_documentInteractionController presentOpenInMenuFromRect:CGRectMake(0, 0, 0, 0) inView:self.view animated: YES];
        
        
    } else {

        [[Alert new] showAlertTitle:@"WhatsApp not installed." message:@"Your device has no WhatsApp installed." viewController:self];

    }

}

@end
