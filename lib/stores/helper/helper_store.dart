import 'package:boilerplate/models/helper/helper.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import 'dart:io' show File;
import 'dart:convert' show json;


//class PostStore = _PostStore with _$PostStore;
class HelperStore with Store {
  
  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  static const String HELPER_JSON='boilerplate/dummy/helpers.json';

  // constructor:---------------------------------------------------------------
  //_HelperStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<List<Helper> > emptyPostResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<List<Helper> > fetchPostsFuture =
      ObservableFuture<List<Helper> >(emptyPostResponse);

  @observable
  List<Helper> helpers;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchPostsFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getHelpers(User user) async {
    final future = getHelpersUtil(user);
    fetchPostsFuture = ObservableFuture(future);

    future.then((helpers) {
      this.helpers = helpers;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  Future getHelpersUtil(User user) async {
      //for now we just return all helpers
      List<Helper> helpers = json.decode(await new File(HELPER_JSON).readAsString());
      return helpers;
  }
}