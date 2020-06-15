// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LanguageStore on _LanguageStore, Store {
  Computed<String> _$localeComputed;

  @override
  String get locale =>
      (_$localeComputed ??= Computed<String>(() => super.locale)).value;

  final _$_localeAtom = Atom(name: '_LanguageStore._locale');

  @override
  String get _locale {
    _$_localeAtom.context.enforceReadPolicy(_$_localeAtom);
    _$_localeAtom.reportObserved();
    return super._locale;
  }

  @override
  set _locale(String value) {
    _$_localeAtom.context.conditionallyRunInAction(() {
      super._locale = value;
      _$_localeAtom.reportChanged();
    }, _$_localeAtom, name: '${_$_localeAtom.name}_set');
  }

  final _$_LanguageStoreActionController =
      ActionController(name: '_LanguageStore');

  @override
  void changeLanguage(String value) {
    final _$actionInfo = _$_LanguageStoreActionController.startAction();
    try {
      return super.changeLanguage(value);
    } finally {
      _$_LanguageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getCode() {
    final _$actionInfo = _$_LanguageStoreActionController.startAction();
    try {
      return super.getCode();
    } finally {
      _$_LanguageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getLanguage() {
    final _$actionInfo = _$_LanguageStoreActionController.startAction();
    try {
      return super.getLanguage();
    } finally {
      _$_LanguageStoreActionController.endAction(_$actionInfo);
    }
  }
}
