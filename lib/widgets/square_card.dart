import 'package:flutter/material.dart';
import 'package:showtime/model/all_movie.dart';
import 'package:showtime/screens/detailed_screen.dart';

class MovieCardSquare extends StatelessWidget {
  final AllMovie allmovie;

  const MovieCardSquare({super.key, required this.allmovie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the details screen when tapped
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => DetailsScreen(movie: allmovie)),
        );
      },
      child: Card(
        color: Colors.grey[850], // Card background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(children: [
          allmovie.imageUrl.isNotEmpty
              ? Image.network(allmovie.imageUrl, fit: BoxFit.fill)
              : Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.grey,
                  child: const Icon(Icons.image,
                      color: Colors.white), // Placeholder icon
                ),
          // Gradient overlay
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Movie Title
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Positioned(
              top: 200,
              child: Text(
                allmovie.title.isNotEmpty
                    ? allmovie.title
                    : '', // Handle missing title
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
