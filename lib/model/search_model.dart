import 'package:html/parser.dart';

class Movie {
  final String title;
  final String summary;
  final String imageUrl;

  Movie({
    required this.title,
    required this.summary,
    required this.imageUrl,
  });

  // Function to strip HTML tags from the summary
  String stripHtmlTags(String htmlString) {
    final document = parse(htmlString);
    return parse(document.body?.text).documentElement?.text ?? '';
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['name'] ?? 'No title',
      summary: json['summary'] != null
          ? parse(json['summary']).documentElement?.text ?? 'No summary'
          : 'No summary',
      imageUrl: json['image']['medium'] 
    );
  }
}
