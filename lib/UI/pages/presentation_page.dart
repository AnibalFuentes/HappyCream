import 'package:flutter/material.dart';
import 'package:happycream/UI/widgets/header.dart';

class PresentationPage extends StatefulWidget {
  const PresentationPage({super.key});

  @override
  State<PresentationPage> createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      
      body: HeaderDesing()
         /* Center(
            child: CircleAvatar(
              
              radius: 100,
              child: ClipOval(
                child: Image.asset('assets/icon.png'),
              )
              
              
            ),
          
        
      ),*/

    );
  }
}