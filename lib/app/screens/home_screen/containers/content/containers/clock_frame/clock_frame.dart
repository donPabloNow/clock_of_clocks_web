// Copyright 2019 Egor Belibov. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../../g_models/device_type.dart';
import '../../../../../../g_state/device.dart';
import '../../../../../../g_state/theme_essentials.dart'
    show subscribeToBrigthness;
import '../../../../../../g_extensions/apt_brightness.dart';
import 'styles.dart';

class ClockFrame extends StatefulWidget {
  @override
  _ClockFrameState createState() => _ClockFrameState();
}

class _ClockFrameState extends State<ClockFrame> {
  DeviceType _deviceType;
  double _deviceWidth;
  double _deviceHeight;

  Image lightImageAsset;
  Image darkImageAsset;

  @override
  Widget build(BuildContext context) {
    _updateDeviceInfo();
    return _buildClock();
  }

  void _updateDeviceInfo() {
    _deviceType = subscribeToDeviceType(context);
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
  }

  Widget _buildClock() {
    final Brightness brightness = subscribeToBrigthness(context);
    final bool themeIsLight = brightness.isLight();

    if (themeIsLight) {
      lightImageAsset ??= Image.asset('assets/images/lenovo_clock.png');
    } else {
      darkImageAsset ??= Image.asset('assets/images/lenovo_clock_dark.png');
    }

    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: clockFramePadding(_deviceType),
        width: clockFrameWidth(_deviceType, _deviceWidth),
        height: clockFrameHeight(_deviceType, _deviceHeight),
        child: FittedBox(
          alignment: Alignment.bottomLeft,
          fit: BoxFit.contain,
          child: themeIsLight ? lightImageAsset : darkImageAsset,
        ),
      ),
    );
  }
}
