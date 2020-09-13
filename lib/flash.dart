import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_better_camera/camera.dart';

/*
class OnFlashButtonPressed extends StatefulWidget {
  @override
  _OnFlashButtonPressed createState() => _OnFlashButtonPressed();
}


class _OnFlashButtonPressed extends State<OnFlashButtonPressed> {
  FlashMode flashMode = FlashMode.off;
  CameraController controller;

  Widget build(BuildContext context) {
    Future<void> _OnFlashButtonPressed() async {
      /* bool hasFlash = false; */
      if (flashMode == FlashMode.off || flashMode == FlashMode.torch) {
        // Turn on the flash for capture
        flashMode = FlashMode.alwaysFlash;
      } else if (flashMode == FlashMode.alwaysFlash) {
        // Turn on the flash for capture if needed
        flashMode = FlashMode.autoFlash;
      } else {
        // Turn off the flash
        flashMode = FlashMode.off;
      }
      // Apply the new mode
      await controller.setFlashMode(flashMode);

      // Change UI State
      setState(() {});
    }
  }
}

*/

class FlashButton extends StatefulWidget {
  @override
  _FlashButton createState() => _FlashButton();
}

class _FlashButton extends State<FlashButton> with WidgetsBindingObserver {
  FlashMode flashMode = FlashMode.off;
  CameraController controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override

  /// Flash Toggle Button
  Widget build(BuildContext context) {
    IconData iconData = Icons.flash_off;
    Color color = Colors.black;
    if (flashMode == FlashMode.alwaysFlash) {
      iconData = Icons.flash_on;
      color = Colors.blue;
    } else if (flashMode == FlashMode.autoFlash) {
      iconData = Icons.flash_auto;
      color = Colors.red;
    }
    return IconButton(
      icon: Icon(iconData),
      color: color,
      onPressed: controller != null && controller.value.isInitialized
          ? _onFlashButtonPressed
          : null,
    );
  }

  Future<void> _onFlashButtonPressed() async {
    /* bool hasFlash = false; */
    if (flashMode == FlashMode.off || flashMode == FlashMode.torch) {
      // Turn on the flash for capture
      flashMode = FlashMode.alwaysFlash;
    } else if (flashMode == FlashMode.alwaysFlash) {
      // Turn on the flash for capture if needed
      flashMode = FlashMode.autoFlash;
    } else {
      // Turn off the flash
      flashMode = FlashMode.off;
    }
    // Apply the new mode
    await controller.setFlashMode(flashMode);

    // Change UI State
    setState(() {});
  }
}
