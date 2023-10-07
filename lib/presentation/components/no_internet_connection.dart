import 'package:flutter/material.dart';

class NoInternetWidget extends StatefulWidget {
  const NoInternetWidget({super.key, required this.onTab});

  final Function() onTab;

  @override
  State<NoInternetWidget> createState() => _NoInternetWidgetState();
}

class _NoInternetWidgetState extends State<NoInternetWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            Container(
              alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: const Text(
                  "Cookies",
                  style: TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w600),
                )),
            Spacer(),
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                height: 150,
                width: 150,
                child: Image.asset("assets/images/ic_nointernet.png"),
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent.shade400, // Change the color to red
                ),
                onPressed: () => widget.onTab.call(),
                child: Text('Try again'),
              ),
            ),
            SizedBox(height: 16,)
          ],
        ),
      ),
    );
  }
}
