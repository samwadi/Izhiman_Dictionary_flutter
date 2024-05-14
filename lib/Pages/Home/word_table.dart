import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'add_word.dart';

class MyTablePage extends StatefulWidget {
  const MyTablePage({super.key});

  @override
  _MyTablePageState createState() => _MyTablePageState();
}

class _MyTablePageState extends State<MyTablePage> {
  final TextEditingController _searchController = TextEditingController();
  late Stream<QuerySnapshot> _stream;

  Pattern get searchQuery => _searchController.text;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('words').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Table'),
        backgroundColor: Colors.deepOrange,

        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Add Word',)),
              );
            },
          ),
        ],
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

                return Expanded(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Arabic Word')),
                            DataColumn(label: Text('English Word')),
                            DataColumn(label: Text('Description')),
                            DataColumn(label: Text('Tags')),
                          ],
                          rows: filteredDocuments.map((doc) {
                            final Map<String, dynamic>? data =
                                doc.data() as Map<String, dynamic>?;
                            final String arabicWord = data?['arabicWord'] ?? '';
                            final String englishWord =
                                data?['englishWord'] ?? '';
                            final String description =
                                data?['description'] ?? '';
                            final List<dynamic>? tags = data?['tags'];

                            return DataRow(
                              cells: [
                                DataCell(Text(arabicWord)),
                                DataCell(Text(englishWord)),
                                DataCell(Text(description)),
                                DataCell(Text(tags?.join(', ') ?? '')),
                              ],
                            );
                          }).toList(),
                        )));
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
