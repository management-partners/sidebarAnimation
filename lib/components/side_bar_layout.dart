import 'package:FlutterSidebarAnimation/blocs/navigation_bloc.dart';
import 'package:FlutterSidebarAnimation/blocs/navigation_title_bloc.dart';
import 'package:FlutterSidebarAnimation/components/side_bar.dart';
import 'package:FlutterSidebarAnimation/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SidebarLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SidebarLayout();
}

class _SidebarLayout extends State<SidebarLayout> { 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: StreamBuilder<String>(
          stream: titleBloc.titleStream,
          initialData: 'Home Page',
          builder: (context, snapshot) {
            return Text(snapshot.data.toString());
          },
        ),
      )),
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(HomePage()),
        child: Stack(
          children: [
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, navigationState) {
                return navigationState as Widget;
              },
            ),
            SideBar(),
          ],
        ),
      ),
    );
  }
}
