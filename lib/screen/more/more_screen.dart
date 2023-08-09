import "package:flutter/material.dart";
import '../../data/color_scheme.dart' as color_scheme;
import 'cards.dart';
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children:[
            SizedBox(height:10 ,),
            firstCard(),
            SizedBox(height: 10,),
            secondCard(context),
            SizedBox(height: 10,),
            thirdCard(context),
          ],
        ),
      ),
    );
  }
}