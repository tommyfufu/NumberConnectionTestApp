import 'package:flutter/material.dart';
import 'package:number_connection_test/services/crud/services/crud_service_mysql.dart';

class TextEditorWidget extends StatefulWidget {
  String text;
  TextEditorWidget({super.key, required this.text});

  @override
  State<TextEditorWidget> createState() => _TextEditorWidgetState();
}

class _TextEditorWidgetState extends State<TextEditorWidget> {
  bool _isEditingText = false;
  late final TextEditingController _editingController;
  String initialText = "";
  @override
  void initState() {
    _editingController = TextEditingController(text: initialText);
    initialText = widget.text;
    super.initState();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isEditingText
        ? Center(
            child: TextField(
            onSubmitted: (newValue) {
              setState(() {
                initialText = newValue;
                _isEditingText = false;
              });
            },
            autofocus: true,
            controller: _editingController,
          ))
        : InkWell(
            onTap: () {
              setState(() {
                _isEditingText = true;
              });
            },
            child: Text(
              initialText,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ));
  }
}
