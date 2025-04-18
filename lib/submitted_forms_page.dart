import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/submitted_form_details_page.dart';

class SubmittedFormsPage extends StatelessWidget {
  const SubmittedFormsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submitted Forms'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('scanned_data').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No submitted forms found.'));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['patientName'] ?? 'Unnamed Patient'),
                subtitle: Text(data['description'] ?? 'No Description'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubmittedFormDetailsPage(documentId: document.id),
                    ),
                  );
                },
                // You can display other relevant data here.
                // Example:  trailing: Text(data['expiryDate'] ?? 'No Expiry Date'),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}