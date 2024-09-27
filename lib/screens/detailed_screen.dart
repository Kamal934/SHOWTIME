import 'package:flutter/material.dart';
import 'package:showtime/model/all_movie.dart';
import 'package:showtime/model/search_model.dart'; // Import for Movie

class DetailsScreen extends StatelessWidget {
  final dynamic movie; // Use dynamic to accommodate both Movie and AllMovie

  const DetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image
          Positioned(
            child: Image.network(
              _getImageUrl(movie), // Use a helper function to get the image URL
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          // Gradient overlay
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.9),
                  Colors.black.withOpacity(1.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.only(top: 400.0), // Adjusted vertical padding to start below the image
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Movie Title
                    Text(
                      _getTitle(movie), // Use a helper function to get the title
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    // Action buttons (Watch Now, etc.)
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                          ),
                          child: const Text("Watch Now", style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          icon: const Icon(Icons.favorite_border, color: Colors.white),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.share, color: Colors.white),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.download, color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Summary Section (Expandable)
                    _getSummary(movie), // Use a helper function to get the summary
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getImageUrl(dynamic movie) {
    if (movie is AllMovie) {
      return movie.imageUrl; // Use AllMovie's image URL
    } else if (movie is Movie) {
      return movie.imageUrl; // Use Movie's image URL
    }
    return ''; // Fallback if movie type is unknown
  }

  String _getTitle(dynamic movie) {
    if (movie is AllMovie) {
      return movie.title.isNotEmpty ? movie.title : 'No Title'; // Handle missing title
    } else if (movie is Movie) {
      return movie.title.isNotEmpty ? movie.title : 'No Title'; // Handle missing title
    }
    return 'No Title'; // Fallback if movie type is unknown
  }

  Widget _getSummary(dynamic movie) {
    String summary;
    if (movie is AllMovie) {
      summary = movie.summary.isNotEmpty ? movie.summary : 'No Summary'; // Handle missing summary
    } else if (movie is Movie) {
      summary = movie.summary.isNotEmpty ? movie.summary : 'No Summary'; // Handle missing summary
    } else {
      summary = 'No Summary'; // Fallback if movie type is unknown
    }

    return Text(
      summary,
      style: const TextStyle(fontSize: 14, color: Colors.grey),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
