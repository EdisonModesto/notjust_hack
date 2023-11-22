import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notjust_hack/commons/providers/fire_auth_provider.dart';
import 'package:notjust_hack/core/firebase/fire_firestore_api.dart';
import 'package:notjust_hack/models/user.dart';

final specificBusinessProvider = StreamProvider.autoDispose.family((ref, id) {
  final idStream = ref.watch(userIdProvider);
  final storeApi = ref.watch(firestoreApiProvider);

  final streamController = StreamController<UserModel>();

  if (idStream.value != null) {
    storeApi.getSpecificUser(id).asStream().listen((event) {
      return event.fold((l) {}, (r) {
        r.listen((event) {
          print('new data added');
          streamController.add(UserModel.fromJson(event.data()!));
        });
      });
    });
  }

  return streamController.stream;
});
