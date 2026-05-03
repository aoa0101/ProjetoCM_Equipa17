import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'color_scheme.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: AppBar(
        backgroundColor: APPBAR_BACKGROUND_COLOR,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: SECONDARY_COLOR),
          onPressed: () => context.pop(), 
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset("lib/images/cinelog_logo.png", width: 50),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Pesquisar filme, série...",
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: Icon(Icons.search, color: SECONDARY_COLOR),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: SECONDARY_COLOR),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: SECONDARY_COLOR, width: 2),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildFilterChip("Género"),
                  _buildFilterChip("Ano"),
                  _buildFilterChip("Idioma"),
                  _buildFilterChip("Classificação Etária"),
                  _buildFilterChip("Rating"),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Text(
                "Resultados encontrados:",
                style: TextStyle(color: SECONDARY_COLOR, fontSize: 16),
              ),

              const SizedBox(height: 15),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75, 
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return _buildMovieCard();
                },
              ),
              
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: SECONDARY_COLOR),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.keyboard_arrow_down, color: Colors.white54, size: 18),
        ],
      ),
    );
  }

  Widget _buildMovieCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEBEBEB),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          const Center(
            child: Icon(Icons.category, size: 60, color: Colors.black12),
          ),
          
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    SECONDARY_COLOR.withValues(alpha: 0.8),
                  ],
                ),
              ),
            ),
          ),
          
          const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Title",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}