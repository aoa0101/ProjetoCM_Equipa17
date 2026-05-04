import 'package:cinelog/main_app_screens/logo_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cinelog/color_scheme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PRIMARY_COLOR,
        appBar: LogoAppBar(),

        body: SingleChildScrollView(
          child:DefaultTabController(
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
                  "João Inácio",
                  style: TextStyle(color: SECONDARY_COLOR, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "@username",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                
                const SizedBox(height: 30),
                
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildStatRow("142", "Filmes Vistos"),
                      const Divider(color: Colors.white24, height: 1),
                      _buildStatRow("34", "Séries Vistas"),
                      const Divider(color: Colors.white24, height: 1),
                      _buildStatRow("520h", "Tempo de Ecrã"),
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
                    _buildPreferenceCircle("80%", "Comédia"),
                    _buildPreferenceCircle("60%", "Terror"),
                    _buildPreferenceCircle("50%", "Romance"),
                    _buildPreferenceCircle("20%", "Thriller"),
                  ],
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
                      _buildMovieList(),
                      _buildMovieList(),
                    ],
                  ),
                ),

                const SizedBox(height: 40), 
              ],
            ),
          ),
        ),
      )
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
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: double.parse(percentage.replaceAll('%', '')) / 100,
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

  Widget _buildMovieList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(Icons.movie_creation_outlined, color: Colors.white24, size: 40),
            ),
          ),
        );
      },
    );
  }
}