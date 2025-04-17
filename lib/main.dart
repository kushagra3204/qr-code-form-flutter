import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String? qrCodeResult;
  MobileScannerController cameraController = MobileScannerController();

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  void _scanQRCode() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildBottomSheetContent();
      },
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _scanQRCode,
            tooltip: 'Scan QR Code',
            child: const Icon(Icons.qr_code_scanner),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheetContent() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setModalState) {
        return Container(
          height: 400,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Scan QR Code',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: MobileScanner(
                    controller: cameraController,
                    onDetect: (capture) {
                      final List<Barcode> barcodes = capture.barcodes;
                      if (barcodes.isNotEmpty) {
                        final String? code = barcodes.first.rawValue;
                        setModalState(() {
                          qrCodeResult =
                              code; // Store the raw result temporarily
                        });
                        List<String> data = code?.split(',') ?? [];
                        Map<String, String> extractedData = {};
                        if (data.length == 10) {
                          extractedData = {
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
                          extractedData = {
                            'patientName': 'N/A',
                            'hospitalName': 'N/A',
                            'gtin': 'N/A',
                            'serialNumber': 'N/A',
                            'batchNumber': 'N/A',
                            'productCode': 'N/A',
                            'description': 'N/A',
                            'expiryDate': 'N/A',
                            'mfgDate': 'N/A',
                            'secondaryPackagingDate': 'N/A',
                          };
                        }
                        setModalState(() {
                          qrCodeResult = extractedData.toString();
                        });
                        Navigator.pop(context); // Close bottom sheet after scan
                        _showResultDialog(code);
                      }
                    },
                  ),
                ),
              ),
              // Removed the Text widget displaying the raw result
              const SizedBox(height: 20),
              const Text('Scanning...', style: TextStyle(fontSize: 16)),
            ],
          ),
        );
      },
    );
  }

  void _showResultDialog(String? result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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

        return SingleChildScrollView(
          child: AlertDialog(
            title: const Text('Scanned Data'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: formData['patientName'],
                  decoration: const InputDecoration(labelText: 'Patient Name'),
                ),
                TextFormField(
                  initialValue: formData['hospitalName'],
                  decoration: const InputDecoration(labelText: 'Hospital Name'),
                ),
                TextFormField(
                  initialValue: formData['gtin'],
                  decoration: const InputDecoration(labelText: 'GTIN'),
                ),
                TextFormField(
                  initialValue: formData['serialNumber'],
                  decoration: const InputDecoration(labelText: 'Serial Number'),
                ),
                TextFormField(
                  initialValue: formData['batchNumber'],
                  decoration: const InputDecoration(labelText: 'Batch Number'),
                ),
                TextFormField(
                  initialValue: formData['productCode'],
                  decoration: const InputDecoration(labelText: 'Product Code'),
                ),
                TextFormField(
                  initialValue: formData['description'],
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextFormField(
                  initialValue: formData['expiryDate'],
                  decoration: const InputDecoration(labelText: 'Expiry Date'),
                ),
                TextFormField(
                  initialValue: formData['mfgDate'],
                  decoration: const InputDecoration(
                    labelText: 'Manufacturing Date',
                  ),
                ),
                TextFormField(
                  initialValue: formData['secondaryPackagingDate'],
                  decoration: const InputDecoration(
                    labelText: 'Secondary Packaging Date',
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // You can add logic here to handle form submission
                  // and store the data in Firebase.
                  // For example:
                  // _submitFormData(formData);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }
}
