// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_slideshow_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(moviesSlideshow)
final moviesSlideshowProvider = MoviesSlideshowProvider._();

final class MoviesSlideshowProvider
    extends $FunctionalProvider<List<Movie>, List<Movie>, List<Movie>>
    with $Provider<List<Movie>> {
  MoviesSlideshowProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'moviesSlideshowProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$moviesSlideshowHash();

  @$internal
  @override
  $ProviderElement<List<Movie>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Movie> create(Ref ref) {
    return moviesSlideshow(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Movie> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Movie>>(value),
    );
  }
}

String _$moviesSlideshowHash() => r'21d79fd935684c01910971de9e9e16e0f5917468';
