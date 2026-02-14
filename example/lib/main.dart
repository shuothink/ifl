import 'package:flutter/material.dart';
import 'package:ifl/ifl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final KvStorage _storage = _InMemoryKvStorage('example_kv');
  final TextEditingController _keyController = TextEditingController(
    text: 'token',
  );
  final TextEditingController _valueController = TextEditingController(
    text: 'hello',
  );

  String _result = 'No value';

  @override
  void dispose() {
    _keyController.dispose();
    _valueController.dispose();
    _storage.close();
    super.dispose();
  }

  Future<void> _write() async {
    await _storage.write(_keyController.text, _valueController.text);
    setState(() {
      _result = 'Saved';
    });
  }

  Future<void> _read() async {
    final value = await _storage.read(_keyController.text);
    setState(() {
      _result = value ?? 'Not found';
    });
  }

  Future<void> _delete() async {
    await _storage.delete(_keyController.text);
    setState(() {
      _result = 'Deleted';
    });
  }

  Future<void> _clear() async {
    await _storage.clear();
    setState(() {
      _result = 'Cleared';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('KvStorage Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                key: const Key('keyField'),
                controller: _keyController,
                decoration: const InputDecoration(labelText: 'Key'),
              ),
              TextField(
                key: const Key('valueField'),
                controller: _valueController,
                decoration: const InputDecoration(labelText: 'Value'),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  ElevatedButton(
                    key: const Key('writeBtn'),
                    onPressed: _write,
                    child: const Text('Write'),
                  ),
                  ElevatedButton(
                    key: const Key('readBtn'),
                    onPressed: _read,
                    child: const Text('Read'),
                  ),
                  ElevatedButton(
                    key: const Key('deleteBtn'),
                    onPressed: _delete,
                    child: const Text('Delete'),
                  ),
                  ElevatedButton(
                    key: const Key('clearBtn'),
                    onPressed: _clear,
                    child: const Text('Clear'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text('Result: $_result', key: const Key('resultText')),
            ],
          ),
        ),
      ),
    );
  }
}

class _InMemoryKvStorage implements KvStorage {
  _InMemoryKvStorage(this.name);

  final Map<String, String> _map = <String, String>{};

  @override
  final String name;

  @override
  Future<void> clear() async {
    _map.clear();
  }

  @override
  Future<void> close() async {}

  @override
  Future<bool> containsKey(String key) async {
    return _map.containsKey(key);
  }

  @override
  Future<void> delete(String key) async {
    _map.remove(key);
  }

  @override
  Future<List<String>> keys() async {
    final keys = _map.keys.toList()..sort();
    return keys;
  }

  @override
  Future<String?> read(String key) async {
    return _map[key];
  }

  @override
  Future<void> write(String key, String value) async {
    _map[key] = value;
  }
}
