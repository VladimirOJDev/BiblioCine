// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initial_loading_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(initialLoading)
final initialLoadingProvider = InitialLoadingProvider._();

final class InitialLoadingProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  InitialLoadingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'initialLoadingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$initialLoadingHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return initialLoading(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$initialLoadingHash() => r'eb26c4101c9765c756241958dc7d3533e90df19f';
