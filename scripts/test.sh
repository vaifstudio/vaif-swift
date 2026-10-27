#!/bin/sh
# Runs the test suite. With a full Xcode install `swift test` alone is enough.
# With only the Command Line Tools, SwiftPM does not put swift-testing on the
# search paths, so pass them explicitly.
set -eu
cd "$(dirname "$0")/.."
DEV="$(xcode-select -p 2>/dev/null || true)"
case "$DEV" in
  */CommandLineTools)
    FW="$DEV/Library/Developer/Frameworks"
    LIB="$DEV/Library/Developer/usr/lib"
    PLUGINS="$DEV/usr/lib/swift/host/plugins/testing"
    exec swift test \
      -Xswiftc -F -Xswiftc "$FW" \
      -Xswiftc -plugin-path -Xswiftc "$PLUGINS" \
      -Xlinker -F -Xlinker "$FW" \
      -Xlinker -rpath -Xlinker "$FW" \
      -Xlinker -rpath -Xlinker "$LIB" \
      "$@"
    ;;
  *)
    exec swift test "$@"
    ;;
esac
