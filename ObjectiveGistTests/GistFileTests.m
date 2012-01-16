//
//  GistFileTests.m
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

@interface GistFileTests : SenTestCase {
    Gist* gist;
    NSString* gistId;
    NSString* forkedGistId;
}

@property (nonatomic, retain) Gist* gist;
@property (nonatomic, retain) NSString* gistId;
@property (nonatomic, retain) NSString* forkedGistId;

@end

@implementation GistFileTests

@synthesize gist, gistId, forkedGistId;

- (void)setUp
{
    gistId = @"1316614";
    forkedGistId = @"1618481";
    gist = [[Gist alloc] initWithId:gistId];
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
