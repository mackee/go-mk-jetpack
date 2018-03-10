# go-mk-jetpack

The Makefile template for CLI Tool written in Golang.

## Requirements

- `make`
- [ghg](https://github.com/Songmu/ghg) - Get the executable from github releases easily

This makefile get build and packages tools by ghg.

Installing ghg is in Mac with brew:

```console
$ brew install Songmu/tap/ghg
```

Please look a [ghg pages](https://github.com/Songmu/ghg) when installation for other environment.

However requirement other tools. But you can use automatically install with ghg.

After the makefile settings, type this:
```console
$ make get-tools
```

This command install tools that are:

- [dep](https://github.com/golang/dep) - Go dependency management tool
- [goxz](https://github.com/Songmu/goxz) - Just do cross building and archiving go tools conventionally
- [ghr](https://github.com/tcnksm/ghr) - Upload multiple artifacts to GitHub Release in parallel

## Usage

### 1. Installation `jetpack.mk` to your tools directory.

This example use `git submodule`.

```console
$ cd $GOPATH/src/github.com/yourname/yourtool
$ git submodule add git@github.com:mackee/go-mk-jetpack _jetpack 
```

### 2. Create a `Makefile`.

In your tool directory root, create a `Makefile` by your favorite editor.

```console
$ $EDITOR Makefile
```

And specify environment variable, include `jetpack.mk`.

```make
CMD_NAME     = yourtool
CMD_PATH     = ./cmd/mytool
PACKAGE_PATH = github.co/yourname/yourtool

include ./_jetpack/jetpack.mk
```

### 3. Installation tools for `jetpack.mk`.

This step easy. You type this:

```console
$ make init
```

### 4. test, build, release!

If you want to run test, type this:

```console
$ make test
```

If you want to build tool, type this:

```console
$ make build
```

Well, let's release binary to `github.com`.

First, bump up tag version.

```console
$ git tag v0.0.1
$ git push origin v0.0.1
```

You can make a release packages for tools.

```console
$ make packages
```

This process is build for cross-platform and packaging to zip file. Package files create to a `_artifacts` directory.

Let's release!

```console
$ GITHUB_TOKEN=xxxxxx make release
```

`GITHUB_TOKEN` is github api token. I recommend configuration using at [direnv](https://github.com/direnv/direnv).

You will do this to open the page.

```console
$ make open-release
```

## Recommend settings

The `go-mk-jetpack` is create to packages at `_artifacts` and create a binary at `_bin`.

So this directory is ignore of git.

In `.gitignore`:

```
_artifacts
_bin
```

Also When try your tool at development, binary at `_bin/yourtool`. If you need set `_bin` to `$PATH`, you will use [direnv](https://github.com/direnv/direnv) and specify this at `.envrc` to can run your tool.

```
export PATH=$GOPATH/src/$PACKAGE_PATH/_bin:$PATH
```

## Licence

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)

## Author

[mackee](https://github.com/mackee)
