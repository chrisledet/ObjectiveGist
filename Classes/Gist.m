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

@interface Gist()

/* Instance methods */
- (NSArray*)setGistFilesFromDictionary:(NSDictionary*)dictionary;

/* Class methods */
+ (NSURL*)gistApiURL:(NSString*) gistId;

@end

@implementation Gist

@synthesize apiURL, htmlURL, gitPullURL, gitPushURL, createdAt, updatedAt, files;
@synthesize gistId, gistDescription, isPublic, numberOfComments, userLogin, isFork;

- (void)dealloc
{
    [gistId release];
    [apiURL release];
    [htmlURL release];
    [gitPullURL release];
    [gitPushURL release];
    [createdAt release];
    [files release];
    [gistDescription release];
    [userLogin release];
    [super dealloc];
}

+ (id)fetchGist:(NSString*)gistId
{
    SBJsonParser* parser = [[SBJsonParser alloc] init];
    NSData* jsonData = [NSData dataWithContentsOfURL:[self gistApiURL:gistId]];
    NSDictionary* jsonDictionary = [parser objectWithData:jsonData];
    
    return [[Gist alloc] initFromDictionary:jsonDictionary];
}

- (id)initFromDictionary:(NSDictionary*)gistDictionary;
{
    self = [super init];

    if (self) {
        gistId = [gistDictionary objectForKey:@"id"];
        gistDescription = [gistDictionary objectForKey:@"description"];
        isPublic = [[gistDictionary objectForKey:@"public"] boolValue];
        userLogin = [[gistDictionary objectForKey:@"user"] objectForKey:@"login"];
        numberOfComments = [[gistDictionary objectForKey:@"comments"] intValue];
        createdAt  = [NSDate dateWithString:[gistDictionary objectForKey:@"created_at"]];
        updatedAt  = [NSDate dateWithString:[gistDictionary objectForKey:@"updated_at"]];
        apiURL     = [Gist gistApiURL:gistId];
        htmlURL    = [NSURL URLWithString:[gistDictionary objectForKey:@"html_url"]];
        gitPullURL = [NSURL URLWithString:[gistDictionary objectForKey:@"git_pull_url"]];
        gitPushURL = [NSURL URLWithString:[gistDictionary objectForKey:@"git_push_url"]];
        files  = [self setGistFilesFromDictionary:[gistDictionary objectForKey:@"files"]];
        isFork = [gistDictionary objectForKey:@"fork_of"] != nil;
    }
    
    return self;
}

/* Private methods */

- (NSArray*)setGistFilesFromDictionary:(NSDictionary*)dictionary
{
    NSMutableArray* tempGistFile = [[NSMutableArray alloc] init];
    for (NSString* filename in dictionary) {
        GistFile* gistFile = [[GistFile alloc] initFromDictionary:[dictionary objectForKey:filename]];
        [tempGistFile addObject:gistFile];
        [gistFile release];
    }
    return [[tempGistFile copy] autorelease];
}

+ (NSURL*)gistApiURL:(NSString*) gistId
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://api.github.com/gists/%@", gistId]];
}

@end
