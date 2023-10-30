import 'package:fluent_ui/fluent_ui.dart';

class ConnectStateCircle extends StatelessWidget {
  final bool isConnected;
  const ConnectStateCircle({super.key, required this.isConnected});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: isConnected ? 'Connected' : 'Disconnected',
      child: Card(
        borderRadius: BorderRadius.circular(50),
        backgroundColor: isConnected ? Colors.green : Colors.red,
        child: Icon(
          isConnected
              ? FluentIcons.plug_connected
              : FluentIcons.plug_disconnected,
        ),
      ),
    );
  }
}
