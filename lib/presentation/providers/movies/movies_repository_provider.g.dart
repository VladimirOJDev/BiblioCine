// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(movieRepository)
final movieRepositoryProvider = MovieRepositoryProvider._();

final class MovieRepositoryProvider
    extends
        $FunctionalProvider<
          MovieRepositoryImpl,
          MovieRepositoryImpl,
          MovieRepositoryImpl
        >
    with $Provider<MovieRepositoryImpl> {
  MovieRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'movieRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$movieRepositoryHash();

  @$internal
  @override
  $ProviderElement<MovieRepositoryImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MovieRepositoryImpl create(Ref ref) {
    return movieRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MovieRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MovieRepositoryImpl>(value),
    );
  }
}

String _$movieRepositoryHash() => r'35ab671cb7fea73b99daf1ffe3bbbcf40b41ec63';
