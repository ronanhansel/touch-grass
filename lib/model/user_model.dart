import 'post_model.dart';

class User {
  final String profileImageUrl;
  final String backgroundImageUrl;
  final String name;
  final List<Post> posts;
  final int level;
  final int experience;

  User({
    required this.profileImageUrl,
    required this.backgroundImageUrl,
    required this.name,
    required this.posts,
    required this.level,
    required this.experience
  });
}