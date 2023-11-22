import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:notjust_hack/models/user.dart';
import 'package:notjust_hack/utils/logger.dart';

import '../../commons/providers/fire_auth_provider.dart';

final firestoreApiProvider = StateProvider<FirestoreApi>((ref) {
  final userId = ref.watch(userIdProvider);
  return FirestoreApi(userID: userId.value ?? '');
});

class FirestoreApi {
  String userID;
  FirestoreApi({required this.userID});

  final _users = FirebaseFirestore.instance.collection('Users');

  Future<Either<String, String>> createUser(UserModel user) async {
    try {
      Log().info('Creating user with userId: $userID');
      await _users.doc(userID).set(user.toJson());

      return const Right('Firestore: Create user successfull');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Stream<DocumentSnapshot<Map<String, dynamic>>>>> getUser() async {
    try {
      Log().info('Getting user with userId: $userID');
      final user = _users.doc(userID).snapshots();
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Stream<QuerySnapshot<Map<String, dynamic>>>>> getBusinesses() async {
    try {
      Log().info('Getting all businesses');

      final user = _users.where('type', isEqualTo: 'business').orderBy('location', descending: false).snapshots();
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Stream<DocumentSnapshot<Map<String, dynamic>>>>> getSpecificUser(userId) async {
    try {
      Log().info('Getting specific user with userId: $userId');
      final user = _users.doc(userId).snapshots();
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
