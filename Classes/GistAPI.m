//
//  GistAPI.m
//  ObjectiveGist
//
//  Copyright (c) 2012 Chris Ledet
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "GistAPI.h"

@implementation GistAPI

+ (NSString*) singleGistURLString:(NSString*)gistId
{
    return [NSString stringWithFormat:@"https://api.github.com/gists/%@", gistId];
}

+ (NSString*) createGistURLString:(NSString*)accessToken
{
    return [NSString stringWithFormat:@"https://api.github.com/gists?access_token=%@", accessToken];
}

+ (NSString*) editGistURLString:(NSString*)gistId withAccessToken:(NSString*)accessToken
{
    return [NSString stringWithFormat:@"https://api.github.com/gists/%@?access_token=%@", gistId, accessToken];
}

+ (NSURL*) singleGistURL:(NSString*)gistId
{
    return [NSURL URLWithString:[self singleGistURLString:gistId]];
}

+ (NSURL*) createGistURL:(NSString*)accessToken
{
    return [NSURL URLWithString:[self createGistURLString:accessToken]];
}

+ (NSURL*) editGistURL:(NSString*)gistId withAccessToken:(NSString*)accessToken
{
    return [NSURL URLWithString:[self editGistURLString:gistId withAccessToken:accessToken]];
}

+ (NSData*)sendHTTPRequest:(NSURL*)url withHTTPBody:(NSData*)httpData AndHTTPMethod:(NSString*)httpMethod
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:httpMethod];
    [request setHTTPBody:httpData];
    
    NSError* error = nil;
    NSHTTPURLResponse* response = nil;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error) {
        NSLog(@"Error occurred while creating gist: %@", error);
    }
    
    
    return returnData;
}

@end
