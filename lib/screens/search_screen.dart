import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:showtime/model/search_model.dart';
import 'package:showtime/screens/detailed_screen.dart';
import 'package:showtime/widgets/bottom_navigationbar.dart';
import 'package:showtime/widgets/movie_card.dart';
import 'package:showtime/widgets/skelenton_searchscreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Movie> searchResults = [];
  bool isLoading = false; // To track loading state

  // Function to search movies from API
  void searchMovies(String query) async {
    if (query.isEmpty) {
      return; // Do nothing if the query is empty
    }
    
    setState(() {
      isLoading = true; // Start loading
    });

    final apiKey = dotenv.env['API_KEY'];
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query&api_key=$apiKey'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      setState(() {
        searchResults = jsonResponse.map((movie) => Movie.fromJson(movie['show'])).toList();
        isLoading = false; // Stop loading
      });
    } else {
      setState(() {
        isLoading = false; // Stop loading on error
      });
      if (kDebugMode) {
        print("Error: Failed to load movies");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.arrow_back_ios, color: Colors.white),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 10, top: 10),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[850],
                    hintText: 'Search for a movie...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[900]),
                  ),
                  onSubmitted: (query) => searchMovies(query),
                ),
              ),
            ),
            const Icon(Icons.more_vert, color: Colors.white),
          ],
        ),
      ),
      body: searchResults.isEmpty
              ? const Center(
                  child: Text(
                    'Search for movies to see results',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 4.0, // Aspect ratio for movie cards
                  ),
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final movie = searchResults[index];
                    return MovieCard(
                      movie: movie,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(movie: movie),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
