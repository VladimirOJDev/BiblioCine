// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actors_by_movie_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ActorsByMovie)
final actorsByMovieProvider = ActorsByMovieProvider._();

final class ActorsByMovieProvider
    extends $NotifierProvider<ActorsByMovie, Map<String, List<Actor>>> {
  ActorsByMovieProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'actorsByMovieProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$actorsByMovieHash();

  @$internal
  @override
  ActorsByMovie create() => ActorsByMovie();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, List<Actor>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, List<Actor>>>(value),
    );
  }
}

String _$actorsByMovieHash() => r'c00a1cb5be5b070a84a04848f52a8b8e424314a8';

abstract class _$ActorsByMovie extends $Notifier<Map<String, List<Actor>>> {
  Map<String, List<Actor>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<Map<String, List<Actor>>, Map<String, List<Actor>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, List<Actor>>, Map<String, List<Actor>>>,
              Map<String, List<Actor>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
