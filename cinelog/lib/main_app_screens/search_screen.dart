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
      
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      FilterDropdown(filterName: 'Género', options: filtersMap['genres'] ?? [],),
                      FilterDropdown(filterName: 'Ano', options: filtersMap['years'] ?? []),
                      FilterDropdown(filterName:"Idioma", options: filtersMap['languages'] ?? []),
                      FilterDropdown(filterName:"Faixa Etária", options: filtersMap['certifications'] ?? []),
                      FilterDropdown(filterName:"Rating", options: filtersMap['ratings'] ?? []),
                      ],
                    ),
                  ),
                ),
      
                const SizedBox(height: 30),
      
                Text(
                  "Resultados encontrados:",
                  style: TextStyle(color: SECONDARY_COLOR, fontSize: 16),
                ),
      
                const SizedBox(height: 15),
      
                //MovieGrid(neverScrollable: true,),
      
                const SizedBox(height: 30),
              ],
              ),
            ),
          );
        }
        return loading;
      },
    ),
    );
  }

}
