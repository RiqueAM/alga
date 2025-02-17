import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/info/device_info/device_info_provider.dart';

class DeviceInfoView extends StatefulWidget {
  const DeviceInfoView({super.key});

  @override
  State<DeviceInfoView> createState() => _DeviceInfoViewState();
}

class _DeviceInfoViewState extends State<DeviceInfoView> {
  final _provider = DeviceInfoProvider();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _provider.init(),
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        return ScrollableToolView(
          title: Text(S.of(context).deviceInfo),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTitle(title: S.of(context).commonInfo),
            ),
            ..._provider.commonInfomations
                .map((e) => ToolViewConfig(
                      title: Text(e.title(context)),
                      subtitle: Text(e.value),
                    ))
                .toList(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTitle(title: S.of(context).platformInfo),
            ),
            ..._provider.infomations
                .map((e) => ToolViewConfig(
                      title: Text(e.title(context)),
                      subtitle: Text(e.value),
                    ))
                .toList()
          ],
        );
      },
    );
  }
}
