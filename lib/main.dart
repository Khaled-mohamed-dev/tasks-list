import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list/app_database.dart';
import 'package:task_list/hero_dialogue_route.dart';
import 'package:task_list/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<TasksDao>(
          create: (_) => MyDataBase().tasksDao,
        ),
        ChangeNotifierProvider(
          create: (_) => HomePageProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

var date = DateTime.now();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<TasksDao>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF5F7FA),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              HeroDialogRoute(
                builder: (_) => const CreateTask(),
              ),
            );
          },
          backgroundColor: const Color(0xff2F58E2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          label: const Text('Create task'),
          icon: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Consumer<HomePageProvider>(
          builder: (BuildContext context, value, _) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(32, 32, 32, 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(value.date),
                          const SizedBox(height: 8),
                          const Text(
                            'Tasks',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                      MaterialButton(
                        padding: const EdgeInsets.all(0),
                        shape: const CircleBorder(),
                        onPressed: () async {
                          var newDate = await showDatePicker(
                            context: context,
                            initialDate: value.date.dateTimeParse(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 365)),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );
                          value.changeDate(
                              newDate ?? value.date.dateTimeParse());
                        },
                        color: const Color(0xff58D4F1),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.date_range_rounded,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      children: const [
                        FilterType(text: 'All'),
                        SizedBox(width: 20),
                        FilterType(text: 'Completed'),
                        SizedBox(width: 20),
                        FilterType(text: 'Not completed'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: dao.watchTasks(),
                      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
                        List<Task> data = snapshot.data ?? [];

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          var filteredData = value.filter == 'All'
                              ? data.reversed.toList()
                              : value.filter == 'Not completed'
                                  ? data.reversed
                                      .where((task) => task.isChecked == false)
                                      .toList()
                                      .reversed
                                      .toList()
                                  : data
                                      .where((task) => task.isChecked == true)
                                      .toList()
                                      .reversed
                                      .toList();
                          var superFilteredData = filteredData
                              .where((task) =>
                                  task.date.formatDate() == value.date)
                              .toList();
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: superFilteredData.length,
                            itemBuilder: (_, index) {
                              return TaskCard(
                                task: superFilteredData[index],
                              );
                            },
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class TaskCard extends StatefulWidget {
  const TaskCard({
    Key? key,
    required this.task,
  }) : super(key: key);
  final Task task;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<TasksDao>(context);
    bool isChecked = widget.task.isChecked;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return const Color(0xff1AFF00);
                    }
                    return Colors.grey;
                  }),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(
                      () {
                        isChecked = value!;
                        dao.updateTask(widget.task.copyWith(isChecked: value));
                      },
                    );
                  },
                ),
              ),
            ),
            AnimatedContainer(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: 4,
              height: 48,
              decoration: BoxDecoration(
                color: !isChecked
                    ? const Color(0xffFF006F)
                    : const Color(0xff1AFF00),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: !isChecked
                          ? const Color(0xffFF006F)
                          : const Color(0xff1AFF00),
                      blurRadius: 10)
                ],
              ),
              duration: const Duration(milliseconds: 350),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.taskText,
                    style: TextStyle(
                      fontSize: 14,
                      decoration: isChecked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.task.priority,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  dao.deleteTask(widget.task);
                },
                icon: const Icon(Icons.remove))
          ],
        ),
      ),
    );
  }
}

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final TextEditingController _taskNameController = TextEditingController();
  String? selected;

  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<TasksDao>(context);
    final provider = Provider.of<HomePageProvider>(context);
    return Center(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Card(
          color: const Color(0xff2F58E2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create new Task',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _taskNameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Task Name',
                    hintStyle: TextStyle(color: Colors.grey[200]),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'priority',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Wrap(
                      spacing: 20,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = 'High';
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              color: selected == 'High'
                                  ? Colors.white
                                  : const Color(0xff2F58E2),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              child: Text(
                                'High',
                                style: TextStyle(
                                  fontWeight: selected == 'High'
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: selected != 'High'
                                      ? Colors.white
                                      : const Color(0xff2F58E2),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = 'Medium';
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              color: selected == 'Medium'
                                  ? Colors.white
                                  : const Color(0xff2F58E2),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              child: Text(
                                'Medium',
                                style: TextStyle(
                                  fontWeight: selected == 'Medium'
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: selected != 'Medium'
                                      ? Colors.white
                                      : const Color(
                                          0xff2F58E2,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = 'Low';
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              color: selected == 'Low'
                                  ? Colors.white
                                  : const Color(0xff2F58E2),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              child: Text(
                                'Low',
                                style: TextStyle(
                                  fontWeight: selected == 'Low'
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: selected != 'Low'
                                      ? Colors.white
                                      : const Color(0xff2F58E2),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = 'Very Low';
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              color: selected == 'Very Low'
                                  ? Colors.white
                                  : const Color(0xff2F58E2),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              child: Text(
                                'Very Low',
                                style: TextStyle(
                                  fontWeight: selected == 'Very Low'
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: selected != 'Very Low'
                                      ? Colors.white
                                      : const Color(0xff2F58E2),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Center(
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      if (selected == null &&
                          _taskNameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Color(0xff2F58E2),
                            content: Text(
                                'Make sure to write a task name and select priority level'),
                          ),
                        );
                      } else if (selected == null &&
                          _taskNameController.text.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Color(0xff2F58E2),
                            content:
                                Text('Make sure to  select priority level'),
                          ),
                        );
                      } else if (selected != null &&
                          _taskNameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Color(0xff2F58E2),
                            content: Text('Make sure to write a task name'),
                          ),
                        );
                      } else {
                        dao.insertTask(
                          TasksCompanion(
                            taskText: drift.Value(_taskNameController.text),
                            priority: drift.Value(selected!),
                            date: drift.Value(DateTime.parse(provider.date)),
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FilterType extends StatefulWidget {
  const FilterType({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  State<FilterType> createState() => _FilterTypeState();
}

class _FilterTypeState extends State<FilterType> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, value, child) => GestureDetector(
        onTap: () {
          setState(() {
            value.changeFilter(widget.text);
          });
        },
        child: Text(
          widget.text,
          style: TextStyle(
              color:
                  value.filter == widget.text ? Colors.black : Colors.black26),
        ),
      ),
    );
  }
}
