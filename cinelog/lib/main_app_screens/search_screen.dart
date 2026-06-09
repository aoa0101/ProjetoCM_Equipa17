import 'package:cinelog/main_app_screens/filter_dropdown.dart';
import 'package:cinelog/main_app_screens/logo_app_bar.dart';
import 'package:cinelog/main_app_screens/movie_widgets/movie_grid.dart';
import 'package:cinelog/models/loading.dart';
import 'package:cinelog/services/services.dart';
import 'package:flutter/material.dart';
import 'package:cinelog/color_scheme.dart';

class SearchScreen extends StatefulWidget {

  const SearchScreen({super.key});

  @override
  State<StatefulWidget> createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen>{
  late Future filterRequest;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _controller = ScrollController();

  String searchValue = '';
  String? genreValue;
  String? languageValue;
  String? yearValue;
  String? ageRatingValue;
  String? ratingValue;

  Map currentFilters = {};

  @override
  void initState() {
    super.initState();
    filterRequest = ApiService.getFiltersContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: PRIMARY_COLOR,
    appBar: LogoAppBar(),
    body: FutureBuilder(
      future: filterRequest,
      builder: (context, asyncSnapshot){
        if(asyncSnapshot.hasData){
          final Map filtersMap = asyncSnapshot.requireData;

          return SingleChildScrollView(
          controller: _controller,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onFieldSubmitted: (value) {
                          setState(() {
                            searchValue = value;
                            currentFilters['genre'] = genreValue;
                            currentFilters['language'] = languageValue;
                            currentFilters['year'] = yearValue;
                            currentFilters['ageRating'] = ageRatingValue;
                            currentFilters['rating'] = ratingValue;
                          });
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Pesquisar filme...",
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
                
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 10,
                          runSpacing: 10,
                          children: [ //Filters
                            FilterDropdown(filterName: 'Género', options: filtersMap['genres'] ?? [], onChanged: (value) => setState(() => genreValue = value?.toString())),
                            FilterDropdown(filterName: 'Ano', options: filtersMap['years'] ?? [], onChanged: (value) => setState(() => yearValue = value?.toString())),
                            FilterDropdown(filterName:"Idioma", options: filtersMap['languages'] ?? [], onChanged: (value) => setState(() => languageValue = value?.toString())),
                            FilterDropdown(filterName:"Faixa Etária", options: filtersMap['certifications'] ?? [], onChanged: (value) => setState(() => ageRatingValue = value?.toString())),
                            FilterDropdown(filterName:"Rating", options: filtersMap['ratings'] ?? [], onChanged: (value) => setState(() => ratingValue = value?.toString())),
                            ],
                          ),
                        ),
                      ),
                    ],
                    ),
                ),
                const SizedBox(height: 30),

                Text(
                  "Resultados encontrados:",
                  style: TextStyle(color: SECONDARY_COLOR, fontSize: 16),
                ),

                const SizedBox(height: 15),

                (searchValue.isNotEmpty) ? MovieGrid(neverScrollable: true, searchQuery: searchValue, controller: _controller, filters: currentFilters,) : 
                  Center(
                    heightFactor: 10, 
                    child: Text(
                      'Sem resultados', 
                      style: TextStyle(
                        color: SECONDARY_COLOR,
                        fontSize: 25
                      )
                    ),
                  ),
                  

                const SizedBox(height: 30),
              ],
            )
            ),
          );
        }
        return loading;
      },
    ),
    );
  }
}
