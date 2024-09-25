import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionWidget extends StatefulWidget {
  final Widget child;

  const PermissionWidget({super.key, required this.child});

  @override
  _PermissionWidgetState createState() => _PermissionWidgetState();
}

class _PermissionWidgetState extends State<PermissionWidget> {
  bool _isPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final status = await Permission.activityRecognition.status;
    if (!status.isGranted) {
      final result = await Permission.activityRecognition.request();
      setState(() {
        _isPermissionGranted = result.isGranted;
      });
    } else {
      setState(() {
        _isPermissionGranted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isPermissionGranted) {
      return const Center(
        child: Text('Please grant the necessary permissions to track your steps.'),
      );
    }

    return widget.child;
  }
}
