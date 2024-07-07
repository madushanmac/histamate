import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hista_mate/pages/food_detail.dart';

import '../models/info_model.dart';

class Foods extends StatefulWidget {
  const Foods({super.key});

  @override
  State<Foods> createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {
  final _firestore = FirebaseFirestore.instance.collection('foods');
  final _searchController = TextEditingController();
  late Future<List<InfoModel>> _infoFuture;

  List<Map<String, dynamic>> _posts = [];
  List<Map<String, dynamic>> _filteredPosts = [];

  @override
  void initState() {
    super.initState();
    _listenForPosts();
    _searchController.addListener(_filterPosts);
    _infoFuture = InfoModel.getInfo();
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterPosts);
    _searchController.dispose();
    super.dispose();
  }

  void _listenForPosts() {
    final query = _firestore.snapshots();
    query.listen((snapshot) {
      _posts = snapshot.docs.map((doc) => doc.data()).toList();
      _filteredPosts = _posts;
      setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        appBar(),
        _searchField(),
        midContainer(),
        bottom_Container(),
      ]),
    );
  }

  Column bottom_Container() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Recommendation for you\n ',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600,letterSpacing: 1.5),
          ),
        ),
        SizedBox(
          height: 250.0,
          child: FutureBuilder<List<InfoModel>>(
            future: _infoFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data found'));
              } else {
                List<InfoModel> infoList = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: infoList.length,
                  itemBuilder: (context, index) {
                    InfoModel info = infoList[index];

                    return Container(
                      width: 200,
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.green, Colors.white],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          color: info.boxColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.network(
                            fit: BoxFit.fill,
                            info.iconPath,
                            width: 120,
                          ),
                          Column(
                            children: [
                              Text(
                                info.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
                              Text(
                                info.description,
                                style: const TextStyle(
                                    color: Color(0xff7B6F72),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Container(
                            height: 50,
                            width: 130,
                            decoration: BoxDecoration(
                                color: Colors.red[900],
                                borderRadius: BorderRadius.circular(50)),
                            child: const Center(
                              child: Text(
                                'View',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  // mid container filterd items
  Container midContainer() {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(8.0),
      height: 250.0,
      child: _posts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _filteredPosts.length,
              itemBuilder: (context, index) {
                final post = _filteredPosts[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Card(
                   // elevation: 8,
                    child: SizedBox(
                      height: 90,
                      child: Center(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodDetail(title: post['title'], imagePath: post['imageUrl'], description: post['description'],)));
                          },
                          title: Text(
                            post['title'] ?? 'No Title',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                letterSpacing: 0.5),
                          ),
                          subtitle:
                              Text(post['description'] ?? 'No Description'),
                          leading: (post['imageUrl'] != null &&
                                  post['imageUrl']!.isNotEmpty)
                              ? Image.network(post['imageUrl'],
                                  width: 80, height: 120, fit: BoxFit.contain)
                              : const Icon(Icons.image_not_supported),
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
        'HISTAMATE ',
        style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 1),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () async {
          //exitApp(context);
          //await FirebaseAuth.instance.signOut();
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10)),
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
                borderRadius: BorderRadius.circular(10)),
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

  //search
  Container _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: const Color(0xff1D1617).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0)
      ]),
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
                borderSide: BorderSide.none)),
      ),
    );
  }
  // info section
}
