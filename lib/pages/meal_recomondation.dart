import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'food_detail.dart';

class MealRecommendation extends StatefulWidget {
  const MealRecommendation({super.key});

  @override
  State<MealRecommendation> createState() => _MealRecommendationState();
}

class _MealRecommendationState extends State<MealRecommendation> {
  final _formKey = GlobalKey<FormState>();
  String _goal = 'Weight Loss';
  String _preference = 'Vegetarian';
  List<Map<String, String>> _recommendations = [];

  @override
  void initState() {
    super.initState();
    fetchMeals(_goal, _preference);
  }

  Future<void> fetchMeals(String goal, String preference) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('meals')
        .where('goal', isEqualTo: goal)
        .where('preference', isEqualTo: preference)
        .get();

    List<Map<String, String>> meals = querySnapshot.docs.map((doc) {
      return {
        'mealName': doc['mealName'] as String,
        'imageUrl': doc['imageUrl'] as String,
      };
    }).toList();

    setState(() {
      _recommendations = meals;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Recommendation'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Find the best meals for your goal and preference',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _goal,
                decoration: InputDecoration(
                  labelText: 'Goal',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.green[50],
                ),
                items: ['Weight Loss', 'Muscle Gain', 'Maintenance']
                    .map((goal) => DropdownMenuItem(
                  value: goal,
                  child: Text(goal),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _goal = value!;
                    fetchMeals(_goal, _preference);
                  });
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _preference,
                decoration: InputDecoration(
                  labelText: 'Preference',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.green[50],
                ),
                items: ['Vegetarian', 'Vegan', 'Keto', 'None']
                    .map((preference) => DropdownMenuItem(
                  value: preference,
                  child: Text(preference),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _preference = value!;
                    fetchMeals(_goal, _preference);
                  });
                },
              ),
              SizedBox(height: 20),
              Expanded(
                child: _recommendations.isNotEmpty
                    ? ListView.builder(
                  itemCount: _recommendations.length,
                  itemBuilder: (context, index) {
                    final rec = _recommendations[index];
                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FoodDetail(
                                title: rec['mealName']!,
                                imagePath: rec['imageUrl']!,
                                description: 'Description of the meal',
                              ),
                            ),
                          );
                        },
                        leading: Image.network(
                          rec['imageUrl']!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          rec['mealName']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                        ),
                      ),
                    );
                  },
                )
                    : Center(
                  child: Text(
                    'No recommendations available',
                    style: TextStyle(
                      color: Colors.red,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
