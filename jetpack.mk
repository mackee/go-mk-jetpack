.PHONY: get-deps get-tools all test build package release

VERSION := $(shell git describe --tags)

all: build

init: get-tools depinit depdir

depinit:
	dep init

get-tools:
	if [ ! which ghg ]; then\
		echo "You must install ghg or manuall installing of golang/dep Songmu/goxz tcnksm/ghr." \
		echo "Example: brew install Songmu/tap/ghg" \
	fi

	ghg get golang/dep
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
	go build -o _bin/$(CMD_NAME) -tags="$(TAGS)" -ldflags="-X $(PACKAGE_PATH).Version=${VERSION}"

package:
	goxz -pv ${VERSION} -os=linux,darwin -arch=amd64 -d ./_artifacts $(CMD_PATH)

release:
	ghr ${VERSION} _artifacts

open-release:
	open https://$(PACKAGE_PATH)/releases/tag/${VERSION}
