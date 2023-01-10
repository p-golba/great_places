import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../widgets/location_input.dart';
import '../providers/places.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File? pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<Places>(
      context,
      listen: false,
    ).addPlace(
      _titleController.text,
      _pickedImage as File,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(label: Text('Title')),
                      controller: _titleController,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ImageInput(_selectImage),
                    const SizedBox(height: 25,),
                    const LocationInput(),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            style: const ButtonStyle(
                elevation: MaterialStatePropertyAll<double>(0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
            onPressed: _savePlace,
          )
        ],
      ),
    );
  }
}
