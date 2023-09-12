import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: const Color(0xFF008dff),
          padding: const EdgeInsets.all(0.0),
          alignment: Alignment.center,
          child: const Center(
            child: Text("This is home",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'KanunAR',
                  fontWeight: FontWeight.w300,
                  fontSize: 56.0,
                )),
          ),
        ),
      ),
    );
  }
}
