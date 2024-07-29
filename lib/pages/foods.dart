import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:hista_mate/models/category_model.dart';
import 'package:iconsax/iconsax.dart';

class Foods extends StatefulWidget {
  const Foods({Key? key}) : super(key: key);

  @override
  State<Foods> createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {
  final _firestore = FirebaseFirestore.instance.collection('foods');
  final _searchController = TextEditingController();
  final List<String> ingredients = ['Gelatin', 'Tomato', 'Vinegar', 'Caffeine','Yeast']; // update ingredients

  List<String> selectedIngredients = [];
  List<Map<String, dynamic>> _posts = [];
  List<Map<String, dynamic>> _filteredPosts = [];
  List<CategoryModel> categories = [];

  @override
  void initState() {
    super.initState();
    _listenForPosts();
    _searchController.addListener(_filterPosts);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterPosts);
    _searchController.dispose();
    super.dispose();
  }

  void _listenForPosts() {
    _fetchFilteredPosts();
  }

  Future<void> _fetchFilteredPosts() async {
    QuerySnapshot querySnapshot;
    if (selectedIngredients.isEmpty) {
      querySnapshot = await _firestore.get(); // Fetch all posts
    } else {
      querySnapshot = await _firestore
          .where('ingredients', arrayContainsAny: selectedIngredients)
          .get();
    }
    setState(() {
      _posts = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>..['id'] = doc.id;
      }).toList();
      _filterPosts();
    });
  }


  void _filterPosts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPosts = _posts.where((post) {
        final title = post['title']?.toLowerCase() ?? '';
        return title.contains(query);
      }).toList();
    });
  }

  void _getCategories() {
    categories = CategoryModel.getCategories();
  }

  void _toggleIngredientSelection(String ingredient) {
    setState(() {
      if (selectedIngredients.contains(ingredient)) {
        selectedIngredients.remove(ingredient);
      } else {
        selectedIngredients.add(ingredient);
      }
      _fetchFilteredPosts();
    });
  }


  @override
  Widget build(BuildContext context) {
    _getCategories();
    return Scaffold(
      appBar: appBar(),
      body: ListView(
        children: [
          _searchField(),
          Column(
            children: [
          Container(
          padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: ingredients.map((e) {
            final isSelected = selectedIngredients.contains(e);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: FilterChip(
                label: Text(
                  e,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
                selected: isSelected,
                onSelected: (_) => _toggleIngredientSelection(e),
                selectedColor: Colors.lightGreen,
                checkmarkColor: Colors.white,
                backgroundColor: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            );
          }).toList(),
        ),
      ),
          )
            ],
          ),
          midContainer(),
          // _similarFoods(),
        ],
      ),
    );
  }



  // mid container filtered items
  Widget midContainer() {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(8.0),
      height: MediaQuery.sizeOf(context).height * 1,
      child: _filteredPosts.isEmpty
          ? Center(
        child: Text(
          'No food items match the selected ingredients',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
          ),
        ),
      )
          : ListView.builder(
        itemCount: _filteredPosts.length,
        itemBuilder: (context, index) {
          final post = _filteredPosts[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Card(
              child: ListTile(
                title: Text(
                  post['title'] ?? 'No Title',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    letterSpacing: 0.5,
                  ),
                ),
                subtitle: Text(post['description'] ?? 'No Description',style: TextStyle(fontSize: 15.0),),
                leading: (post['imageUrl'] != null &&
                    post['imageUrl']!.isNotEmpty)
                    ? Image.network(post['imageUrl']!,
                    width: 80, height: 120, fit: BoxFit.contain)
                    : const Icon(Icons.image_not_supported),
                // trailing: SizedBox(
                //   width: 100,
                //   height: 20,
                //   child: RatingBar(
                //     size: 20,
                //     initialRating: post['rating'] ?? 0,
                //     maxRating: 5,
                //     emptyIcon: Icons.star,
                //     filledColor: Colors.orange,
                //     emptyColor: Colors.grey,
                //     halfFilledColor: Colors.orangeAccent,
                //     onRatingChanged: (rating) async {
                //       await _firestore
                //           .doc(post['id'])
                //           .update({'rating': rating});
                //       setState(() {
                //         post['rating'] = rating;
                //       });
                //     },
                //     filledIcon: Icons.star,
                //   ),
                // ),
              ),
            ),
          );
        },
      ),
    );
  }

  // app bar section
  AppBar appBar() {
    return AppBar(
      elevation: 0.0,
      title: Text('Food analyzer'),
      backgroundColor: Color(0xFFE1F1D8),
    );
  }

  // search
  Container _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xff1D1617).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Search meal',
          hintStyle: const TextStyle(color: Color(0xffDDDADA), fontSize: 14),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(Iconsax.search_normal,size: 25,)
          ),
          suffixIcon: SizedBox(
            width: 100,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const VerticalDivider(
                    color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                    thickness: 0.1,
                  ),

                ],
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
