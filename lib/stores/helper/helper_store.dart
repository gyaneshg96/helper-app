import 'package:boilerplate/models/helper/helper.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert' show json;
import 'dart:async';

part 'helper_store.g.dart';

class HelperStore = _HelperStore with _$HelperStore;

abstract class _HelperStore with Store {
  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  static const String HELPER_JSON = "assets/dummy/helpers.json";

  _HelperStore();

  // constructor:---------------------------------------------------------------
  //_HelperStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<List<Helper>> emptyPostResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<List<Helper>> fetchPostsFuture =
      ObservableFuture<List<Helper>>(emptyPostResponse);

  @observable
  List<Helper> helpers;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchPostsFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future<List<Helper>> getHelpers(User user) async {
    final future = await getHelpersUtil(user);
    //fetchPostsFuture = ObservableFuture(future);

    return future;
    /*future.then((helpers) {
      return helpers.toList();
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });*/
  }

  Future getHelpersUtil(User user) async {
    //for now we just return all helpers
    List<dynamic> dyn = json
        .decode(await rootBundle.loadString(HELPER_JSON))["helpers"] as List;
    Iterable<Helper> helpers = dyn.map((json) => new Helper(
        id: int.parse(json["id"]),
        fullname: json["fullname"],
        phoneNumber: json["phoneNumber"],
        male: json["male"] == 'male',
        services: List<String>.from(json["services"]),
        areas: List<String>.from(json["services"])));
    return helpers.toList();
  }
}
