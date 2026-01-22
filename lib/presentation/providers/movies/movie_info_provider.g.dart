// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_info_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MovieInfo)
final movieInfoProvider = MovieInfoProvider._();

final class MovieInfoProvider
    extends $NotifierProvider<MovieInfo, Map<String, Movie>> {
  MovieInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'movieInfoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$movieInfoHash();

  @$internal
  @override
  MovieInfo create() => MovieInfo();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, Movie> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, Movie>>(value),
    );
  }
}

String _$movieInfoHash() => r'e25512cc9388d9332069ba8aba3714a7bf0ed47b';

abstract class _$MovieInfo extends $Notifier<Map<String, Movie>> {
  Map<String, Movie> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Map<String, Movie>, Map<String, Movie>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, Movie>, Map<String, Movie>>,
              Map<String, Movie>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
