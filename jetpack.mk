.PHONY: get-deps get-tools depinit depdir all test build package release open-release clean

VERSION := $(shell git describe --tags)

BUILD_OPTS = -build-tags netgo -build-ldflags='-extldflags "-static" -X $(PACKAGE_PATH).Version=${VERSION}'

all: build

init: depinit initdir

depinit:
	go mod init

get-tools:
	which ghg || \
		echo "You must install ghg or manuall installing of Songmu/goxz tcnksm/ghr.\n"\
		"Example: brew install Songmu/tap/ghg"
	which ghg || exit 1
	ghg get Songmu/goxz
	ghg get tcnksm/ghr

initdir:
	mkdir -p _artifacts
	mkdir -p _bin

get-deps:
	go mod download

test:
	go test -v -race
	go vet

build: initdir
	go build -o _bin/$(CMD_NAME) -ldflags="-X $(PACKAGE_PATH).Version=${VERSION}" $(CMD_PATH)

package: initdir
	CGO_ENABLED=0 goxz -pv ${VERSION} -os=linux,darwin -arch=amd64 $(BUILD_OPTS) -d ./_artifacts $(CMD_PATH)

release:
	ghr ${VERSION} _artifacts

open-release:
	open https://$(PACKAGE_PATH)/releases/tag/${VERSION}

clean:
	rm _artifacts/*
	rm _bin/*
