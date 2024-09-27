import 'package:flutter/material.dart';
import 'package:showtime/model/all_movie.dart';
import 'package:showtime/screens/detailed_screen.dart';
import 'package:showtime/widgets/square_card.dart';

class AllMoviesScreen extends StatelessWidget {
  final List<AllMovie> allmovies;

  const AllMoviesScreen({super.key, required this.allmovies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.arrow_back_ios,color: Colors.white),
            Text('All Movies',style: TextStyle(fontSize: 18,color: Colors.white),),
            Icon(Icons.more_vert_outlined,color: Colors.white),
          ],
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 cards per row
          childAspectRatio: 0.7,
        ),
        itemCount: allmovies.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to DetailsScreen with the selected movie
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(movie: allmovies[index]),
                ),
              );
            },
            child: MovieCardSquare(allmovie: allmovies[index]),
          );}));
  }
}
