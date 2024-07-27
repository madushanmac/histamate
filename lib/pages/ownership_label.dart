import 'package:flutter/material.dart';

class OwnershipLabel extends StatelessWidget {

  final Widget child;
  final String ownerName;

  const OwnershipLabel({super.key, required this.child, required this.ownerName});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          bottom: 15,
          right: 50,
          child: Text(
            'Owned by $ownerName',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
