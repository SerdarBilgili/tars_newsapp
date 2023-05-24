import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FollowingPage extends StatefulWidget {
  const FollowingPage({Key? key}) : super(key: key);

  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3B3B3B),
      body: Center(
          child: Column(
            children: [
              Lottie.network(
                  height: 250,
                  width: 250,
                  'https://assets9.lottiefiles.com/packages/lf20_dpqnwftv.json'),
              const Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Text("Following Page",
                    style: TextStyle(color: Colors.white, fontSize: 36)),
              ),
            ],
        ),
      ),
    );
  }
}
