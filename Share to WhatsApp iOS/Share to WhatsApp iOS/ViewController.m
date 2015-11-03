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
@property(nonatomic,weak) IBOutlet UIImageView *image;

@end

@implementation ViewController

#pragma mark - View Lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction methods

-(IBAction)sendButtonPressed:(id)sender {
    [self shareImage:self.image.image];
}

-(IBAction)sendTextButtonPressed:(id)sender {
    [self sendText:@"Oh my God Meme"];
}

#pragma mark - Private methods

-(void)shareImage:(UIImage *)image {
    
    if ( [self hasWhatsApp] ) {
        
        NSString *savePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/whatsAppTmp.wai"];
        
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:savePath atomically:YES];
        
        _documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:savePath]];
        _documentInteractionController.UTI = @"net.whatsapp.image";
        _documentInteractionController.delegate = self;
        
        [_documentInteractionController presentOpenInMenuFromRect:CGRectMake( 0, 0, 0, 0 ) inView:self.view animated: YES];
        
    } else {

        [self showsWhatsAppNotInstalled];

    }

}

-(void)sendText:(NSString*)message {
    
    NSString *urlWhats = [NSString stringWithFormat:@"whatsapp://send?text=%@",message];
    NSString *urlEncoded = [urlWhats stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *whatsappURL = [NSURL URLWithString:urlEncoded];
    
    if ( [self hasWhatsApp] ) {
        [[UIApplication sharedApplication] openURL:whatsappURL];
    } else {
        [self showsWhatsAppNotInstalled];
    }
    
}

-(BOOL)hasWhatsApp {
    return [[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:@"whatsapp://app"]];
}

-(void)showsWhatsAppNotInstalled {
    [[Alert new] showAlertTitle:@"WhatsApp not installed." message:@"Your device has no WhatsApp installed." viewController:self];
}

@end
