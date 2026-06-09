import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cinelog/models/movie.dart';

class FirestoreService {
  static final _db = FirebaseFirestore.instance;

  static String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  // Watchlist
  static Future<void> addToWatchlist(Movie movie) async {
    if (_uid == null) return;
    await _db
        .collection('users')
        .doc(_uid)
        .collection('watchlist')
        .doc(movie.movieId.toString())
        .set(movie.toMap());
  }

  static Future<void> removeFromWatchlist(int movieId) async {
    if (_uid == null) return;
    await _db
        .collection('users')
        .doc(_uid)
        .collection('watchlist')
        .doc(movieId.toString())
        .delete();
  }

  static Future<List<Movie>> getWatchlist() async {
    if (_uid == null) return [];
    final snapshot = await _db
        .collection('users')
        .doc(_uid)
        .collection('watchlist')
        .get();
    return snapshot.docs
        .map((doc) => Movie.fromFirestore(doc.data()))
        .toList();
  }

  static Future<bool> isInWatchlist(int movieId) async {
    if (_uid == null) return false;
    final doc = await _db
        .collection('users')
        .doc(_uid)
        .collection('watchlist')
        .doc(movieId.toString())
        .get();
    return doc.exists;
  }
}