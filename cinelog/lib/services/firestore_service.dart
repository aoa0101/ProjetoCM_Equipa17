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

  // --- FAVORITOS ---
  static Future<void> addToFavorites(Movie movie) async {
    if (_uid == null) return;
    await _db
        .collection('users')
        .doc(_uid)
        .collection('favorites')
        .doc(movie.movieId.toString())
        .set(movie.toMap());
  }

  static Future<void> removeFromFavorites(int movieId) async {
    if (_uid == null) return;
    await _db
        .collection('users')
        .doc(_uid)
        .collection('favorites')
        .doc(movieId.toString())
        .delete();
  }

  static Future<List<Movie>> getFavorites() async {
    if (_uid == null) return [];
    final snapshot = await _db
        .collection('users')
        .doc(_uid)
        .collection('favorites')
        .get();
    return snapshot.docs
        .map((doc) => Movie.fromFirestore(doc.data()))
        .toList();
  }

  static Future<bool> isInFavorites(int movieId) async {
    if (_uid == null) return false;
    final doc = await _db
        .collection('users')
        .doc(_uid)
        .collection('favorites')
        .doc(movieId.toString())
        .get();
    return doc.exists;
  }

  // --- ASSISTIDOS (VISTO) ---
  static Future<void> addToWatched(Movie movie) async {
    if (_uid == null) return;
    await _db
        .collection('users')
        .doc(_uid)
        .collection('watched')
        .doc(movie.movieId.toString())
        .set(movie.toMap());
  }

  static Future<void> removeFromWatched(int movieId) async {
    if (_uid == null) return;
    await _db
        .collection('users')
        .doc(_uid)
        .collection('watched')
        .doc(movieId.toString())
        .delete();
  }

  static Future<List<Movie>> getWatched() async {
    if (_uid == null) return [];
    final snapshot = await _db
        .collection('users')
        .doc(_uid)
        .collection('watched')
        .get();
    return snapshot.docs
        .map((doc) => Movie.fromFirestore(doc.data()))
        .toList();
  }

  static Future<bool> isInWatched(int movieId) async {
    if (_uid == null) return false;
    final doc = await _db
        .collection('users')
        .doc(_uid)
        .collection('watched')
        .doc(movieId.toString())
        .get();
    return doc.exists;
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserProfileStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("Nenhum utilizador autenticado!");
    }
    return FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots();
  }

  static Future<void> generateNotification(String title, String description) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('notifications')
          .add({
        'title': title,
        'description': description,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Erro ao gerar notificação: $e");
    }
  }

  static Future<void> triggerWatchlistReminder() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    try {
      final watchlistSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('watchlist')
          .get();

      if (watchlistSnapshot.docs.isNotEmpty) {
        final docs = watchlistSnapshot.docs;
        docs.shuffle(); 
        final randomMovieDoc = docs.first;
        
        var movieData = randomMovieDoc.data();
        String movieTitle = movieData['title'] ?? 'um filme da tua lista';

        await generateNotification(
          "O que vais ver hoje? 🍿",
          "Ainda tens '$movieTitle' na tua Watchlist. Que tal aproveitares hoje para o ver?",
        );
      } else {
        await generateNotification(
          "Watchlist vazia! 🎬",
          "Não tens nenhum filme pendente. Explora o catálogo e adiciona novos filmes!",
        );
      }
    } catch (e) {
      print("Erro ao gerar lembrete de watchlist: $e");
    }
  }

  static Future<String> getUserNote(int movieId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return '';

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('notes')
          .doc(movieId.toString())
          .get();

      if (doc.exists) {
        return doc.data()?['note'] ?? '';
      }
    } catch (e) {
      print("Erro ao ir buscar a nota: $e");
    }
    return '';
  }

  static Future<void> saveUserNote(int movieId, String note, String movieTitle) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('notes')
          .doc(movieId.toString()) 
          .set({
        'movieId': movieId,
        'movieTitle': movieTitle,
        'note': note,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Erro ao guardar a nota: $e");
      rethrow;
    }
  }
}
