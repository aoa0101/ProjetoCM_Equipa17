import 'package:cinelog/main_app_screens/logo_app_bar.dart';
import 'package:cinelog/models/loading.dart';
import 'package:cinelog/models/movie.dart';
import 'package:cinelog/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cinelog/color_scheme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: LogoAppBar(),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loading;
          }

          Map<String, dynamic>? userData = snapshot.data?.data();
          
          String displayName = userData?['name'] ?? currentUser?.displayName ?? "Utilizador";
          String username = userData?['username'] ?? currentUser?.email?.split('@')[0] ?? "username";

          return SingleChildScrollView(
            child: DefaultTabController(
              length: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    
                    Center(
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: SECONDARY_COLOR, width: 4),
                          color: Colors.white,
                        ),
                        child: Icon(Icons.person, size: 120, color: SECONDARY_COLOR),
                      ),
                    ),
                    
                    const SizedBox(height: 15),
                    
                    Text(
                      displayName,
                      style: TextStyle(color: SECONDARY_COLOR, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "@$username",
                      style: const TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(currentUser?.uid)
                          .collection('watched')
                          .snapshots(),
                      builder: (context, watchedSnapshot) {
                        int moviesWatchedCount = watchedSnapshot.data?.docs.length ?? 0;
                        
                        int totalHours = moviesWatchedCount * 2;
                        String screenTime = "${totalHours}h";

                        int comedyCount = 0;
                        int horrorCount = 0;
                        int romanceCount = 0;
                        int thrillerCount = 0;

                        if (watchedSnapshot.hasData) {
                          for (var doc in watchedSnapshot.data!.docs) {
                            var data = doc.data() as Map<String, dynamic>?;
                            if (data != null) {
                              var genreData = data['genre'] ?? data['genres'] ?? '';
                              
                              if (genreData is List) {
                                for (var g in genreData) {
                                  String genreStr = g.toString().toLowerCase();
                                  if (genreStr.contains('comé') || genreStr.contains('comed')) comedyCount++;
                                  if (genreStr.contains('terr') || genreStr.contains('horror')) horrorCount++;
                                  if (genreStr.contains('romanc')) romanceCount++;
                                  if (genreStr.contains('thrill') || genreStr.contains('suspens')) thrillerCount++;
                                }
                              } else {
                                String genreStr = genreData.toString().toLowerCase();
                                if (genreStr.contains('comé') || genreStr.contains('comed')) comedyCount++;
                                if (genreStr.contains('terr') || genreStr.contains('horror')) horrorCount++;
                                if (genreStr.contains('romanc')) romanceCount++;
                                if (genreStr.contains('thrill') || genreStr.contains('suspens')) thrillerCount++;
                              }
                            }
                          }
                        }

                        String comedyPct = moviesWatchedCount > 0 ? "${((comedyCount / moviesWatchedCount) * 100).toStringAsFixed(0)}%" : "0%";
                        String horrorPct = moviesWatchedCount > 0 ? "${((horrorCount / moviesWatchedCount) * 100).toStringAsFixed(0)}%" : "0%";
                        String romancePct = moviesWatchedCount > 0 ? "${((romanceCount / moviesWatchedCount) * 100).toStringAsFixed(0)}%" : "0%";
                        String thrillerPct = moviesWatchedCount > 0 ? "${((thrillerCount / moviesWatchedCount) * 100).toStringAsFixed(0)}%" : "0%";

                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF2D2D2D),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  _buildStatRow(moviesWatchedCount.toString(), "Filmes Vistos"),
                                  const Divider(color: Colors.white24, height: 1),
                                  _buildStatRow(screenTime, "Tempo de Ecrã"),
                                ],
                              ),
                            ),
                            
                            const SizedBox(height: 30),
                            
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "As minhas preferências",
                                style: TextStyle(color: SECONDARY_COLOR, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            
                            const SizedBox(height: 20),
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildPreferenceCircle(comedyPct, "Comédia"),
                                _buildPreferenceCircle(horrorPct, "Terror"),
                                _buildPreferenceCircle(romancePct, "Romance"),
                                _buildPreferenceCircle(thrillerPct, "Thriller"),
                              ],
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 30),
                    
                    TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      dividerColor: Colors.transparent,
                      indicatorColor: SECONDARY_COLOR,
                      labelColor: SECONDARY_COLOR,
                      unselectedLabelColor: Colors.white54,
                      tabs: const [
                        Tab(text: "Favoritos"),
                        Tab(text: "Assistidos"),
                      ],
                    ),
      
                    const SizedBox(height: 15),
                    
                    SizedBox(
                      height: 180, 
                      child: TabBarView(
                        children: [
                          _buildMovieList(FirestoreService.getFavorites()),
                          _buildMovieList(FirestoreService.getWatched()),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40), 
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatRow(String value, String label) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(value, style: TextStyle(color: SECONDARY_COLOR, fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
    );
  }

  Widget _buildPreferenceCircle(String percentage, String label) {
    double doubleValue = 0.0;
    try {
      doubleValue = double.parse(percentage.replaceAll('%', '')) / 100;
    } catch (_) {}

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: doubleValue,
                backgroundColor: Colors.white12,
                color: SECONDARY_COLOR,
                strokeWidth: 6,
              ),
            ),
            Text(percentage, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 11)),
      ],
    );
  }

  Widget _buildMovieList(Future<List<Movie>> movieFuture) {
    return FutureBuilder<List<Movie>>(
      future: movieFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFD3AF63)),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              "Nenhum filme adicionado.",
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
          );
        }

        final movies = snapshot.data!;

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(movie.imgPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}