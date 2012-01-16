//
//  GistFile.m
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

#import "GistFile.h"

@implementation GistFile

@synthesize filename, filesize, rawURL, content, language;

- (void) dealloc
{
    [filename release];
    [rawURL release];
    [content release];
    [language release];
    [super dealloc];
}

- (id)initFromDictionary:(NSDictionary*)gistFileDictionary
{
    self = [super init];
    
    if (self) {
        self.content  = [gistFileDictionary objectForKey:@"content"];
        self.filename = [gistFileDictionary objectForKey:@"filename"];
        self.language = [gistFileDictionary objectForKey:@"language"];
        self.filesize = [[gistFileDictionary objectForKey:@"size"] intValue];
        self.rawURL   = [NSURL URLWithString:[gistFileDictionary objectForKey:@"raw_url"]];
    }
    
    return self;
}

- (id)initWithContent:(NSString*)aContent
{
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:aContent forKey:@"content"];
    return [self initFromDictionary:dictionary];
}

- (id)initWithContent:(NSString*)aContent language:(NSString*)aLanguage
{
    NSDictionary* dictionary = [NSDictionary dictionaryWithObjectsAndKeys:content, @"content", language, @"language", nil];
    return [self initFromDictionary:dictionary];
}

- (id)initWithContent:(NSString*)aContent language:(NSString*)aLanguage filename:(NSString*)aFilename
{
    NSDictionary* dictionary =
        [NSDictionary dictionaryWithObjectsAndKeys:aContent, @"content", aLanguage, @"language", aFilename, @"filename",nil];
    return [self initFromDictionary:dictionary];
}

@end
