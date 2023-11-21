import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserScanner extends ConsumerStatefulWidget {
  const UserScanner({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserScannerState();
}

class _UserScannerState extends ConsumerState<UserScanner> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("User Scanner"),
    );
  }
}
