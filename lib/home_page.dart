import 'package:flutter/material.dart';

enum SizeChoices { small, medium, large }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SizeChoices? _size = SizeChoices.small;

  _onItemTapped(int index) {
    setState(() {
      _size = index == 0
          ? SizeChoices.small
          : index == 1
              ? SizeChoices.medium
              : SizeChoices.large;
    });
  }

  String getFriendlyName(SizeChoices? character) {
    switch (character) {
      case SizeChoices.small:
        return 'Small Coffee';
      case SizeChoices.medium:
        return 'Medium Coffee';
      case SizeChoices.large:
        return 'Large Coffee';
      default:
        return 'None';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile<SizeChoices>(
          title: const Text('Small Coffee'),
          value: SizeChoices.small,
          groupValue: _size,
          onChanged: (SizeChoices? value) {
            setState(() {
              _size = value;
            });
          },
        ),
        RadioListTile<SizeChoices>(
          title: const Text('Medium Coffee'),
          value: SizeChoices.medium,
          groupValue: _size,
          onChanged: (SizeChoices? value) {
            setState(() {
              _size = value;
            });
          },
        ),
        RadioListTile<SizeChoices>(
          title: const Text('Large Coffee'),
          value: SizeChoices.large,
          groupValue: _size,
          onChanged: (SizeChoices? value) {
            setState(() {
              _size = value;
            });
          },
        ),
        Text('Selected: ${getFriendlyName(_size)}'),
      ],
    );
  }
}
