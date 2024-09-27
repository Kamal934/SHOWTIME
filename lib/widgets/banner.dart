import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';  // Import the package
import 'package:showtime/model/all_movie.dart';

class MovieBanner extends StatefulWidget {
  final List<AllMovie> movies;

  const MovieBanner({super.key, required this.movies});

  @override
  State<MovieBanner> createState() => _MovieBannerState();
}

class _MovieBannerState extends State<MovieBanner> {
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    // Add a listener to update the current page
    _controller.addListener(() {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column( // Change to a Column to accommodate the page indicator
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            height: 200,
            child: PageView.builder(
              controller: _controller, // Set the PageController
              itemCount: widget.movies.length > 3 ? 3 : widget.movies.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.network(
                      widget.movies[index].imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          // Add the Smooth Page Indicator
          SmoothPageIndicator(
            controller: _controller, // Connect the controller
            count: widget.movies.length > 3 ? 3 : widget.movies.length,
            effect: const WormEffect(
              activeDotColor: Colors.red, // Color of the active dot
              dotColor: Colors.grey, // Color of the inactive dot
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when done
    super.dispose();
  }
}
