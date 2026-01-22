// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Movies)
final moviesProvider = MoviesFamily._();

final class MoviesProvider extends $NotifierProvider<Movies, List<Movie>> {
  MoviesProvider._({
    required MoviesFamily super.from,
    required MovieCategory super.argument,
  }) : super(
         retry: null,
         name: r'moviesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$moviesHash();

  @override
  String toString() {
    return r'moviesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Movies create() => Movies();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Movie> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Movie>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MoviesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$moviesHash() => r'a2276dcaec6745876c7887908700ec2dc7a76ed1';

final class MoviesFamily extends $Family
    with
        $ClassFamilyOverride<
          Movies,
          List<Movie>,
          List<Movie>,
          List<Movie>,
          MovieCategory
        > {
  MoviesFamily._()
    : super(
        retry: null,
        name: r'moviesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MoviesProvider call(MovieCategory category) =>
      MoviesProvider._(argument: category, from: this);

  @override
  String toString() => r'moviesProvider';
}

abstract class _$Movies extends $Notifier<List<Movie>> {
  late final _$args = ref.$arg as MovieCategory;
  MovieCategory get category => _$args;

  List<Movie> build(MovieCategory category);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<Movie>, List<Movie>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Movie>, List<Movie>>,
              List<Movie>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
