import 'package:flutter/widgets.dart';
import 'package:uploaduser/models/data.dart';
import 'package:uploaduser/services/data_api.dart';


enum HomeState {
  Initial,
  Loading,
  Loaded,
  Error,
}

class UserModel extends ChangeNotifier {
  
  HomeState _homeState = HomeState.Initial;
  List<dynamic> data = [];
  String message = '';

  UserModel(var id) {
    _fetchUsers(id);
  }

  HomeState get homeState => _homeState;

  Future<void> _fetchUsers(var id) async {
    _homeState = HomeState.Loading;
    try {
      await Future.delayed(Duration(seconds: 2));
      final apiusers = await DataApi.instance!.getAllUser(id);
      data = apiusers;
      print("daafdgg ${data.length}");
      _homeState = HomeState.Loaded;
    } catch (e) {
      message = 'cccv $e';
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }
}
