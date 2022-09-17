import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  const SearchDialog({required this.initialValue});

  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 2,
          left: 4,
          right: 4,
          child: Card(
            child: TextFormField(
              initialValue: initialValue,
              textInputAction: TextInputAction.search,
              autofocus: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                border: InputBorder.none,
                prefixIcon: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              onFieldSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
            ),
          ),
        )
      ],
    );
  }
}
