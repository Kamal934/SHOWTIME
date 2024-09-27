import 'package:flutter/material.dart';
import 'package:showtime/model/search_model.dart';
import 'package:showtime/widgets/skelenton_searchscreen.dart';

class MovieCard extends StatelessWidget {
  final Movie? movie; // Allow movie to be nullable for loading state
  final VoidCallback onTap;
  final bool isLoading; // New loading state flag

  const MovieCard({
    super.key,
    required this.onTap,
    this.movie,
    this.isLoading = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SkeletonLoader(); // Show skeleton loader when loading
    }

    return GestureDetector(
      onTap: onTap,
      child: Card(
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
              // Movie image
              movie?.imageUrl.isNotEmpty ?? false
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        movie!.imageUrl,
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 60,
                            width: 60,
                            color: Colors.grey[850],
                            child: const Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                              size: 40,
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      height: 60,
                      width: 60,
                      color: Colors.grey[850],
                      child: const Icon(
                        Icons.movie,
                        color: Colors.grey,
                        size: 40,
                      ),
                    ),
              const SizedBox(width: 10),
              // Movie title and subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie?.title ?? 'Loading...',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      movie?.summary.isNotEmpty == true ? movie!.summary : 'No summary available',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              // Menu icon
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {
                  // Handle menu actions here (e.g., show options)
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
