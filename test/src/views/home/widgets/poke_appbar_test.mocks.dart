// Mocks generated by Mockito 5.4.5 from annotations
// in poke_api/test/src/views/home/widgets/poke_appbar_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:flutter/material.dart' as _i2;
import 'package:flutter_riverpod/flutter_riverpod.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:poke_api/src/config/theme/theme.dart' as _i3;
import 'package:state_notifier/state_notifier.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeThemeData_0 extends _i1.SmartFake implements _i2.ThemeData {
  _FakeThemeData_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);

  @override
  String toString({_i2.DiagnosticLevel? minLevel = _i2.DiagnosticLevel.info}) =>
      super.toString();
}

/// A class which mocks [ThemeNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockThemeNotifier extends _i1.Mock implements _i3.ThemeNotifier {
  MockThemeNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set onError(_i4.ErrorListener? _onError) => super.noSuchMethod(
    Invocation.setter(#onError, _onError),
    returnValueForMissingStub: null,
  );

  @override
  bool get mounted =>
      (super.noSuchMethod(Invocation.getter(#mounted), returnValue: false)
          as bool);

  @override
  _i5.Stream<_i2.ThemeData> get stream =>
      (super.noSuchMethod(
            Invocation.getter(#stream),
            returnValue: _i5.Stream<_i2.ThemeData>.empty(),
          )
          as _i5.Stream<_i2.ThemeData>);

  @override
  _i2.ThemeData get state =>
      (super.noSuchMethod(
            Invocation.getter(#state),
            returnValue: _FakeThemeData_0(this, Invocation.getter(#state)),
          )
          as _i2.ThemeData);

  @override
  set state(_i2.ThemeData? value) => super.noSuchMethod(
    Invocation.setter(#state, value),
    returnValueForMissingStub: null,
  );

  @override
  _i2.ThemeData get debugState =>
      (super.noSuchMethod(
            Invocation.getter(#debugState),
            returnValue: _FakeThemeData_0(this, Invocation.getter(#debugState)),
          )
          as _i2.ThemeData);

  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);

  @override
  _i5.Future<void> toggleTheme() =>
      (super.noSuchMethod(
            Invocation.method(#toggleTheme, []),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);

  @override
  _i5.Future<void> loadTheme() =>
      (super.noSuchMethod(
            Invocation.method(#loadTheme, []),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);

  @override
  bool updateShouldNotify(_i2.ThemeData? old, _i2.ThemeData? current) =>
      (super.noSuchMethod(
            Invocation.method(#updateShouldNotify, [old, current]),
            returnValue: false,
          )
          as bool);

  @override
  _i4.RemoveListener addListener(
    _i6.Listener<_i2.ThemeData>? listener, {
    bool? fireImmediately = true,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #addListener,
              [listener],
              {#fireImmediately: fireImmediately},
            ),
            returnValue: () {},
          )
          as _i4.RemoveListener);

  @override
  void dispose() => super.noSuchMethod(
    Invocation.method(#dispose, []),
    returnValueForMissingStub: null,
  );
}
