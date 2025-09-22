import 'package:flutter/material.dart';

class Mainpagemenu extends StatefulWidget {
  const Mainpagemenu({super.key});

  @override
  State<Mainpagemenu> createState() => _MainpagemenuState();
}

class _MainpagemenuState extends State<Mainpagemenu> {
  final TextEditingController _controllertodo = TextEditingController();
  final List<TodoItem> _items = [];

  void _additemTodo() {
    final text = _controllertodo.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _items.add(TodoItem(text: text));
        _controllertodo.clear();
      });
    }
  }

  void _toggleCheck(int index, bool? value) {
    setState(() {
      _items[index].isDone = value ?? false;
    });
  }

  void _clearAll() {
    setState(() {
      _items.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final cardColor = isDark ? Colors.grey[900] : Colors.grey[100];
    final textColor = Theme.of(context).colorScheme.onBackground;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Tasks',
          style: TextStyle(
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Text(
              'Welcome!\nLet\'s stay productive 🧠',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _items.isEmpty
                ? Center(
                    child: Text(
                      'No tasks yet.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        color: cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              Checkbox(
                                value: item.isDone,
                                onChanged: (value) =>
                                    _toggleCheck(index, value),
                                activeColor: primaryColor,
                              ),
                              Expanded(
                                child: Text(
                                  item.text,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: textColor,
                                    decoration: item.isDone
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _items.removeAt(index);
                                  });
                                },
                                tooltip: 'Remove task',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controllertodo,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: 'Add new task',
                      hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
                      filled: true,
                      fillColor: cardColor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => _additemTodo(),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: _additemTodo,
                  backgroundColor: primaryColor,
                  mini: true,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TodoItem {
  String text;
  bool isDone;

  TodoItem({required this.text, this.isDone = false});
}
