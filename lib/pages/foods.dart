import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hista_mate/models/category_model.dart';

class Foods extends StatefulWidget {
  const Foods({Key? key}) : super(key: key);

  @override
  State<Foods> createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {
  final _firestore = FirebaseFirestore.instance.collection('foods');
  final _searchController = TextEditingController();
  final List<String> ingredients = ['bacon', 'cheese', 'sausages', 'chicken']; // update ingredients

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
        selectedIngredients.remove(ingredient); // Remove if already selected
      } else {
        selectedIngredients.add(ingredient); // Add if not already selected
      }
      _fetchFilteredPosts(); // Fetch posts based on the updated selection
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ingredients.map((e) {
                    final isSelected = selectedIngredients.contains(e);
                    return Flexible(
                      child: FilterChip(
                        label: Text(e.toString()),
                        selected: isSelected,
                        onSelected: (_) => _toggleIngredientSelection(e),
                        selectedColor: Colors.blueAccent,
                        checkmarkColor: Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          midContainer(),
          _similarFoods(),
        ],
      ),
    );
  }

  Column _similarFoods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Similar Products',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 2.0),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
            height: 120.0,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (context, index) => SizedBox(
                  width: 25.0,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: categories[index].boxColor.withOpacity(0.3)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(categories[index].iconPath),
                          ),
                        ),
                        Text(
                          categories[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }

  // mid container filtered items
  Widget midContainer() {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(8.0),
      height: 300.0,
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
                subtitle: Text(post['description'] ?? 'No Description'),
                leading: (post['imageUrl'] != null &&
                    post['imageUrl']!.isNotEmpty)
                    ? Image.network(post['imageUrl']!,
                    width: 80, height: 120, fit: BoxFit.contain)
                    : const Icon(Icons.image_not_supported),
                trailing: SizedBox(
                  width: 100,
                  height: 20,
                  child: RatingBar(
                    size: 15,
                    initialRating: post['rating'] ?? 0,
                    maxRating: 5,
                    emptyIcon: Icons.star_border,
                    filledColor: Colors.orange,
                    emptyColor: Colors.grey,
                    halfFilledColor: Colors.orangeAccent,
                    onRatingChanged: (rating) async {
                      await _firestore
                          .doc(post['id'])
                          .update({'rating': rating});
                      setState(() {
                        post['rating'] = rating;
                      });
                    },
                    filledIcon: Icons.star,
                  ),
                ),
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
      title: const Text(
        'MEALS FOR YOU',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () async {
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            'assets/icons/back.png',
            height: 25,
            width: 25,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () async {
            await FirebaseAuth.instance.signOut();
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              'assets/icons/application.png',
              height: 25,
              width: 25,
            ),
          ),
        ),
      ],
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
            child: Image.asset(
              'assets/icons/search.png',
              width: 30,
            ),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icons/filter.png',
                      width: 30,
                    ),
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
