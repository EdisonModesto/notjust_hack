import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notjust_hack/commons/providers/fire_auth_provider.dart';
import 'package:notjust_hack/core/firebase/fire_firestore_api.dart';
import 'package:notjust_hack/models/user.dart';

final businessesProvider = StreamProvider.autoDispose((ref) {
  final idStream = ref.watch(userIdProvider);
  final storeApi = ref.watch(firestoreApiProvider);

  final streamController = StreamController<List<UserModel>>();

  if (idStream.value != null) {
    storeApi.getBusinesses().asStream().listen((event) {
      return event.fold((l) {}, (r) {
        r.listen((event) {
          print('new data added');
          streamController.add(event.docs.map((e) => UserModel.fromJson({'id': e.id, ...e.data()})).toList());
        });
      });
    });
  }

  return streamController.stream;
});
