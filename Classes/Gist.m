//
//  Gist.m
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

#import "Gist.h"
#import "GistAPI.h"

@interface Gist()

/* private initializers */
- (id)initFromDictionary:(NSDictionary*)gistDictionary;

/* Instance methods */
- (NSArray*)setGistFilesFromDictionary:(NSDictionary*)dictionary;
- (void)mapDictionary:(NSDictionary*)dictionary;

@end

@implementation Gist

@synthesize apiURL, htmlURL, gitPullURL, gitPushURL, createdAt, updatedAt, files;
@synthesize gistId, gistDescription, isPublic, numberOfComments, userLogin, isFork;


- (id)initWithId:(NSString*)aGistId;
{
    SBJsonParser* parser = [[SBJsonParser alloc] init];
    NSData* jsonData = [NSData dataWithContentsOfURL:[GistAPI singleGistURL:aGistId]];
    NSDictionary* jsonDictionary = [parser objectWithData:jsonData];
    return [[Gist alloc] initFromDictionary:jsonDictionary];
}

- (id)initWithFiles:(NSArray *)aFiles
{
    self = [super init];
    if (self)
        files = aFiles;
    return self;
}

- (id)initFromDictionary:(NSDictionary*)gistDictionary;
{
    self = [super init];
    
    if (self)
        [self mapDictionary:gistDictionary];

    return self;
}

- (void)publish:(NSString*)accessToken
{
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:gistDescription forKey:@"description"];
    [dictionary setObject:(isPublic ? @"true": @"false") forKey:@"public"];
    
    NSMutableDictionary* fileDictionary = [[NSMutableDictionary alloc] init];
    for (GistFile* file in files) {
        [fileDictionary setObject:[NSDictionary dictionaryWithObject:file.content forKey:@"content"] forKey:file.filename];
    }
    [dictionary setObject:fileDictionary forKey:@"files"];
    
    NSData* postData = [[dictionary JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSData* returnData =
        [GistAPI sendHTTPRequest:[GistAPI createGistURL:accessToken] withHTTPBody:postData AndHTTPMethod:@"POST"];
    
    SBJsonParser* parser = [[SBJsonParser alloc] init];
    NSDictionary* jsonDictionary = [parser objectWithData:returnData];
    
    [self mapDictionary:jsonDictionary];
    
}

- (void)destroy:(NSString*)accessToken
{
    [GistAPI sendHTTPRequest:[GistAPI editGistURL:gistId withAccessToken:accessToken] withHTTPBody:nil AndHTTPMethod:@"DELETE"];
}

- (NSArray*)setGistFilesFromDictionary:(NSDictionary*)dictionary
{
    NSMutableArray* tempGistFile = [[NSMutableArray alloc] init];
    for (NSString* filename in dictionary) {
        GistFile* gistFile = [[GistFile alloc] initFromDictionary:[dictionary objectForKey:filename]];
        [tempGistFile addObject:gistFile];
    }
    return tempGistFile;
}


- (void)mapDictionary:(NSDictionary*)dictionary
{
    gistId = [dictionary objectForKey:@"id"];
    gistDescription = [dictionary objectForKey:@"description"];
    isPublic = [[dictionary objectForKey:@"public"] boolValue];
    userLogin = [[dictionary objectForKey:@"user"] objectForKey:@"login"];
    numberOfComments = [[dictionary objectForKey:@"comments"] intValue];
    createdAt  = [NSDate dateWithString:[dictionary objectForKey:@"created_at"]];
    updatedAt  = [NSDate dateWithString:[dictionary objectForKey:@"updated_at"]];
    apiURL     = [GistAPI singleGistURL:gistId];
    htmlURL    = [NSURL URLWithString:[dictionary objectForKey:@"html_url"]];
    gitPullURL = [NSURL URLWithString:[dictionary objectForKey:@"git_pull_url"]];
    gitPushURL = [NSURL URLWithString:[dictionary objectForKey:@"git_push_url"]];
    files  = [self setGistFilesFromDictionary:[dictionary objectForKey:@"files"]];
    isFork = [dictionary objectForKey:@"fork_of"] != nil;
}

@end
