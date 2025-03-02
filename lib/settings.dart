import 'package:flutter/material.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';

class Settings extends StatefulWidget {
  const Settings({
    Key? key,
    required this.windowController,
    required this.args,
  }) : super(key: key);

  final WindowController windowController;
  final Map? args;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _selectedValue = 'NASDAQ';
  static const String _storageKey = 'selected_content_type';

  @override
  void initState() {
    super.initState();
    _loadSelectedValue();
  }

  Future<void> _loadSelectedValue() async {
    final selectedValue = await DesktopMultiWindow.invokeMethod(0, 'getValueFromSharedPreference', {'key': _storageKey});
    setState(() {
      _selectedValue = selectedValue ?? 'NASDAQ';
    });
  }

  void _selectChanged(String newValue) async {
    await DesktopMultiWindow.invokeMethod(0, 'setStringToSharedPreference', {'key': _storageKey, 'value': newValue});
    setState(() {
      _selectedValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: const Color(0xFFE5E5E5),
      ),
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(38),
          child: AppBar(
            elevation: 0,
            backgroundColor: const Color(0xFFE5E5E5),
            title: const Text(
              'Preferences',
              style: TextStyle(
                fontSize: 13,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: Center(
          child:  Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Content',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: PopupMenuButton<String>(
                  initialValue: _selectedValue,
                  onSelected: _selectChanged,
                  itemBuilder: (BuildContext context) => [
                    'NASDAQ',
                    'Fortune',
                    'Personality',
                    'Love',
                  ].map((String value) => PopupMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  )).toList(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: SizedBox(
                      width: 95,
                      child:  Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          _selectedValue,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        const Icon(Icons.arrow_drop_down, size: 20),
                      ],
                    ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ),
        ),
    );
  }
}