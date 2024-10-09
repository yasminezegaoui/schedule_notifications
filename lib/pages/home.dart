// ignore_for_file: prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:scheduled_notifications/notification/notification_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TimeOfDay _timeOfDay = TimeOfDay.now();

  void _selectTimeAndScheduleNotification(){
    showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now(),
    ).then((value){
      setState(() {
        _timeOfDay = value!;
      });
      
      DateTime scheduleTime = DateTime(
        // DateTime.now().year,
        // DateTime.now().month,
        // DateTime.now().day,
        _timeOfDay.hour,
        _timeOfDay.minute,
      );

      NotificationService.scheduleNotification(
        'Scheduled Notification', 
        'GO COMPLETE YOUR DEV DEPARTEMENT MOBILE CHALLENGES', 
        scheduleTime
      );

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.withOpacity(.6),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _timeOfDay.format(context).toString(),
              style: TextStyle(
                color: Colors.black87,
                fontSize: 35
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                NotificationService.showInstanctNotification(
                  'Flutter Notification', 
                  'This shows an instance notificaton'
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.withOpacity(.4)
              ), 
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Show Notification',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w500
                  ),
                ),
              )
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                _selectTimeAndScheduleNotification;
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.withOpacity(.4)
              ), 
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Schedule Notification',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w500
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}