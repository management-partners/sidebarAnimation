import 'dart:async';

final titleBloc = NavigationTitleBloc();

class NavigationTitleBloc {
  StreamController _titleControl = new StreamController<String>();
  Stream get titleStream => _titleControl.stream;
  StreamSink get titleStreamSink => _titleControl.sink;

  updateTitle(String newTitle) {
    titleStreamSink.add(newTitle);
  }

  void dispose() {
    _titleControl.close();
  }
}
