import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_list/items_display.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String> taskList = [];

  void deleteItem(String task) {
    setState(() {
      taskList.remove(task);
    });
  }

  void updateTask(String taskToUpdate) {
    int index = taskList.indexOf(taskToUpdate);
    _textEditingController.text = taskList[index];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color endColor = const Color(0XFF30D9FF);
    Color startColor = const Color(0xFF94F5FF);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Inventory Managment",
          style: TextStyle(fontFamily: "MyFont"),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [startColor, endColor],
            ),
          ),
        ),
        leading: const Icon(Icons.inventory),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: "Enter Task",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: startColor),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      prefixIcon: const Icon(Icons.abc_rounded),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    String enteredText = _textEditingController.text;

                    if (enteredText.isNotEmpty) {
                      setState(() {
                        if (taskList.contains(enteredText)) {
                          int index = taskList.indexOf(enteredText);
                          taskList[index] = enteredText;
                          _textEditingController.clear();
                          Fluttertoast.showToast(
                              msg: "Task Already Exists",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          taskList.add(enteredText);
                          _textEditingController.clear();
                        }
                      });
                    } else {
                      Fluttertoast.showToast(
                          msg: "Empty Task",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color(0XFF30D9FF),
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  child: const Text("+"),
                ),
              ],
            ),
            const SizedBox(height: 15),
            taskList.isEmpty
                ? ItemsList(
                    task: "No Task In List",
                    onDelete: deleteItem,
                    onUpdate: updateTask)
                : Expanded(
                    child: ListView.builder(
                      itemCount: taskList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            ItemsList(
                              task: taskList[index],
                              onDelete: deleteItem,
                              onUpdate: (newTask) => updateTask(newTask),
                            ),
                            const SizedBox(height: 15)
                          ],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
