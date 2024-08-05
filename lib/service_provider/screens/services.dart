import 'package:flutter/material.dart';

import '../../utils/save_buttons.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _categories = [
    {
      'icon': Icons.cleaning_services_outlined,
      'label': 'Cleaning',
      'subcategories': ['House Cleaning', 'Carpet Cleaning', 'Window Cleaning']
    },
    {
      'icon': Icons.build_circle_outlined,
      'label': 'Repairing',
      'subcategories': ['Home Repair', 'Furniture Repair', 'Appliance Repair']
    },
    // Add more categories and subcategories here...
  ];

  List<Map<String, dynamic>> _filteredCategories = [];
  final List<String> _selectedSubcategories = [];

  @override
  void initState() {
    super.initState();
    _filteredCategories = List.from(_categories);
    _searchController.addListener(_filterCategories);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCategories);
    _searchController.dispose();
    super.dispose();
  }

  void _filterCategories() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCategories = _categories
          .where((category) =>
          category['label'].toString().toLowerCase().contains(query))
          .toList();
    });
  }

  void _showSubcategories(Map<String, dynamic> category) async {
    List<String> subcategories = category['subcategories'];

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Select Subcategories for ${category['label']}'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: subcategories.map((subcategory) {
                    return CheckboxListTile(
                      title: Text(subcategory),
                      value: _selectedSubcategories.contains(subcategory),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _selectedSubcategories.add(subcategory);
                          } else {
                            _selectedSubcategories.remove(subcategory);
                          }
                        });
                        // Update the main state
                        _updateMainState();
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _updateMainState() {
    if (mounted) {
      setState(() {});
    }
  }

  void _removeSubcategory(String subcategory) {
    setState(() {
      _selectedSubcategories.remove(subcategory);
    });
  }

  Widget buildCategoryItem(Map<String, dynamic> category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => _showSubcategories(category),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(category['icon'], size: 30, color: Colors.blue),
                SizedBox(height: 10),
                Text(
                  category['label'],
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSelectedSubcategoryItem(String subcategory) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0, bottom: 8.0),
      child: Chip(
        label: Text(subcategory),
        deleteIcon: Icon(Icons.cancel),
        onDeleted: () => _removeSubcategory(subcategory),
      ),
    );
  }

  Future<void> _refresh() async {
    // Perform your data fetching or refreshing logic here.
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
  }

  void _saveSelectedSubcategories() {
    // Perform save logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected subcategories saved!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF3F5FD),
      appBar: AppBar(
        title: Text('Add Service'),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Find a service',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: _selectedSubcategories.map(buildSelectedSubcategoryItem).toList(),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                children: _filteredCategories.map((category) {
                  return buildCategoryItem(category);
                }).toList(),
              ),
            ),
            SaveButton(onPressed: _saveSelectedSubcategories),
          ],
        ),
      ),
    );
  }
}
