# SwiftLintConfigGenerator
A simple utility to generate a custom SwiftLint config.

> **Note:** This is very much in the earliest stages of development and doesn't actually do anything useful yet. It's also my first attempt at making a full-blown Swift command line utility so no guarantees that I'm doing anything right if you decide to study the code. All feedback is welcome!

## Purpose

This is a command line utility that aims to make it easy to generate a SwiftLint configuration file (`.swiftlint.yml`). Why would anyone want to do that? As an iOS engineer by day, I've really enjoyed the transition to Swift, especially the tooling that the community has developed around the language. [SwiftLint](https://github.com/realm/SwiftLint) is one of my favorite tools since it helps enforce clean, consistent Swift code across a project.

While I do find the default SwiftLint configuration pretty good, I actually prefer to enable most of the [opt-in rules](https://github.com/realm/SwiftLint#opt-in-rules) that are disabled by default. I find that this leads to a more consistent codebase with regard to overall code style and conventions, especially when working in a multi-developer environment.

Because the SwiftLint project is still very active, I wanted a way to keep up with any opt-in rules that are added as SwiftLint continues to evolve over time. Instead of trying to manually remember to periodically diff my [default .swiftlint.yml file](https://gist.github.com/tylermilner/f33e33e3b4f23d8c6b2fdd4f87af98a1) with the latest SwiftLint rule set, I decided to create a small utility to do the work for me!

## Getting Started

### Dependencies

The only dependency to start building this project is Swift 5.1. After installing Swift, you can check your version using:

```bash
swift --version
```

### Cloning the Repo

Clone the repo as you would any other:

```bash
git clone https://github.com/tylermilner/SwiftLintConfigGenerator.git
cd SwiftLintConfigGenerator
```

### Building

```bash
swift build
```

### Running

```bash
swift run
```

### Testing

```bash
swift test
```

### Developing in Xcode

To use Xcode for development, run this command after cloning the repo and open the generated `.xcodeproj`:

```bash
swift package generate-xcodeproj
```

### Installing

In order to deploy this utility so that it can be utilized via terminal at any time, first generate a release build:

```bash
swift build --configuration release
```

This will create a binary in the `.build/release/` folder.

Copy this binary to the user binary folder (`/usr/local/bin`):

```bash
cp .build/release/SwiftLintConfigGenerator /usr/local/bin/SwiftLintConfigGenerator
```

Now you should be able to invoke this utility at any time using the command:

```bash
SwiftLintConfigGenerator
```

## References

- [The Ultimate Guide To Swift Executables](https://www.fivestars.blog//code/ultimate-guide-swift-executables.html) - helping me with the basics of a Swift command line utility.
