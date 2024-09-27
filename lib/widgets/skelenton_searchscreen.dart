import 'package:flutter/material.dart';

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Skeleton image
            Container(
              height: 60,
              width: 60,
              color: Colors.grey[800],
            ),
            const SizedBox(width: 10),
            // Skeleton title and summary
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14,
                    width: double.infinity,
                    color: Colors.grey[800],
                  ),
                  const SizedBox(height: 3),
                  Container(
                    height: 11,
                    width: double.infinity,
                    color: Colors.grey[800],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 11,
                    width: double.infinity,
                    color: Colors.grey[800],
                  ),
                ],
              ),
            ),
            // Skeleton menu icon
            Container(
              height: 30,
              width: 30,
              color: Colors.grey[800],
            ),
          ],
        ),
      ),
    );
  }
}
