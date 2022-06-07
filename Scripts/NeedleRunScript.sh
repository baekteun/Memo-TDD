if test -d "/opt/homebrew/bin/"; then
	PATH="opt/homebrew/bin:${PATH}"
fi

export PATH

if which needle; then
    SOURCEKIT_LOGGING=0 && needle generate Projects/App/Sources/NeedleGenerated.swift Projects/
else
  echo "warning: Needle not installed, download from https://github.com/uber/needle using Homebrew"
fi
