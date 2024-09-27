import 'package:flutter/material.dart';

class FullScreenSkeletonLoader extends StatelessWidget {
  const FullScreenSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'SHOWTIME',
              style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.search, color: Colors.white),
          ],
        ),
      ),
      body: Column(
        children: [
          // Movie Banner Skeleton
          Container(
            margin: const EdgeInsets.all(10.0),
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          const SizedBox(height: 20),
          // Section Header Skeleton
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            height: 20,
            width: double.infinity,
            color: Colors.grey[900],
          ),
          const SizedBox(height: 10),
          // Grid Skeleton
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: 5, // Number of skeleton cards
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
