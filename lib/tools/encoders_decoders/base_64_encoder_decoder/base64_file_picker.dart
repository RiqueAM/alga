part of './base_64_encoder_decoder.dart';

Future _showBase64ImagePicker(BuildContext context, WidgetRef ref) async {
  final file = await ImageUtil.pick();
  if (file == null) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('empty image')));
    return;
  }
  return await showDialog(
    context: context,
    builder: (context) {
      return FutureBuilder<String>(
        future: _computeEncode(file),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done) {
            final data = snap.data ?? '';
            return AlertDialog(
              title: const Text('Base64 from Image'),
              content: data.length > 1000
                  ? const Text('content is too big')
                  : AppTextField(text: data, minLines: 1, maxLines: 12),
              actions: [
                TextButton(
                  onPressed: () async {
                    await ClipboardUtil.copy(data);
                    //TODO
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    //TODO
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('copy success')));
                  },
                  child: Text(S.of(context).copy),
                ),
              ],
            );
          } else {
            return const SimpleDialog(
              children: [
                Center(child: CircularProgressIndicator()),
              ],
            );
          }
        },
      );
    },
  );
}

Future<String> _computeEncode(File file) async {
  return await compute(_encode2Base64, file);
}

Future<String> _encode2Base64(File file) async {
  final bytes = file.readAsBytesSync();
  return const Base64Encoder.urlSafe().convert(bytes);
}

class _Base64ImageButton extends StatelessWidget {
  final WidgetRef ref;
  const _Base64ImageButton({required this.ref});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.image),
      onPressed: () {
        _showBase64ImagePicker(context, ref);
      },
    );
  }
}
