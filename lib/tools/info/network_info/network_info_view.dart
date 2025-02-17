import 'package:network_info_plus/network_info_plus.dart';

import 'package:alga/constants/import_helper.dart';

part './network_info_provider.dart';

class NetworkInfoView extends StatelessWidget {
  const NetworkInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollableToolView(
      title: Text(S.of(context).networkInfo),
      children: _infos
          .map((e) => Consumer(builder: (context, ref, _) {
                return ref.watch(e).when(
                      data: (item) {
                        return ToolViewConfig(
                          title: Text(item.title(context)),
                          subtitle: Text(item.value),
                        );
                      },
                      loading: () => const LinearProgressIndicator(),
                      error: (e, stack) => Text(e.toString()),
                    );
              }))
          .toList(),
    );
  }
}
