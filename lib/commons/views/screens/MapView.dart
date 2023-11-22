import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notjust_hack/res/themes.dart';

class MapView extends ConsumerStatefulWidget {
  const MapView({super.key});

  static const String routePath = '/map';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<MapView> {
  late bool _navigationMode;
  late int _pointerCount;
  late FollowOnLocationUpdate _followOnLocationUpdate;
  late TurnOnHeadingUpdate _turnOnHeadingUpdate;
  late StreamController<double?> _followCurrentLocationStreamController;
  late StreamController<void> _turnHeadingUpStreamController;

  @override
  void initState() {
    super.initState();
    _navigationMode = true;
    _pointerCount = 0;
    _followOnLocationUpdate = FollowOnLocationUpdate.always;
    _turnOnHeadingUpdate = TurnOnHeadingUpdate.always;
    _followCurrentLocationStreamController = StreamController<double?>();
    _turnHeadingUpStreamController = StreamController<void>();
  }

  @override
  void dispose() {
    _followCurrentLocationStreamController.close();
    _turnHeadingUpStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialZoom: 19,
          onPointerDown: _onPointerDown,
          onPointerUp: _onPointerUp,
          onPointerCancel: _onPointerUp,
        ),
        // ignore: sort_child_properties_last
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/edisonmodesto/cloqk3p9w005n01r61k0zfs1e/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZWRpc29ubW9kZXN0byIsImEiOiJjbGRlMzVqbnEwOW82M3BrNmNqdzI4Mm9kIn0.NCO-_8zS4SPhzFa0YNTyPw',
            userAgentPackageName: 'net.tlserver6y.flutter_map_location_marker.example',
            maxZoom: 19,
          ),
          CurrentLocationLayer(
            followScreenPoint: const Point(0.0, 1.0),
            followScreenPointOffset: const Point(0.0, -60.0),
            followCurrentLocationStream: _followCurrentLocationStreamController.stream,
            turnHeadingUpLocationStream: _turnHeadingUpStreamController.stream,
            followOnLocationUpdate: _followOnLocationUpdate,
            turnOnHeadingUpdate: _turnOnHeadingUpdate,
            style: LocationMarkerStyle(
              accuracyCircleColor: AppColors().primary.withOpacity(0.2),
              headingSectorColor: AppColors().primary.withOpacity(1),
              marker: DefaultLocationMarker(
                color: AppColors().primary,
                child: const Icon(
                  Icons.navigation,
                  color: Colors.white,
                ),
              ),
              markerSize: const Size(40, 40),
              markerDirection: MarkerDirection.heading,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton(
                backgroundColor: _navigationMode ? AppColors().primary : Colors.grey,
                foregroundColor: Colors.white,
                onPressed: () {
                  setState(
                    () {
                      _navigationMode = !_navigationMode;
                      _followOnLocationUpdate = _navigationMode ? FollowOnLocationUpdate.always : FollowOnLocationUpdate.never;
                      _turnOnHeadingUpdate = _navigationMode ? TurnOnHeadingUpdate.always : TurnOnHeadingUpdate.never;
                    },
                  );
                  if (_navigationMode) {
                    _followCurrentLocationStreamController.add(18);
                    _turnHeadingUpStreamController.add(null);
                  }
                },
                child: const Icon(
                  Icons.navigation_outlined,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Disable follow and turn temporarily when user is manipulating the map.
  void _onPointerDown(e, l) {
    _pointerCount++;
    setState(() {
      _followOnLocationUpdate = FollowOnLocationUpdate.never;
      _turnOnHeadingUpdate = TurnOnHeadingUpdate.never;
    });
  }

  // Enable follow and turn again when user end manipulation.
  void _onPointerUp(e, l) {
    if (--_pointerCount == 0 && _navigationMode) {
      setState(() {
        _followOnLocationUpdate = FollowOnLocationUpdate.always;
        _turnOnHeadingUpdate = TurnOnHeadingUpdate.always;
      });
      _followCurrentLocationStreamController.add(18);
      _turnHeadingUpStreamController.add(null);
    }
  }
}
