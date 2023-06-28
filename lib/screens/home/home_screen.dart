import 'package:canteen_test/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _getDate() {
    String date = '';
    var outputFormat = DateFormat('dd E MMM yyyy');
    date = outputFormat.format(DateTime.now());
    return date;
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              _getDate(),
              style: textStyle.labelLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: AppColors.primary,
        height: 70,
        
      ),
    );
  }
}
