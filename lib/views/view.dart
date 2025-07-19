import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // You'll need to add this to your pubspec.yaml

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Data COY!!!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PdfPickerScreen(),
    );
  }
}

class PdfPickerScreen extends StatefulWidget {
  @override
  _PdfPickerScreenState createState() => _PdfPickerScreenState();
}

class _PdfPickerScreenState extends State<PdfPickerScreen> {
  String? _fileName;
  String? _filePath; // To store the path of the selected file

  Future<void> _pickPdfFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        setState(() {
          _fileName = result.files.first.name;
          _filePath = result.files.first.path;
        });
        // In a real application, you would now pass _filePath to a function
        // that handles reading/parsing the PDF data.
        _showSnackBar('PDF Selected: $_fileName');
      } else {
        // User canceled the picker
        _showSnackBar('File selection canceled.');
      }
    } catch (e) {
      _showSnackBar('Error picking file: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Data Fetcher'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: _pickPdfFile,
                icon: Icon(Icons.picture_as_pdf),
                label: Text('Select PDF File'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              if (_fileName != null)
                Column(
                  children: [
                    Text(
                      'Selected PDF:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      _fileName!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                    ),
                    SizedBox(height: 20),
                    // You would add a button here to "Process PDF" or similar
                    // Once you have the file path, you can use a PDF parsing library.
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement PDF data fetching logic using _filePath
                        _showSnackBar('Processing PDF: $_fileName (Not implemented yet!)');
                        print('File Path for processing: $_filePath');
                      },
                      child: Text('Fetch Data from PDF'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                        textStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                )
              else
                Text(
                  'No PDF selected.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
            ],
          ),
        ),
      ),
    );
  }
}