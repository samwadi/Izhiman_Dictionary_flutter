import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'add_word.dart';

class MyTablePage extends StatefulWidget {
  const MyTablePage({Key? key}) : super(key: key);

  @override
  _MyTablePageState createState() => _MyTablePageState();
}

class _MyTablePageState extends State<MyTablePage> {
  final TextEditingController _searchController = TextEditingController();
  late Stream<QuerySnapshot> _stream;
  late String _userEmail;

  @override
  void initState() {
    super.initState();
    _getUserEmail();
  }

  Future<void> _getUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _userEmail = user!.email!;
      _stream = FirebaseFirestore.instance
          .collection('words')
          .where('userEmail', isEqualTo: _userEmail) // Filter by userEmail
          .snapshots();
    });
  }

  Pattern get searchQuery => _searchController.text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Table'),
        backgroundColor: Colors.deepOrange,

      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final List<DocumentSnapshot> documents = snapshot.data!.docs;
                List<DocumentSnapshot> filteredDocuments =
                documents.where((doc) {
                  final Map<String, dynamic>? data =
                  doc.data() as Map<String, dynamic>?;
                  final String arabicWord = data?['arabicWord'] ?? '';
                  final String englishWord = data?['englishWord'] ?? '';
                  final String description = data?['description'] ?? '';
                  final List<dynamic>? tags = data?['tags'];

                  return arabicWord.contains(_searchController.text) ||
                      englishWord.contains(searchQuery) ||
                      description.contains(searchQuery) ||
                      (tags != null &&
                          tags.any((tag) => tag
                              .toString()
                              .toLowerCase()
                              .contains(searchQuery)));
                }).toList();

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Arabic Word')),
                      DataColumn(label: Text('English Word')),
                      DataColumn(label: Text('Description')),
                      DataColumn(label: Text('Tags')),
                      DataColumn(
                          label:
                          Text('Delete')), // New column for delete button
                    ],
                    rows: filteredDocuments.map((doc) {
                      final Map<String, dynamic>? data =
                      doc.data() as Map<String, dynamic>?;
                      final String arabicWord = data?['arabicWord'] ?? '';
                      final String englishWord = data?['englishWord'] ?? '';
                      final String description = data?['description'] ?? '';
                      final List<dynamic>? tags = data?['tags'];

                      return DataRow(
                        cells: [
                          DataCell(Text(arabicWord)),
                          DataCell(Text(englishWord)),
                          DataCell(Text(description)),
                          DataCell(Text(tags?.join(', ') ?? '')),
                          DataCell(
                            IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Delete Word'),
                                        content: const Text(
                                            'Are you sure you want to delete this word?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              doc.reference.delete();
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'Delete',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AddWordPage extends StatelessWidget {
  const AddWordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Word'),
        backgroundColor: Colors.deepOrange,
      ),
      body: const Center(
        child: Text('Add Word Page'),
      ),
    );
  }
}
