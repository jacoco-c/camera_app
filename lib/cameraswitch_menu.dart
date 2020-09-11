
import 'package:flutter/material.dart';

import 'package:flutter_better_camera/camera.dart';
import 'package:camera_app/main.dart';




class CamMenu extends StatefulWidget {
  @override
  _CamMenu createState() => _CamMenu();
}

class _CamMenu extends State<CamMenu> {
  var _value = cameras[0];
  CameraController controller;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.0,
      child: _cameraTogglesMenuWidget(),
    );
  }


  Widget _cameraTogglesMenuWidget () {
    final List<PopupMenuItem> toggles = <PopupMenuItem>[];

    if (cameras.isEmpty) {
      return const Text('No camera found');
    } else {
      for (CameraDescription cameraDescription in cameras) {
        toggles.add(
          PopupMenuItem<CameraDescription>(
              value: cameraDescription,
              child: ListTile (
                title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
              )
          ),
        );
      }
    }
    return PopupMenuButton(
        itemBuilder: (context) => toggles,
        onSelected: (value) {
          setState(() {
            _value = value;
            controller != null&& controller.value.isRecordingVideo
                // ignore: unnecessary_statements
                ? null
                // ignore: unnecessary_statements
                : onNewCameraSelected;
          });
        },
        initialValue: _value,
        icon: Icon(Icons.switch_camera)
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

