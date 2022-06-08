name: Pr

on:
  pull_request:
    branches: [ "master" ]


jobs:
  pr_with_ci:
    runs-on: macos-latest

    steps:
    - uses: actions/checkout@v3
      with:
        xcode-version: latest
    - name: Tuist Setup
      run: make setup
      
    - name: project Generate
      run: |
        rm -rf .package.resolved
        make generate
        
    - name: All Scheme Test
      run: |
        make test
    - name: Upload coverage to Codecov
      uses: codecov/codecov-action@v1
      with:
        fail_ci_if_error: true
