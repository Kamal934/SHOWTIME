import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:showtime/model/all_movie.dart';
import 'package:showtime/screens/detailed_screen.dart';
import 'package:showtime/screens/search_screen.dart';
import 'package:showtime/widgets/banner.dart';
import 'package:showtime/widgets/bottom_navigationbar.dart';
import 'package:showtime/widgets/section_header.dart';
import 'package:showtime/widgets/skelentizer_loader_homescreen.dart';
import 'package:showtime/widgets/square_card.dart';

Future<List<AllMovie>> fetchMovies() async {
  final apiKey = dotenv.env['API_KEY'];
  final response = await http.get(
    Uri.parse('https://api.tvmaze.com/search/shows?q=all&api_key=$apiKey'),
  );

  if (kDebugMode) {
    print('Response status: ${response.statusCode}');
  }
  if (kDebugMode) {
    print('Response body: ${response.body}');
  }

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((movie) => AllMovie.fromJson(movie)).toList();
  } else {
    throw Exception('Failed to load movies');
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<AllMovie>> futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'SHOWTIME',
              style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              ),
              child: const Icon(Icons.search, color: Colors.white),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<AllMovie>>(
        future: futureMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const FullScreenSkeletonLoader(); // Use skeleton loader
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          } else if (snapshot.hasData) {
            List<AllMovie> movies = snapshot.data!;
            return CustomScrollView(
              slivers: [
                // Wrap MovieBanner in SliverToBoxAdapter
                SliverToBoxAdapter(
                  child: MovieBanner(movies: movies),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 20),
                ),
                const SliverToBoxAdapter(
                  child: SectionHeader(
                    title: 'All Movies',
                    action: '',
                  ),
                ),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(movie: movies[index]),
                            ),
                          );
                        },
                        child: MovieCardSquare(allmovie: movies[index]),
                      );
                    },
                    childCount: movies.length > 5 ? 5 : movies.length,
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator(color: Colors.red));
        },
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
