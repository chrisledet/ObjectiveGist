//
//  Gist.h
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

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "GistFile.h"

@interface Gist : NSObject {

@private
    NSURL* apiURL;
    NSString* gistId;
    NSString* gistDescription;
    BOOL isPublic;
    NSUInteger numberOfComments;
    NSURL* htmlURL;
    NSURL* gitPullURL;
    NSURL* gitPushURL;
    NSDate* createdAt;
    NSDate* updateAt;
    NSArray* files;
    NSString* userLogin;
    BOOL isFork;
}

@property (nonatomic, retain) NSURL* apiURL;
@property (nonatomic, assign) NSString* gistId;
@property (nonatomic, retain) NSString* gistDescription;
@property (nonatomic, assign) BOOL isPublic;
@property (nonatomic, assign) NSUInteger numberOfComments;
@property (nonatomic, retain) NSURL* htmlURL;
@property (nonatomic, retain) NSURL* gitPullURL;
@property (nonatomic, retain) NSURL* gitPushURL;
@property (nonatomic, retain) NSDate* createdAt;
@property (nonatomic, retain) NSDate* updatedAt;
@property (nonatomic, retain) NSArray* files;
@property (nonatomic, retain) NSString* userLogin;
@property (nonatomic, assign) BOOL isFork;

- (id)initFromDictionary:(NSDictionary*)gistDictionary;

+ (id)fetchGist:(NSString*)gistId;

@end
