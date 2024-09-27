
class AllMovie {
  final String title;
  final String summary;
  final String imageUrl;

  AllMovie({required this.title, required this.summary, required this.imageUrl});

  factory AllMovie.fromJson(Map<String, dynamic> json) {
    return AllMovie(
      title: json['show']['name'] ?? 'No Title',
      summary: json['show']['summary'] ?? 'No Summary',
      imageUrl: json['show']['image'] != null
          ? json['show']['image']['medium'] ?? ''
          : '',
    );
  }
}
