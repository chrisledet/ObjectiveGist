//
//  GistFileTests.m
//  ObjectiveGist
//
//  Created by Chris Ledet on 1/15/12.
//  Copyright (c) 2012 Chris Ledet. All rights reserved.
//

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
