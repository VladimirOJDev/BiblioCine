// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actors_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(actorsRepository)
final actorsRepositoryProvider = ActorsRepositoryProvider._();

final class ActorsRepositoryProvider
    extends
        $FunctionalProvider<
          ActorRepositoryImpl,
          ActorRepositoryImpl,
          ActorRepositoryImpl
        >
    with $Provider<ActorRepositoryImpl> {
  ActorsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'actorsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$actorsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ActorRepositoryImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ActorRepositoryImpl create(Ref ref) {
    return actorsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ActorRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ActorRepositoryImpl>(value),
    );
  }
}

String _$actorsRepositoryHash() => r'ecd6e6f0caf0b7e305c050d6d0f985d086466a7a';
