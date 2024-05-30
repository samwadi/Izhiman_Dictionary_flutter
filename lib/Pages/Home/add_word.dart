import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:izhiman_dictionary/Pages/Home/word_table.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CollectionReference _wordsCollection =
  FirebaseFirestore.instance.collection('words');
  final _arabicController = TextEditingController();
  final _englishController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagsController = TextEditingController();
  final DatabaseReference _database =
  FirebaseDatabase.instance.ref().child('words');

  Future<void> _saveWord() async {
    String arabicWord = _arabicController.text.trim();
    String englishWord = _englishController.text.trim();
    String description = _descriptionController.text.trim();
    String tags = _tagsController.text.trim();

    // Get the current user's email
    User? user = FirebaseAuth.instance.currentUser;
    String? userEmail = user?.email;

    // Check if the word already exists in the database
    QuerySnapshot snapshot = await _wordsCollection
        .where('arabicWord', isEqualTo: arabicWord)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Word already exists in the database')),
      );
      return; // Exit the function if the word already exists
    }

    await _wordsCollection.add({
      'arabicWord': arabicWord,
      'englishWord': englishWord,
      'description': description,
      'tags': [tags],
      'userEmail': userEmail, // Include user's email in the document
    }).then((_) {
      // Data saved successfully
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Word saved to Firestore')),
      );
      _arabicController.clear();
      _englishController.clear();
      _tagsController.clear();
      _descriptionController.clear();
    }).catchError((error) {
      // Error saving data
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save word to Firestore')),
      );
      print('Error saving data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Arabic Word:', style: TextStyle(fontSize: 16)),
            TextFormField(
                controller: _arabicController,
                decoration:
                const InputDecoration(hintText: 'Enter Arabic Word')),
            const SizedBox(height: 20),
            const Text('English Word:', style: TextStyle(fontSize: 16)),
            TextFormField(
                controller: _englishController,
                decoration:
                const InputDecoration(hintText: 'Enter English Word')),
            const SizedBox(height: 20),
            const Text('Description:', style: TextStyle(fontSize: 16)),
            TextFormField(
                controller: _descriptionController,
                decoration:
                const InputDecoration(hintText: 'Enter Description')),
            const SizedBox(height: 20),
            const Text('Tags:', style: TextStyle(fontSize: 16)),
            TextFormField(
                controller: _tagsController,
                decoration: const InputDecoration(hintText: 'Enter Tags')),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _saveWord,
                  child: const Text('Save Word'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyTablePage()),
                  ),
                  child: const Text('My Dictionary'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _arabicController.dispose();
    _englishController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }
}
