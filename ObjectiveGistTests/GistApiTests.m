//
//  GistApiTests.m
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

#import "TestHelper.h"

@interface GistAPITests : SenTestCase {
    NSString* gistId;
    NSString* accessToken;
}

@property (nonatomic, strong) NSString* gistId;
@property (nonatomic, strong) NSString* accessToken;

@end

@implementation GistAPITests

@synthesize gistId, accessToken;

- (void)setUp
{
    gistId      = @"1316614";
    accessToken = @"test token";
}

- (void)testSingleGistURLString
{
    NSString* singleGistURL = [NSString stringWithFormat:
                                @"https://api.github.com/gists/%@", gistId];
    STAssertEqualObjects(singleGistURL, [GistAPI singleGistURLString:gistId], @"Gist API test");
}

- (void)testCreateGistURLString
{
    NSString* createGistURL = [NSString stringWithFormat:
                               @"https://api.github.com/gists?access_token=%@", accessToken];
    STAssertEqualObjects(createGistURL, [GistAPI createGistURLString:accessToken], @"Gist API Create URL test");
}

- (void)testEditGistURLString
{
    NSString* editGistUrl = [NSString stringWithFormat:
                               @"https://api.github.com/gists/%@?access_token=%@", gistId, accessToken];
    STAssertEqualObjects(editGistUrl,
                         [GistAPI editGistURLString:gistId withAccessToken:accessToken], @"Gist API Edit URL test");
}

- (void)testSingleGistURL
{
    NSURL* singleGistURL = [NSURL URLWithString:[NSString stringWithFormat:
                               @"https://api.github.com/gists/%@", gistId]];
    STAssertEqualObjects(singleGistURL, [GistAPI singleGistURL:gistId], @"Gist API test");
}

- (void)testCreateGistURL
{
    NSURL* createGistURL = [NSURL URLWithString:[NSString stringWithFormat:
                               @"https://api.github.com/gists?access_token=%@", accessToken]];
    STAssertEqualObjects(createGistURL, [GistAPI createGistURL:accessToken], @"Gist API Create URL test");
}

- (void)testEditGistURL
{
    NSURL* editGistURL = [NSURL URLWithString:[NSString stringWithFormat:
                                                  @"https://api.github.com/gists/%@?access_token=%@", gistId, accessToken]];
    STAssertEqualObjects(editGistURL, [GistAPI editGistURL:gistId withAccessToken:accessToken], @"Gist API Edit URL test");
}

@end
