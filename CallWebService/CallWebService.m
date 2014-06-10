//
//  CallWebService.m
//  Dhanesh Gosai
//
//  Created by
//  Copyright 2012. All rights reserved.
//

#import "CallWebService.h"
#import "JSON.h"

@implementation CallWebService
@synthesize webServiceURL,delegate,serviceKey;

- (id) initWithClassName:(NSString*)className delegate:(id)WSdelegate args:(NSMutableDictionary*)parameters tagKey:(NSString*)key {
    
	self = [super init];
	if (self != nil) 
	{        
		serviceKey=[key retain];

        delegate=WSdelegate;
		receiveddata=[[NSMutableData alloc] init];

        NSURL *webURL;
        webURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",gWebServiceURL,className]];

        
        if([key isEqual:@"twitterapi"]){
            
            webURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://search.twitter.com/search.json?q=%@+&rpp=%@&page=%@&result_type=%@&included_entities=%@&geocode=",[parameters objectForKey:@"q"],[parameters objectForKey:@"rpp"],[parameters objectForKey:@"page"],[parameters objectForKey:@"result_type"],[parameters objectForKey:@"include_entities"]]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: webURL];
            [NSURLConnection  connectionWithRequest:request delegate:self];
            [request release];
            
        }else {
            
            NSString *requestString = [NSString stringWithFormat:@"data=%@",[parameters JSONFragment],nil];
            requestString=[requestString stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
            const char *utfYourString = [requestString UTF8String];
            
            NSMutableData *requestData = [NSMutableData dataWithBytes:utfYourString length:strlen(utfYourString)];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: webURL];
            [request setHTTPMethod: @"POST"];
            [request setHTTPBody: requestData];
            //[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            [NSURLConnection  connectionWithRequest:request delegate:self];
            [request release];
            
        }
	}
	return self;
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	[receiveddata appendData:data];
 
//    NSString *received = [[NSString alloc] initWithData:receiveddata encoding:NSUTF8StringEncoding];
//
//	NSLog(@"response:%@",received);
	
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
//	if([delegate respondsToSelector:@selector(responsedidreceive:)]){
		[delegate responsedidreceive:receiveddata forKey:serviceKey];	
//	}
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
//	if([delegate respondsToSelector:@selector(responsedidfail)])
//	{
		[delegate responsedidfail];	
//	}
}
- (void)dealloc
{
    [serviceKey release];
	[receiveddata release];
    [super dealloc];
}
@end
