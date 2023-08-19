import 'package:file_sync/providers/more_provider.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'cards.dart';

class MoreScreen extends StatelessWidget {
  MoreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final moreProvider = Provider.of<MoreProvider>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            firstCard(),
            SizedBox(
              height: 10,
            ),
            secondCard(context),
            SizedBox(
              height: 10,
            ),
            thirdCard(context),
          ],
        ),
      ),
    );
  }
}
