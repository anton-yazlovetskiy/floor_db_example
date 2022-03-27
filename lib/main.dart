import 'package:faker/faker.dart';
import 'package:floor_db_example/database/database.dart';
import 'package:floor_db_example/entity/employee.dart';
import 'package:floor_db_example/entity/employee_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('todoDB.db').build();
  final dao = database.employeeDAO;

  runApp(MyApp(dao: dao));
}

class MyApp extends StatelessWidget {
  final EmployeeDAO dao;
  const MyApp({Key? key, required this.dao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(dao: dao),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final EmployeeDAO dao;
  const MyHomePage({Key? key, required this.dao}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Floor DB'),
        ),
        body: StreamBuilder(
          stream: widget.dao.getAllEmployee(),
          builder: (context, snapshot) {
            var listEmp = snapshot.data as List;
            if (snapshot.hasError) {
              return const Text('error');
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: listEmp.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      child: ListTile(
                        title: Text(
                            '${listEmp[index].firstName} ${listEmp[index].lastName}'),
                        subtitle: Text('${listEmp[index].email}'),
                      ),
                      //endActionPane: ,
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () async {
                await widget.dao.deleteAllEmployee();
                setState(() {});
                //showSnackBar(scaffoldKey.currentState, 'Item add ');
              },
              tooltip: 'Increment',
              child: const Icon(Icons.clear),
            ),
            FloatingActionButton(
              onPressed: () async {
                final Employee emp = Employee(
                    firstName: Faker().person.firstName(),
                    lastName: Faker().person.lastName(),
                    email: Faker().internet.email());
                await widget.dao.insertEmployee(emp);
                //showSnackBar(scaffoldKey.currentState, 'Item add ');
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ],
        ));
  }

  // void showSnackBar(ScaffoldState? currentState, String s) {
  //   final snackBar = SnackBar(content: Text(s));
  //   currentState?.showSnackBar(snackBar);
  //   //ScaffoldMessenger.showSnackBar
  // }
}
