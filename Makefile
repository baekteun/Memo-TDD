generate:
	TUIST_TEST=1 tuist generate

setup:
	curl -Ls https://install.tuist.io | bash

clean:
	rm -rf **/*.xcodeproj
	rm -rf *.xcworkspace

reset:
	tuist clean
	rm -rf **/*.xcodeproj
	rm -rf *.xcworkspace

needle:
	sh Scripts/NeedleRunScript.sh

build:
	tuist build MemoTDD

test:
	xcodebuild test -scheme CommonFeature -destination 'platform=iOS Simulator,name=iPhone 13,OS=latest' -enableCodeCoverage YES
	xcodebuild test -scheme RootFeature -destination 'platform=iOS Simulator,name=iPhone 13,OS=latest' -enableCodeCoverage YES
	xcodebuild test -scheme MemoListFeature -destination 'platform=iOS Simulator,name=iPhone 13,OS=latest' -enableCodeCoverage YES
	xcodebuild test -scheme Core -destination 'platform=iOS Simulator,name=iPhone 13,OS=latest' -enableCodeCoverage YES
	xcodebuild test -scheme ThirdPartyLib -destination 'platform=iOS Simulator,name=iPhone 13,OS=latest' -enableCodeCoverage YES
	xcodebuild test -scheme Utility -destination 'platform=iOS Simulator,name=iPhone 13,OS=latest' -enableCodeCoverage YES
	xcodebuild test -scheme APIKit -destination 'platform=iOS Simulator,name=iPhone 13,OS=latest' -enableCodeCoverage YES
	xcodebuild test -scheme Domain -destination 'platform=iOS Simulator,name=iPhone 13,OS=latest' -enableCodeCoverage YES
	xcodebuild test -scheme LocalDataSource -destination 'platform=iOS Simulator,name=iPhone 13,OS=latest' -enableCodeCoverage YES
	xcodebuild test -scheme RemoteDataSource -destination 'platform=iOS Simulator,name=iPhone 13,OS=latest' -enableCodeCoverage YES
	xcodebuild test -scheme Data -destination 'platform=iOS Simulator,name=iPhone 13,OS=latest' -enableCodeCoverage YES


