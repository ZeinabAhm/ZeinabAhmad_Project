import 'package:flutter/material.dart';
import 'package:zeinab_ahmad_project/pages/home.page.dart';
import 'dart:ui' as ui;


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Expense App',
              style: TextStyle(
                  fontSize: 30,
                  foreground: Paint()
                    ..shader = ui.Gradient.linear(
                      const Offset(0, 20),
                      const Offset(150, 20),
                      <Color>[

                        Colors.black,
                        Colors.grey,

                      ],
                    )
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the home screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.grey, // Set the background color to grey
              ),
              child: Text(
                'Expense Your Day',
                style: TextStyle(
                  color: Colors.white, // Set the text color to white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
