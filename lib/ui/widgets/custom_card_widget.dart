import 'package:flutter/material.dart';
import 'package:test_space_deer/utils/date_time_formatter.dart';

class CustomCardWidget extends StatelessWidget {
  final String uuid;
  final DateTime creationTime;
  final DateTime lastSignInTime;
  final String notificationToken;
  const CustomCardWidget(
      {required this.uuid,
      required this.creationTime,
      required this.lastSignInTime,
      required this.notificationToken,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Text(text: 'ID: $uuid'),
            _Text(
                text:
                    'Creation Time: ${DateTimeFormatter.getDate(creationTime)}'),
            _Text(
                text:
                    'Last Sign In Time: ${DateTimeFormatter.getDate(lastSignInTime)}'),
            _Text(text: 'Notification Token: $notificationToken'),
          ],
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  final String text;
  const _Text({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Text(text),
    );
  }
}
