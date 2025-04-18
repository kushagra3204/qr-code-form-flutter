import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QrCodeResultDialog extends StatelessWidget {
  final String? result;

  const QrCodeResultDialog({super.key, this.result});

  @override
  Widget build(BuildContext context) {
    List<String> data = result?.split(',') ?? [];
    Map<String, String> formData = {};

    if (data.length == 10) {
      formData = {
        'patientName': data[0],
        'hospitalName': data[1],
        'gtin': data[2],
        'serialNumber': data[3],
        'batchNumber': data[4],
        'productCode': data[5],
        'description': data[6],
        'expiryDate': data[7],
        'mfgDate': data[8],
        'secondaryPackagingDate': data[9],
      };
    } else {
      formData = {
        'patientName': '',
        'hospitalName': '',
        'gtin': '',
        'serialNumber': '',
        'batchNumber': '',
        'productCode': '',
        'description': '',
        'expiryDate': '',
        'mfgDate': '',
        'secondaryPackagingDate': '',
      };
    }

    final _formKey = GlobalKey<FormState>();

    return StatefulBuilder(
      builder: (context, setState) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: const Text('Scanned Data'),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: formData['patientName'],
                    decoration: const InputDecoration(labelText: 'Patient Name'),
                    onChanged: (value) => formData['patientName'] = value,
                  ),
                  TextFormField(
                    initialValue: formData['hospitalName'],
                    decoration: const InputDecoration(labelText: 'Hospital Name'),
                    onChanged: (value) => formData['hospitalName'] = value,
                  ),
                  TextFormField(
                    initialValue: formData['gtin'],
                    decoration: const InputDecoration(labelText: 'GTIN'),
                    onChanged: (value) => formData['gtin'] = value,
                  ),
                  TextFormField(
                    initialValue: formData['serialNumber'],
                    decoration: const InputDecoration(labelText: 'Serial Number'),
                    onChanged: (value) => formData['serialNumber'] = value,
                  ),
                  TextFormField(
                    initialValue: formData['batchNumber'],
                    decoration: const InputDecoration(labelText: 'Batch Number'),
                    onChanged: (value) => formData['batchNumber'] = value,
                  ),
                  TextFormField(
                    initialValue: formData['productCode'],
                    decoration: const InputDecoration(labelText: 'Product Code'),
                    onChanged: (value) => formData['productCode'] = value,
                  ),
                  TextFormField(
                    initialValue: formData['description'],
                    decoration: const InputDecoration(labelText: 'Description'),
                    onChanged: (value) => formData['description'] = value,
                  ),
                  TextFormField(
                    initialValue: formData['expiryDate'],
                    decoration: const InputDecoration(labelText: 'Expiry Date'),
                    onChanged: (value) => formData['expiryDate'] = value,
                  ),
                  TextFormField(
                    initialValue: formData['mfgDate'],
                    decoration: const InputDecoration(
                      labelText: 'Manufacturing Date',
                    ),
                    onChanged: (value) => formData['mfgDate'] = value,
                  ),
                  TextFormField(
                    initialValue: formData['secondaryPackagingDate'],
                    decoration: const InputDecoration(
                      labelText: 'Secondary Packaging Date',
                    ),
                    onChanged: (value) => formData['secondaryPackagingDate'] = value,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await FirebaseFirestore.instance
                          .collection('scanned_data')
                          .add(formData);
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Data submitted successfully!')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error submitting data: $e')),
                      );
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }
}