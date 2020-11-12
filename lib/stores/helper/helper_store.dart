import 'package:boilerplate/models/helper/helper.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert' show json, jsonDecode;
import 'dart:async';

part 'helper_store.g.dart';

class HelperStore = _HelperStore with _$HelperStore;

abstract class _HelperStore with Store {
  // store for handling errors
  final ErrorStore errorStore = ErrorStore();
  //final Firestore store = Firestore.instance;
  final String serverUrl = "http://10.0.2.2:3000/api/";

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

  @action
  Future<List<Helper>> getHelpers2(String role, String location) async {
    final future = await getHelpersUtil2(role, location);
    //fetchPostsFuture = ObservableFuture(future);

    return future;
    /*future.then((helpers) {i, 
      return helpers.toList();
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });*/
  }

  List<String> numberToRoles(String roles) {
    List<String> listt = List();
    if (roles == "1") {
      listt.add("Housekeep");
    } else if (roles == "0") {
      listt.add("Cook");
    } else if (roles == "2") {
      listt.add("Housekeep");
      listt.add("Cook");
    } else {
      listt.add("NA");
    }
    return listt;
  }

  Future getHelpersUtil2(String role, String location) async {
    String url = serverUrl + role + "/" + location;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> dyn = jsonDecode(response.body)['helpers'];
      Iterable<Helper> helpers = dyn.map((json) => new Helper(
          id: json["id"],
          fullname: json["name"],
          phoneNumber: json["phoneNumber"],
          gender: json["gender"],
          city: json["city"],
          // gender: json["gender"],
          // services: List<String>.from(json["services"]),
          services: numberToRoles(json["roles"]),
          areas: json["locations"]));
      return helpers.toList();
    } else {
      errorStore.errorMessage = response.body;
    }
  }

  Future getHelpersUtil(User user) async {
    //for now we just return all helpers
    //TODO: Delete it later
    List<dynamic> dyn = json.decode(
            await rootBundle.loadString("assets/dummy/helpers.json"))["helpers"]
        as List;
    Iterable<Helper> helpers = dyn.map((json) => new Helper(
        id: int.parse(json["id"]),
        fullname: json["fullname"],
        phoneNumber: json["phoneNumber"],
        gender: int.parse(json["gender"]),
        services: List<String>.from(json["services"]),
        areas: List<String>.from(json["areas"])));
    return helpers.toList();
  }
}
