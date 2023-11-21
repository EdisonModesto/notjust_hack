import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:notjust_hack/core/firebase/fire_firestore_api.dart';
import 'package:notjust_hack/models/user.dart';
import 'package:notjust_hack/utils/logger.dart';

final authStoreRepoProvider = StateProvider<StoreAuthRepo>((ref) {
  final api = ref.watch(firestoreApiProvider);
  return StoreAuthRepo(firestoreApi: api);
});

class StoreAuthRepo {
  FirestoreApi firestoreApi;

  StoreAuthRepo({required this.firestoreApi});

  Future<Either<String, String>> createUser(UserModel user) async {
    final result = await firestoreApi.createUser(user);

    return result.fold((error) {
      Log().error(error);
      return Left(error);
    }, (success) {
      Log().info('Account created in firestore');
      return Right(success);
    });
  }
}
