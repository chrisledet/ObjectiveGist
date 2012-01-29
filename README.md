# ObjectiveGist

Objective-C wrapper for the Gist API.

## Installation

Just copy the files from the `Classes` and `Library` directories into your Xcode project. In the future I will provide a static library to download.

## ARC Compatibility

As of version 0.0.3, ObjectiveGist is ARC compliant.

## Basic Usage

### Reading Gists

Fetch a Gist from Github:

    Gist* gist = [[Gist alloc] initWithId:@"gist id here"];

Now iterate through the files and show its contents:

    NSArray* gistFiles = [gist files];
    for (GistFile* file in gistFiles) {
        NSLog(@"Content: %@", file.content);
    }


## Write operations

In order to create or delete gists with ObjectiveGist, you must provide an Oauth access token that's supplied by Github. You can read about how Github uses [Oauth here][oauth]. The access token allows you to make requests to the API on a behalf of a user.

### Creating Gists

Once you have an access token, creating a gist is easy as pie:

    GistFile* gistFile = [[GistFile alloc] initWithContent:@"puts 1+1"];
    Gist* newGist = [[Gist alloc] init];
    newGist.files = [NSArray arrayWithObject:gistFile];
    newGist.gistDescription = @"print sum of 1+1 in Ruby";
    [newGist publish:@"access token here"];

### Deleting Gists

Destroying a gist will permanetely remove it from Github.

    Gist* gist = [[Gist alloc] initWithId:@"gist id here"];
    [gist destroy:@"access token here"];

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