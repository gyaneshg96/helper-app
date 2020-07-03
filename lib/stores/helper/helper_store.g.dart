// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helper_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HelperStore on _HelperStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading =>
      (_$loadingComputed ??= Computed<bool>(() => super.loading)).value;

  final _$fetchPostsFutureAtom = Atom(name: '_HelperStore.fetchPostsFuture');

  @override
  ObservableFuture<List<Helper>> get fetchPostsFuture {
    _$fetchPostsFutureAtom.context.enforceReadPolicy(_$fetchPostsFutureAtom);
    _$fetchPostsFutureAtom.reportObserved();
    return super.fetchPostsFuture;
  }

  @override
  set fetchPostsFuture(ObservableFuture<List<Helper>> value) {
    _$fetchPostsFutureAtom.context.conditionallyRunInAction(() {
      super.fetchPostsFuture = value;
      _$fetchPostsFutureAtom.reportChanged();
    }, _$fetchPostsFutureAtom, name: '${_$fetchPostsFutureAtom.name}_set');
  }

  final _$helpersAtom = Atom(name: '_HelperStore.helpers');

  @override
  List<Helper> get helpers {
    _$helpersAtom.context.enforceReadPolicy(_$helpersAtom);
    _$helpersAtom.reportObserved();
    return super.helpers;
  }

  @override
  set helpers(List<Helper> value) {
    _$helpersAtom.context.conditionallyRunInAction(() {
      super.helpers = value;
      _$helpersAtom.reportChanged();
    }, _$helpersAtom, name: '${_$helpersAtom.name}_set');
  }

  final _$successAtom = Atom(name: '_HelperStore.success');

  @override
  bool get success {
    _$successAtom.context.enforceReadPolicy(_$successAtom);
    _$successAtom.reportObserved();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.context.conditionallyRunInAction(() {
      super.success = value;
      _$successAtom.reportChanged();
    }, _$successAtom, name: '${_$successAtom.name}_set');
  }

  final _$getHelpersAsyncAction = AsyncAction('getHelpers');

  @override
  Future<dynamic> getHelpers(User user) {
    return _$getHelpersAsyncAction.run(() => super.getHelpers(user));
  }
}
