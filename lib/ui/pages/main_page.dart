import 'package:flutter/material.dart';
import 'package:reverse_clocks/ui/widgets/reverse_clocks.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double _angle = 180;
  int _seconds = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ReverseClocks(
                angle: _angle,
                seconds: _seconds,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(
                  () {
                    _angle += 6;
                    _seconds += 1;
                  },
                );
              },
              onLongPress: () async {
                for (int i = 0; i < 60; i++) {
                  await Future.delayed(
                    const Duration(milliseconds: 100),
                    () {
                      setState(
                        () {
                          _angle += 6;
                          _seconds += 1;
                        },
                      );
                    },
                  );
                }
              },
              child: const Text("Increase value"),
            ),
          ],
        ),
      ),
    );
  }
}
