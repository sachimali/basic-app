import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintDetailScreen extends StatelessWidget {
  final String complaintId;

  // Constructor to receive the complaint ID as a parameter
  // ignore: use_key_in_widget_constructors
  const ComplaintDetailScreen({required this.complaintId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint Details'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        // Use the complaint ID to retrieve the specific complaint document
        stream: FirebaseFirestore.instance
            .collection('complaints')
            .doc(complaintId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          // Get the complaint data from the snapshot
          var complaintData = snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title: ${complaintData['title']}',
                  style: const TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Description: ${complaintData['description']}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Department: ${complaintData['department']}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Status: ${complaintData['status']}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Complaint Status'),
                          content: Text(
                            'The status of this complaint is ${complaintData['status']}',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('View Status'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
