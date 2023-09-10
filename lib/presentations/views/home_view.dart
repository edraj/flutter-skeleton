import 'package:flutter/widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF008dff),
      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
      child: const Center(
        child: Text("this is home"),
      ),
    );
  }
}
