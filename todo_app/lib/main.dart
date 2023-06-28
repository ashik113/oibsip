import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

enum Category {
  TodoTask,
  MeetScheduling,
  Notes,
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.grey[900],
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  List<TodoItem> todoList = [];

  void addTodoItem(TodoItem item) {
    setState(() {
      todoList.add(item);
    });
  }

  void deleteTodoItem(TodoItem item) {
    setState(() {
      todoList.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              _navigateToAbout();
            },
          ),

        ],
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todoList[index].title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(todoList[index].description),
                if (todoList[index].category == Category.MeetScheduling)
                  Text('Meeting Time: ${todoList[index].meetingTime}'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteTodoItem(todoList[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddTodoDialog();
        },
      ),
    );
  }

  void _showAddTodoDialog() {
    Category selectedCategory = Category.TodoTask;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String description = '';
        String meetName = '';
        String meetObjective = '';
        DateTime? meetingTime;

        return StatefulBuilder(
          builder: (context, setState) {
            Widget dialogContent;

            switch (selectedCategory) {
              case Category.TodoTask:
                dialogContent = Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(hintText: 'Title'),
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      decoration: InputDecoration(hintText: 'Description'),
                      onChanged: (value) {
                        description = value;
                      },
                    ),
                  ],
                );
                break;
              case Category.MeetScheduling:
                dialogContent = Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(hintText: 'Meeting Name'),
                      onChanged: (value) {
                        meetName = value;
                      },
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      decoration: InputDecoration(hintText: 'Meeting Objective'),
                      onChanged: (value) {
                        meetObjective = value;
                      },
                    ),
                    SizedBox(height: 8.0),
                    TextButton(
                      child: Text(
                        meetingTime != null
                            ? 'Meeting Time: ${_formatDateTime(meetingTime!)}'
                            : 'Select Meeting Time',
                      ),
                      onPressed: () {
                        _selectMeetingTime().then((selectedTime) {
                          setState(() {
                            meetingTime = selectedTime;
                          });
                        });
                      },
                    ),
                  ],
                );
                break;
              case Category.Notes:
                dialogContent = TextField(
                  decoration: InputDecoration(hintText: 'Write your notes...'),
                  onChanged: (value) {
                    description = value;
                  },
                  maxLines: null,
                );
                break;
            }

            return AlertDialog(
              title: Text('Add Todo Item'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  DropdownButton<Category>(
                    value: selectedCategory,
                    onChanged: (Category? newValue) {
                      setState(() {
                        selectedCategory = newValue!;
                      });
                    },
                    items: Category.values.map<DropdownMenuItem<Category>>(
                          (Category value) {
                        return DropdownMenuItem<Category>(
                          value: value,
                          child: Text(
                            getCategoryText(value),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  SizedBox(height: 8.0),
                  dialogContent,
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Add'),
                  onPressed: () {
                    TodoItem newItem;

                    switch (selectedCategory) {
                      case Category.TodoTask:
                        newItem = TodoItem(
                          title: title,
                          description: description,
                          category: selectedCategory,
                        );
                        break;
                      case Category.MeetScheduling:
                        newItem = TodoItem(
                          title: meetName,
                          description: meetObjective,
                          meetingTime: meetingTime,
                          category: selectedCategory,
                        );
                        break;
                      case Category.Notes:
                        newItem = TodoItem(
                          title: 'Notes',
                          description: description,
                          category: selectedCategory,
                        );
                        break;
                    }

                    addTodoItem(newItem);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _navigateToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );
  }

  void _navigateToAbout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AboutPage()),
    );
  }

  void _navigateToContact() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContactPage()),
    );
  }

  Future<DateTime?> _selectMeetingTime() async {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }

  String getCategoryText(Category category) {
    switch (category) {
      case Category.TodoTask:
        return 'Todo Task';
      case Category.MeetScheduling:
        return 'Meet Scheduling';
      case Category.Notes:
        return 'Notes';
    }
  }
}

class TodoItem {
  final String title;
  final String description;
  final DateTime? meetingTime;
  final Category category;

  TodoItem({
    required this.title,
    required this.description,
    this.meetingTime,
    required this.category,
  });
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Todo App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Version: 1.0.0',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            ),
          ],
        ),
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: Center(
        child: Text('Contact Page'),
      ),
    );
  }
}
