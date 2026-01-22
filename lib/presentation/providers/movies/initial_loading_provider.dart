
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../providers.dart';


part 'initial_loading_provider.g.dart';


@riverpod
bool initialLoading(Ref ref){
  //Revisamos si los providers tienen data o no y regresa un boleano

  final step1 = ref.watch(moviesProvider(MovieCategory.nowPlaying)).isEmpty;
  final step2 = ref.watch(moviesProvider(MovieCategory.popular)).isEmpty;
  final step3 = ref.watch(moviesProvider(MovieCategory.upcoming)).isEmpty;
  final step4 = ref.watch(moviesProvider(MovieCategory.topRated)).isEmpty;

  if(step1 || step2 || step3 || step4) return true;
  
  return false;  
}
