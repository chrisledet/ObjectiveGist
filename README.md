# ObjectiveGist

Objective-C wrapper for the Gist API.

## Installation

Just copy the files from the `Classes` and `Library` directories into your Xcode project. In the future I will provide a static library to download.

## Basic Usage

Fetch a Gist from Github:

    NSString* gistId = @"1316614";
    Gist* gist = [[Gist alloc] initWithId:gistId];

View the Gist's files and show its contents:

    NSArray* gistFiles = [gist files];
    for (GistFile* file in gistFiles) {
        NSLog(@"Content: %@", file.content);
    }

### Creating Gists

In order to create gists with ObjectiveGist, you must provide an Oauth access token that's supplied by Github. You can read about how Github uses [Oauth here][oauth]. The access token allows you to make requests to the API on a behalf of a user.

Once you have an access token, creating a gist is easy as pie:

    GistFile* gistFile = [[GistFile alloc] initWithContent:@"puts 1+1"]];
    Gist* newGist = [[Gist alloc] init];
    newGist.files = [NSArray arrayWithObject:gistFile];
    [newGist publish:@"access token here"];

You can also create a gist from a file:

    NSString* fileContents = [NSString stringWithContentsOfFile:@"/Users/chris/code.rb" encoding:NSUTF8StringEncoding error:nil];
    GistFile* gistFile = [[GistFile alloc] initWithContent:fileContents]];
    Gist* newGist = [[Gist alloc] init];
    newGist.files = [NSArray arrayWithObject:gistFile];
    [newGist publish:@"access token here"];

## Tests

One of the goals for ObjectiveGist is excellent test coverage. You can see the tests in the [ObjectiveGistTests][tests] directory.

## Submitting an Issue

I use GitHub's [issue tracker][issues] to track bugs and features. Before submitting an issue or feature request, please check to make sure it hasn't already been submitted. You can indicate support for an existing issue by voting it up. When submitting a bug report, please include your Xcode (with compiler) and OS X version.

## TODOS

You can view the [upcoming features][features] on Github.

## License

ObjectiveGist is released under the [MIT License][license].

[issues]:https://github.com/chrisledet/ObjectiveGist/issues
[features]:https://github.com/chrisledet/ObjectiveGist/issues?labels=Features&sort=created&direction=desc&state=open&page=1
[license]:https://github.com/chrisledet/ObjectiveGist/blob/master/LICENSE
[tests]:https://github.com/chrisledet/ObjectiveGist/tree/master/ObjectiveGistTests
[oauth]:http://developer.github.com/v3/oauth/