import 'package:cinelog/color_scheme.dart';
import 'package:flutter/material.dart';

class FilterDropdown extends StatefulWidget {
  final String filterName;
  final List options;
  final Function onChanged;

  static const TextStyle _filterTextStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 13,);
  static final OutlineInputBorder _filterBorderStyle = OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: SECONDARY_COLOR));

  const FilterDropdown({super.key, required this.filterName, required this.options, required this.onChanged});

  @override
  State<FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  String? selectedFilter;
  List<DropdownMenuEntry<dynamic>> dropDownEntries = [];
  @override
  void initState() {
    super.initState();
    selectedFilter = widget.filterName;
    dropDownEntries.add(
      DropdownMenuEntry(value: 'none', label: "Nenhum",
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
          textStyle: WidgetStatePropertyAll(FilterDropdown._filterTextStyle)
        )
      )
    );
    dropDownEntries.addAll(widget.options.map((e){
        return DropdownMenuEntry(
          value: e['id'], 
          label: e['name'],
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
            textStyle: WidgetStatePropertyAll(FilterDropdown._filterTextStyle)
        )
      );
    }).toList());
    
    
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: 165,
      menuHeight: 300,
      textStyle: FilterDropdown._filterTextStyle,
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(
          OPTION_BUTTON_BACKGROUND_COLOR
        )
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: FilterDropdown._filterTextStyle,

        focusedBorder: FilterDropdown._filterBorderStyle,
        enabledBorder: FilterDropdown._filterBorderStyle
      ),
    
      hintText: widget.filterName,
      
      trailingIcon: Icon(Icons.keyboard_arrow_down, color: Colors.white54, size: 18),
      
      selectedTrailingIcon: Icon(Icons.keyboard_arrow_up, color: Colors.white54, size: 18),
      
      initialSelection: selectedFilter,
      
      dropdownMenuEntries: dropDownEntries,
    
      onSelected: (value) {
        final String? newValue = value == 'none' ? null : value?.toString(); 
        setState(() {
          selectedFilter =newValue; 
        });

        widget.onChanged(newValue);
      }
    );
  }
}

