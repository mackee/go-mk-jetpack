.PHONY: get-deps get-tools all test build package release

VERSION := $(shell git describe --tags)

all: build

init: depinit depdir

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

depdir:
	mkdir -p _artifacts
	mkdir -p _bin

get-deps:
	dep ensure

test:
	go test -v -race
	go vet

build:
	go build -o _bin/$(CMD_NAME) -ldflags="-X $(PACKAGE_PATH).Version=${VERSION}" $(CMD_PATH)

package:
	goxz -pv ${VERSION} -os=linux,darwin -arch=amd64 -d ./_artifacts $(CMD_PATH)

release:
	ghr ${VERSION} _artifacts

open-release:
	open https://$(PACKAGE_PATH)/releases/tag/${VERSION}
