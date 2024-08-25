import 'package:flutter/material.dart';
import '../models/company.dart';

class CompanyDetailScreen extends StatelessWidget {
  final Company company;

  CompanyDetailScreen({required this.company});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(company.name),
      ),
      body: Column(
        children: [
          Image.network(company.imageUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              company.description,
              style: TextStyle(fontSize: 18),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Apply job logic
            },
            child: Text('Apply Now'),
          ),
        ],
      ),
    );
  }
}
