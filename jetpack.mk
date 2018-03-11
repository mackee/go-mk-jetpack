.PHONY: get-deps get-tools depinit depdir all test build package release open-release clean

VERSION := $(shell git describe --tags)

all: build

init: depinit initdir

depinit:
	dep init

get-tools:
	which ghg || \
		echo "You must install ghg or manuall installing of golang/dep Songmu/goxz tcnksm/ghr.\n"\
		"Example: brew install Songmu/tap/ghg"
	which ghg || exit 1
	go get -u github.com/golang/dep/cmd/dep
	ghg get Songmu/goxz
	ghg get tcnksm/ghr

initdir:
	mkdir -p _artifacts
	mkdir -p _bin

get-deps:
	dep ensure

test:
	go test -v -race
	go vet

build: initdir clean
	go build -o _bin/$(CMD_NAME) -ldflags="-X $(PACKAGE_PATH).Version=${VERSION}" $(CMD_PATH)

package: initdir clean
	goxz -pv ${VERSION} -os=linux,darwin -arch=amd64 -d ./_artifacts $(CMD_PATH)

release:
	ghr ${VERSION} _artifacts

open-release:
	open https://$(PACKAGE_PATH)/releases/tag/${VERSION}

clean:
	rm _artifacts/*
	rm _bin/*
