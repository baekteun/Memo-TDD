generate:
	tuist generate

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

test:
	tuist test LocalDataSource -d 'iPhone 13' -o latest
	tuist test RemoteDataSource -d 'iPhone 13' -o latest
	tuist test CommonFeature -d 'iPhone 13' -o latest
	tuist test MemoListFeature -d 'iPhone 13' -o latest
	tuist test Core -d 'iPhone 13' -o latest
	tuist test Utility -d 'iPhone 13' -o latest
	tuist test APIKit -d 'iPhone 13' -o latest
	tuist test Domain -d 'iPhone 13' -o latest
	tuist test Data -d 'iPhone 13' -o latest


