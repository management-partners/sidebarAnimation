import 'package:FlutterSidebarAnimation/pages/account/account_page.dart';
import 'package:FlutterSidebarAnimation/pages/home/home_page.dart';
import 'package:FlutterSidebarAnimation/pages/order/order_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  AccountPageClickedEvent,
  OrderPageClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc( HomePage initialState) : super(initialState);
  
  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield HomePage();
        break;
      case NavigationEvents.AccountPageClickedEvent:
        yield AccountPage();
        break;
      case NavigationEvents.OrderPageClickedEvent:
        yield OrderPage();
        break;
    }
  }
}
