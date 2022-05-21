export FLUTTER="/home/e/Documents/flutter"
export DART="$FLUTTER/bin/cache/dart-sdk"
export ENGINE="/home/e/Documents/flutter-engine-binaries-for-arm-main/arm64"

rm -rf ./build
flutter pub get
flutter build bundle
$DART/bin/dart $DART/bin/snapshots/frontend_server.dart.snapshot --sdk-root $FLUTTER/bin/cache/artifacts/engine/common/flutter_patched_sdk_product --target=flutter --aot --tfa -Ddart.vm.product=true --packages .packages --output-dill build/kernel_snapshot.dill --verbose --depfile build/kernel_snapshot.d package:example/main.dart
$ENGINE/gen_snapshot_linux_x64_release --deterministic --snapshot_kind=app-aot-elf --elf=build/flutter_assets/app.so --strip build/kernel_snapshot.dill

