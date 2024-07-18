import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  TextEditingController _noteController = TextEditingController();
  Map<DateTime, List<Map<String, dynamic>>> _events = {};
  String _selectedStatus = 'medium';

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  void _fetchEvents() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('notes').get();
    Map<DateTime, List<Map<String, dynamic>>> events = {};
    for (var doc in snapshot.docs) {
      DateTime date = DateTime.parse(doc['date']);
      // Ensure the date has no time component
      DateTime eventDate = DateTime(date.year, date.month, date.day);
      if (events[eventDate] == null) {
        events[eventDate] = [];
      }
      events[eventDate]!.add({
        'note': doc['note'],
        'status': doc['status'],
      });
    }
    setState(() {
      _events = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SYMPTOMS TRACKER',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            eventLoader: (day) {
              DateTime eventDay = DateTime(day.year, day.month, day.day);
              return _events[eventDay] ?? [];
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isEmpty) return SizedBox();
                return _buildMarkers(date, events);
              },
            ),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          _searchField(),
          _statusDropdown(),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue[300],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            onPressed: _saveNote,
            child: const Text('Save Note'),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('notes')
                  .where('date', isEqualTo: _selectedDay.toIso8601String().split('T')[0])
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final notes = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index]['note'];
                    return Card(
                      color: Colors.grey[200],
                      child: ListTile(
                        contentPadding: EdgeInsets.all(5.0),
                        leading: Image.network(width: 30,height: 30,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcdQ09IwvGZDsOdOOTtuds8SqOH-ATH_ZnTw&s'),
                        title: Text(note,style: TextStyle(fontWeight: FontWeight.bold),),
                        trailing: Icon(Icons.more_vert),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkers(DateTime date, List<dynamic> events) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: events.map((event) {
        return Container(
          margin: const EdgeInsets.all(1.5),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _getStatusColor(event['status']),
          ),
        );
      }).toList(),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  Container _searchField() {
    return Container(
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: const Color(0xff1D1617).withOpacity(0.11),
          blurRadius: 40,
          spreadRadius: 0.0,
        ),
      ]),
      child: TextFormField(
        validator: (e) {
          if (e == null || e.isEmpty) {
            return 'Please enter what you have to save';
          }
          return null;
        },
        controller: _noteController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Enter your note here!',
          hintStyle: const TextStyle(color: Color(0xffDDDADA), fontSize: 14),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              'assets/icons/back.png',
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

  Widget _statusDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: DropdownButtonFormField<String>(
        value: _selectedStatus,
        items: [
          DropdownMenuItem(value: 'high', child: Text('High')),
          DropdownMenuItem(value: 'medium', child: Text('Medium')),
          DropdownMenuItem(value: 'low', child: Text('Low')),
        ],
        onChanged: (value) {
          setState(() {
            _selectedStatus = value!;
          });
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          filled: true,
          fillColor: Colors.grey[300],
          hintText: 'Select Status',
          hintStyle: const TextStyle(color: Color(0xffDDDADA), fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  void _saveNote() async {
    String searchText = _noteController.text;
    if (searchText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter what you have to save.', style: TextStyle(color: Colors.red)),
        ),
      );
    } else {
      await FirebaseFirestore.instance.collection('notes').add({
        'date': _selectedDay.toIso8601String().split('T')[0],
        'note': _noteController.text,
        'status': _selectedStatus,
      });
      _noteController.clear();
      _fetchEvents(); // Refresh events after saving a new note
    }
  }
}