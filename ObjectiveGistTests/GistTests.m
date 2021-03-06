//
//  GistTests.m
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

@interface GistTests : SenTestCase {
    Gist* gist;
    NSString* gistId;
    NSString* forkedGistId;
    NSString* accessToken;
}

@property (nonatomic, strong) Gist* gist;
@property (nonatomic, strong) NSString* gistId;
@property (nonatomic, strong) NSString* forkedGistId;
@property (nonatomic, strong) NSString* accessToken;

@end

@implementation GistTests

@synthesize gist, gistId, forkedGistId, accessToken;

- (void)setUp
{
    gistId = @"1316614";
    forkedGistId = @"1618481";
    gist = [[Gist alloc] initWithId:gistId];
    accessToken = [NSString stringWithContentsOfFile:@"ObjectiveGistTests/.access_token" encoding:NSUTF8StringEncoding error:nil];
}

- (void)testNumberOfComments
{
    STAssertTrue(1 == gist.numberOfComments, @"gist numberOfComments should match");
}

- (void)testUpdatedAt
{
    NSTimeInterval updatedAt = [[NSDate dateWithString:@"2011-10-26T15:03:30Z"] timeIntervalSinceNow];
    STAssertTrue(updatedAt == [gist.updatedAt timeIntervalSinceNow], @"updatedAt should match");
}

- (void)testCreatedAt
{
    NSTimeInterval createdAt = [[NSDate dateWithString:@"2011-10-26T15:02:16Z"] timeIntervalSinceNow];
    STAssertTrue(createdAt == [gist.createdAt timeIntervalSinceNow], @"createdAt should match");
}

- (void)testGitPushURL
{
    NSURL* gitPushUrl = [NSURL URLWithString:[NSString stringWithFormat:@"git@gist.github.com:%@.git", gistId]];
    STAssertEqualObjects(gitPushUrl, gist.gitPushURL, @"gitPushURL should match");
}

- (void)testGitPullURL
{
    NSURL* gitPullUrl = [NSURL URLWithString:[NSString stringWithFormat:@"git://gist.github.com/%@.git", gistId]];
    STAssertEqualObjects(gitPullUrl, gist.gitPullURL, @"gitPullUrl should match");
}

- (void)testHtmlURL
{
    NSURL* htmlURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://gist.github.com/%@", gistId]];
    STAssertEqualObjects(htmlURL, gist.htmlURL, @"htmlURL should match");
}

- (void)testApiURL
{
    NSURL* apiURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.github.com/gists/%@", gistId]];
    STAssertEqualObjects(apiURL, gist.apiURL, @"apiURL should match");
}

- (void)testIsPublic
{
    STAssertTrue(gist.isPublic, @"gist should be public");
}

- (void)testDescription
{
    STAssertEqualObjects(@"Hide a file using Cocoa", gist.gistDescription, @"Description should match");
}

- (void)testUserLogin
{
    STAssertEqualObjects(@"chrisledet", gist.userLogin, @"userlogin should match");
}

- (void)testIsFork
{
    STAssertFalse(gist.isFork, @"Gist should is not a fork");
}

- (void)testForkedGist
{
    Gist* forkedGist = [[Gist alloc] initWithId:forkedGistId];
    STAssertTrue(forkedGist.isFork, @"Gist is forked");
}

- (void)testPublish
{
    GistFile* gistFile = [[GistFile alloc] initWithContent:@"puts 1+1"];
    Gist* newGist = [[Gist alloc] initWithFiles:[NSArray arrayWithObject:gistFile]];
    newGist.gistDescription = @"Test Gist";
    newGist.isPublic = NO;
    [newGist publish:accessToken];
    STAssertNotNil(newGist.gistId, @"Gist should be created");
}

- (void)testDelete
{
    /* first create a private gist */
    GistFile* gistFile = [[GistFile alloc] initWithContent:@"puts 1+1"];
    Gist* newGist = [[Gist alloc] initWithFiles:[NSArray arrayWithObject:gistFile]];
    newGist.gistDescription = @"Test Gist";
    newGist.isPublic = NO;
    [newGist publish:accessToken];
    STAssertNotNil(newGist.gistId, @"Gist should be created");

    /* then destroy it */
    NSString* privateGistId = [newGist.gistId copy];
    [newGist destroy:accessToken];
    newGist = [[Gist alloc] initWithId:privateGistId];
    STAssertNil(newGist.gistId, @"Gist should be nil");
}

@end
