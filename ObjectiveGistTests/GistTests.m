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


#import <SenTestingKit/SenTestingKit.h>
#import "ObjectiveGist.h"


NSString * const kGistId = @"1316614";

@interface GistTests : SenTestCase {
    Gist* gist;
}

@property (nonatomic, retain) Gist* gist;

@end

@implementation GistTests

@synthesize gist;

- (void)setUp {
    gist = [Gist fetchGist:kGistId];
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
    NSURL* gitPushUrl = [NSURL URLWithString:[NSString stringWithFormat:@"git@gist.github.com:%@.git", kGistId]];
    STAssertEqualObjects(gitPushUrl, gist.gitPushURL, @"gitPushURL should match");
}

- (void)testGitPullURL
{
    NSURL* gitPullUrl = [NSURL URLWithString:[NSString stringWithFormat:@"git://gist.github.com/%@.git", kGistId]];
    STAssertEqualObjects(gitPullUrl, gist.gitPullURL, @"gitPullUrl should match");
}

- (void)testHtmlURL
{
    NSURL* htmlURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://gist.github.com/%@", kGistId]];
    STAssertEqualObjects(htmlURL, gist.htmlURL, @"htmlURL should match");
}

- (void)testApiURL
{
    NSURL* apiURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.github.com/gists/%@", kGistId]];
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

- (void)testGistFilesFromGist
{
    GistFile* gistFile = [gist.files objectAtIndex:0];
    NSURL* rawURL = [NSURL URLWithString:@"https://gist.github.com/raw/1316614/ca9ab858d3b9a428bdb2a45c56c1502d6e1f4ab9/hide.m"];
    STAssertEqualObjects(@"hide.m", gistFile.filename, @"Gist filename should be set");
    STAssertEqualObjects(@"Objective-C", gistFile.language, @"Gist filename should be set");
    STAssertTrue(144 == gistFile.filesize, @"Gist filesize should be set");
    STAssertEqualObjects(rawURL, gistFile.rawURL, @"Gist raw URL should be set");
}

@end
