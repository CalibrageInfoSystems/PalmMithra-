import 'package:akshaya_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3F Akshaya Sign In',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SignInScreen(),
    );
  }
}

class SignInScreen extends StatelessWidget {
  final TextEditingController _farmerIdController = TextEditingController();

  void _signIn() {
    // Add sign-in logic here
    print('Farmer ID: ${_farmerIdController.text}');
  }

  void _scanQR() {
    // Add QR scan logic here
    print('Scan QR pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.images.appbg.path),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2),
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          // Card with content
          Center(
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFF5F1E9)
                    .withOpacity(0.9), // Light beige with slight transparency
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFFF5722),
                            Color(0xFFFF8A50),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Icon(
                        Icons.circle,
                        size: 60,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '3F Akshaya',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF5722),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Farmer ID Label and Input
                  Text(
                    'Farmer ID',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _farmerIdController,
                    decoration: InputDecoration(
                      hintText: 'Enter Farmer ID',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Sign In Button
                  ElevatedButton(
                    onPressed: _signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF5722),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      minimumSize: Size(double.infinity, 0),
                    ),
                    child: Text(
                      'Sign In →',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  // OR Separator
                  Row(
                    children: [
                      Expanded(
                          child: Divider(color: Colors.grey, thickness: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'OR',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                      Expanded(
                          child: Divider(color: Colors.grey, thickness: 1)),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Scan QR Button
                  ElevatedButton(
                    onPressed: _scanQR,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4CAF50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      minimumSize: Size(double.infinity, 0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.qr_code, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'Scan QR',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
