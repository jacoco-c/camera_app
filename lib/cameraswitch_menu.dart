
import 'package:flutter/material.dart';

import 'package:flutter_better_camera/camera.dart';




class CamMenu extends StatefulWidget {
  @override
  _CamMenu createState() => _CamMenu();
}

class _CamMenu extends State<CamMenu> {
  var _value = "1";
  CameraController controller;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.0,
      child: _cameraTogglesMenuWidget(),
    );
  }


  Widget _cameraTogglesMenuWidget () {
    final List<Widget> toggles = <Widget>[];

    if (cameras.isEmpty) {
      return const Text('No camera found');
    } else {
      for (CameraDescription cameraDescription in cameras) {
        toggles.add(
          SizedBox(
            width: 90.0,
            child: RadioListTile<CameraDescription>(
              title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
              groupValue: controller?.description,
              value: cameraDescription,
              onChanged: controller != null && controller.value.isRecordingVideo
                  ? null
                  : onNewCameraSelected,
            ),
          ),
        );
      }
    }
    return DropdownButton(
      items: toggles,
      onChanged: (value) {
        setState(() {
          _value = value;
        });
      },
      value: _value,
      isExpanded: true,
    );
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
    );



    if (mounted) {
      setState(() {});
    }
  }

}

List<CameraDescription> cameras = [];

/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw ArgumentError('Unknown lens direction');
}