//
//  CallWebService.h
//  Dhanesh Gosai
//
//  Created by
//  Copyright 2012. All rights reserved.
//


#import <Foundation/Foundation.h>
@protocol CallWebServiceDelegate;

@interface CallWebService : NSObject 
{
	@private 
		id <CallWebServiceDelegate> delegate;
	NSString *webServiceURL;
	NSMutableData *receiveddata;
	NSString *serviceKey;

}
@property(nonatomic,assign)id <CallWebServiceDelegate> delegate;
@property(nonatomic,retain)NSString *webServiceURL;
@property(nonatomic,retain)NSString *serviceKey;
- (id) initWithClassName:(NSString*)className delegate:(id)WSdelegate args:(NSMutableDictionary*)parameters tagKey:(NSString*)key;
@end


@protocol CallWebServiceDelegate <NSObject>
-(void)responsedidreceive:(NSMutableData*)response_data forKey:(NSString*)reskey;
-(void)responsedidfail;
@end