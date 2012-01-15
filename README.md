# ObjectiveGist

Objective-C wrapper for the Gist API.

## Installation

Just copy the files from the `Classes` and `Library` directories into your Xcode project. In the future I will provide a static library to download.

## Basic Usage

Fetch a Gist from Github:

    NSString* gistId = @"1316614";
    Gist* gist = [Gist fetchGist:gistId];

View the Gist's files:

    NSArray* gistFiles = [gist files];

View the contents of a single Gist file:

    NSString* content = [gistFiles objectAtIndex:0];
    NSLog(@"Content: %@", content);

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