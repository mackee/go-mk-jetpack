# go-mk-jetpack

The Makefile template for CLI Tool written in Golang.

## Usage

### 1. Installation `jetpack.mk` to your tools directory.

This example use `git submodule`.

```console
$ cd $GOPATH/src/github.com/yourname/yourtool
$ git submodule add _jetpack git@github.com:mackee/go-mk-jetpack
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

Installing tools are:

- [ghg](https://github.com/Songmu/ghg) - Get the executable from github releases easily
- [dep](https://github.com/golang/dep) - Go dependency management tool
- [goxz](https://github.com/Songmu/goxz) - Just do cross building and archiving go tools conventionally
- [ghr](https://github.com/tcnksm/ghr) - Upload multiple artifacts to GitHub Release in parallel

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
$ make release
```

You will do this to open the page.

```console
$ make open-release
```

## Licence

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)

## Author

[mackee](https://github.com/mackee)
