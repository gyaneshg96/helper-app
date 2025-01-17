// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FormStore on _FormStore, Store {
  Computed<bool> _$canLoginEmailComputed;

  @override
  bool get canLoginEmail =>
      (_$canLoginEmailComputed ??= Computed<bool>(() => super.canLoginEmail))
          .value;
  Computed<bool> _$canLoginPhoneComputed;

  @override
  bool get canLoginPhone =>
      (_$canLoginPhoneComputed ??= Computed<bool>(() => super.canLoginPhone))
          .value;
  Computed<bool> _$canRegisterEmailComputed;

  @override
  bool get canRegisterEmail => (_$canRegisterEmailComputed ??=
          Computed<bool>(() => super.canRegisterEmail))
      .value;
  Computed<bool> _$canRegisterPhoneNumberComputed;

  @override
  bool get canRegisterPhoneNumber => (_$canRegisterPhoneNumberComputed ??=
          Computed<bool>(() => super.canRegisterPhoneNumber))
      .value;
  Computed<bool> _$canForgetPasswordComputed;

  @override
  bool get canForgetPassword => (_$canForgetPasswordComputed ??=
          Computed<bool>(() => super.canForgetPassword))
      .value;

  final _$userEmailAtom = Atom(name: '_FormStore.userEmail');

  @override
  String get userEmail {
    _$userEmailAtom.context.enforceReadPolicy(_$userEmailAtom);
    _$userEmailAtom.reportObserved();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.context.conditionallyRunInAction(() {
      super.userEmail = value;
      _$userEmailAtom.reportChanged();
    }, _$userEmailAtom, name: '${_$userEmailAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: '_FormStore.password');

  @override
  String get password {
    _$passwordAtom.context.enforceReadPolicy(_$passwordAtom);
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.conditionallyRunInAction(() {
      super.password = value;
      _$passwordAtom.reportChanged();
    }, _$passwordAtom, name: '${_$passwordAtom.name}_set');
  }

  final _$successAtom = Atom(name: '_FormStore.success');

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

  final _$loadingAtom = Atom(name: '_FormStore.loading');

  @override
  bool get loading {
    _$loadingAtom.context.enforceReadPolicy(_$loadingAtom);
    _$loadingAtom.reportObserved();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.context.conditionallyRunInAction(() {
      super.loading = value;
      _$loadingAtom.reportChanged();
    }, _$loadingAtom, name: '${_$loadingAtom.name}_set');
  }

  final _$fullNameAtom = Atom(name: '_FormStore.fullName');

  @override
  String get fullName {
    _$fullNameAtom.context.enforceReadPolicy(_$fullNameAtom);
    _$fullNameAtom.reportObserved();
    return super.fullName;
  }

  @override
  set fullName(String value) {
    _$fullNameAtom.context.conditionallyRunInAction(() {
      super.fullName = value;
      _$fullNameAtom.reportChanged();
    }, _$fullNameAtom, name: '${_$fullNameAtom.name}_set');
  }

  final _$phoneNumberAtom = Atom(name: '_FormStore.phoneNumber');

  @override
  String get phoneNumber {
    _$phoneNumberAtom.context.enforceReadPolicy(_$phoneNumberAtom);
    _$phoneNumberAtom.reportObserved();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String value) {
    _$phoneNumberAtom.context.conditionallyRunInAction(() {
      super.phoneNumber = value;
      _$phoneNumberAtom.reportChanged();
    }, _$phoneNumberAtom, name: '${_$phoneNumberAtom.name}_set');
  }

  final _$registerAsyncAction = AsyncAction('register');

  @override
  Future<dynamic> register() {
    return _$registerAsyncAction.run(() => super.register());
  }

  final _$loginAsyncAction = AsyncAction('login');

  @override
  Future<dynamic> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  final _$forgotPasswordAsyncAction = AsyncAction('forgotPassword');

  @override
  Future<dynamic> forgotPassword() {
    return _$forgotPasswordAsyncAction.run(() => super.forgotPassword());
  }

  final _$logoutAsyncAction = AsyncAction('logout');

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$_FormStoreActionController = ActionController(name: '_FormStore');

  @override
  void setUserId(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction();
    try {
      return super.setUserId(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction();
    try {
      return super.setPassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFullName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction();
    try {
      return super.setFullName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhoneNumber(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction();
    try {
      return super.setPhoneNumber(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUserEmail(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction();
    try {
      return super.validateUserEmail(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateFullName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction();
    try {
      return super.validateFullName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction();
    try {
      return super.validatePassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePhoneNumber(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction();
    try {
      return super.validatePhoneNumber(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }
}

mixin _$FormErrorStore on _FormErrorStore, Store {
  Computed<bool> _$hasErrorsInEmailLoginComputed;

  @override
  bool get hasErrorsInEmailLogin => (_$hasErrorsInEmailLoginComputed ??=
          Computed<bool>(() => super.hasErrorsInEmailLogin))
      .value;
  Computed<bool> _$hasErrorsInLoginComputed;

  @override
  bool get hasErrorsInLogin => (_$hasErrorsInLoginComputed ??=
          Computed<bool>(() => super.hasErrorsInLogin))
      .value;
  Computed<bool> _$hasErrorsInPhoneLoginComputed;

  @override
  bool get hasErrorsInPhoneLogin => (_$hasErrorsInPhoneLoginComputed ??=
          Computed<bool>(() => super.hasErrorsInPhoneLogin))
      .value;
  Computed<bool> _$hasErrorsInRegisterComputed;

  @override
  bool get hasErrorsInRegister => (_$hasErrorsInRegisterComputed ??=
          Computed<bool>(() => super.hasErrorsInRegister))
      .value;
  Computed<bool> _$hasErrorInForgotPasswordComputed;

  @override
  bool get hasErrorInForgotPassword => (_$hasErrorInForgotPasswordComputed ??=
          Computed<bool>(() => super.hasErrorInForgotPassword))
      .value;

  final _$userEmailAtom = Atom(name: '_FormErrorStore.userEmail');

  @override
  String get userEmail {
    _$userEmailAtom.context.enforceReadPolicy(_$userEmailAtom);
    _$userEmailAtom.reportObserved();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.context.conditionallyRunInAction(() {
      super.userEmail = value;
      _$userEmailAtom.reportChanged();
    }, _$userEmailAtom, name: '${_$userEmailAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: '_FormErrorStore.password');

  @override
  String get password {
    _$passwordAtom.context.enforceReadPolicy(_$passwordAtom);
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.conditionallyRunInAction(() {
      super.password = value;
      _$passwordAtom.reportChanged();
    }, _$passwordAtom, name: '${_$passwordAtom.name}_set');
  }

  final _$confirmPasswordAtom = Atom(name: '_FormErrorStore.confirmPassword');

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.context.enforceReadPolicy(_$confirmPasswordAtom);
    _$confirmPasswordAtom.reportObserved();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.context.conditionallyRunInAction(() {
      super.confirmPassword = value;
      _$confirmPasswordAtom.reportChanged();
    }, _$confirmPasswordAtom, name: '${_$confirmPasswordAtom.name}_set');
  }

  final _$phoneNumberAtom = Atom(name: '_FormErrorStore.phoneNumber');

  @override
  String get phoneNumber {
    _$phoneNumberAtom.context.enforceReadPolicy(_$phoneNumberAtom);
    _$phoneNumberAtom.reportObserved();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String value) {
    _$phoneNumberAtom.context.conditionallyRunInAction(() {
      super.phoneNumber = value;
      _$phoneNumberAtom.reportChanged();
    }, _$phoneNumberAtom, name: '${_$phoneNumberAtom.name}_set');
  }

  final _$fullNameAtom = Atom(name: '_FormErrorStore.fullName');

  @override
  String get fullName {
    _$fullNameAtom.context.enforceReadPolicy(_$fullNameAtom);
    _$fullNameAtom.reportObserved();
    return super.fullName;
  }

  @override
  set fullName(String value) {
    _$fullNameAtom.context.conditionallyRunInAction(() {
      super.fullName = value;
      _$fullNameAtom.reportChanged();
    }, _$fullNameAtom, name: '${_$fullNameAtom.name}_set');
  }
}
