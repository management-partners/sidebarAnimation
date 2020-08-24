import 'package:FlutterSidebarAnimation/blocs/navigation_bloc.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget with NavigationStates{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home page'),
    );
  }
  
}