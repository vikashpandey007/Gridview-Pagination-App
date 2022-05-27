import 'package:flutter/material.dart';
import 'package:uploaduser/models/data.dart';
import 'package:uploaduser/services/data_api.dart';

class PhotoProvider extends ChangeNotifier {
  int _page = 1;

  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  List<Photos>? _photos = <Photos>[];

  List<Photos>? get photos => _photos;

  set photos(List<Photos>? value) {
    _photos = value;
  }

  Future<void> callPhotoApi() async {
    await PhotosApi().getPhotos(_page).then((response) {
      _page = _page + 1;
      print(PhotoModel.fromJson(response).data);

      addPhotosToList(PhotoModel.fromJson(response).data);
    });
    notifyListeners();
  }

  void addPhotosToList(List<Photos>? photoData) {
    _photos!.addAll(photoData!.toList());
    notifyListeners();
  }
}
