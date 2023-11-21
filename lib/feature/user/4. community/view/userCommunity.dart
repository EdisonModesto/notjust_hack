import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserCommunity extends ConsumerStatefulWidget {
  const UserCommunity({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserCommunityState();
}

class _UserCommunityState extends ConsumerState<UserCommunity> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("User Community"),
    );
  }
}
