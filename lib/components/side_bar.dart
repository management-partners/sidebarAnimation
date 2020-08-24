import 'dart:async';

import 'package:FlutterSidebarAnimation/blocs/navigation_bloc.dart';
import 'package:FlutterSidebarAnimation/blocs/navigation_title_bloc.dart';
import 'package:FlutterSidebarAnimation/components/constant.dart';
import 'package:FlutterSidebarAnimation/components/custom_menu_clipper.dart';
import 'package:FlutterSidebarAnimation/components/menu_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  final _animation = const Duration(milliseconds: 500);
  AnimationController _ctlAnimation;
  StreamController<bool> ctlSidebar;
  Stream<bool> isSideBarStream;
  StreamSink<bool> isSideBarStreamSink;
  Color color = Color(0xFF262AAA);

  @override
  void initState() {
    super.initState();
    _ctlAnimation = AnimationController(vsync: this, duration: _animation);
    ctlSidebar = PublishSubject<bool>();
    isSideBarStream = ctlSidebar.stream;
    isSideBarStreamSink = ctlSidebar.sink;
  }

  @override
  void dispose() {
    _ctlAnimation.dispose();
    ctlSidebar.close();
    isSideBarStreamSink.close();
    super.dispose();
  }

  void iconTab() {
    final animationStatus = _ctlAnimation.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;
    if (isAnimationCompleted) {
      isSideBarStreamSink.add(false);
      _ctlAnimation.reverse();
    } else {
      isSideBarStreamSink.add(true);
      _ctlAnimation.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; 

    return StreamBuilder<bool>(
        initialData: false,
        stream: isSideBarStream,
        builder: (context, snapshot) {
          return AnimatedPositioned(
            duration: _animation,
            top: 0,
            bottom: 0,
            right: snapshot.data ? 0 : size.width - 40,
            left: snapshot.data ? 0 : -size.width,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding, vertical: 0),
                    color: color,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Name',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          subtitle: Text(
                            'abc@com.vn',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.perm_identity,
                              color: Colors.white,
                            ),
                            radius: 40,
                          ),
                        ),
                        Divider(
                          height: kDefaultPadding,
                          thickness: 0.5,
                          color: Colors.white.withOpacity(0.5),
                          indent: kDefaultPadding / 2,
                          endIndent: kDefaultPadding / 2,
                        ),
                        MenuItem(
                          icon: Icons.home,
                          title: 'Home',
                          onTab: () {
                            iconTab();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.HomePageClickedEvent);
                                titleBloc.updateTitle('Home Page');
                          },
                        ),
                        MenuItem(
                          icon: Icons.person,
                          title: 'Account',
                          onTab: () {
                            iconTab();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.AccountPageClickedEvent);
                               titleBloc.updateTitle('Account Page');
                          },
                        ),
                        MenuItem(
                          icon: Icons.shopping_bag,
                          title: 'Order',
                          onTab: () {
                            iconTab();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.OrderPageClickedEvent);
                                titleBloc.updateTitle('Order Page');
                          },
                        ),
                        Divider(
                          height: kDefaultPadding,
                          thickness: 0.5,
                          color: Colors.white.withOpacity(0.5),
                          indent: kDefaultPadding / 2,
                          endIndent: kDefaultPadding / 2,
                        ),
                        MenuItem(
                          icon: Icons.exit_to_app,
                          title: 'Logout',
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, -1),
                  child: GestureDetector(
                    onTap: () => iconTab(),
                    child: ClipPath(
                      clipper: CustomeMenuClipper(),
                      child: Container(
                        width: 35,
                        height: 110,
                        color: color,
                        alignment: Alignment.centerLeft,
                        child: AnimatedIcon(
                          progress: _ctlAnimation,
                          icon: AnimatedIcons.menu_close,
                          color: Color(0xFF1BB5FD),
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
