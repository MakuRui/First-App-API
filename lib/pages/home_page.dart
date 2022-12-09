import 'package:api_practice/forms/add_todo_form.dart';
import 'package:api_practice/forms/update_todo_form.dart';
import 'package:api_practice/models/todos_model.dart';
import 'package:api_practice/pages/todo_details_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List todoList = <dynamic>[];
  List <TodosModel> todoModel = [];

  var baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  @override
  void initState() {
    super.initState();
    todoConvert();
  }

  //CONVERT data to TodosModel
  void todoConvert () async {
    await todoGet();
    for (int i = 0; i < todoList.length; i++) {
      setState(() {
        todoModel.add(TodosModel.fromJson(todoList[i]));
      });
    }
  }

  //READ
  Future todoGet () async {
    var url = Uri.parse(baseUrl);
    var response = await http.get(url);
    
    if (response.statusCode == 200){
      setState(() {
        todoList = convert.jsonDecode(response.body) as List <dynamic>;
      });
    } else {
      throw Exception('Request failed with a status: ${response.statusCode}');
    }
  }

  //CREATE
  Future <TodosModel> todoPost(String title, bool completed,
      int userId, int id) async {
    var response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(<String, dynamic>{
        'id' : id,
        'userId' : userId,
        'title' : title,
        'completed' : completed,
      })
    );
    if (response.statusCode == 201){
      showSuccessMessage('Created Successfully');
      return TodosModel.fromJson(convert.jsonDecode(response.body));
    } else {
      showErrorMessage('Request failed with a status: ${response.statusCode}');
      throw Exception('Failed to create todo');
    }
  }

  //UPDATE
  Future <TodosModel> todoPatch (String title,int id,
      int userId, bool completed) async {
    var response = await http.patch(Uri.parse(
        '$baseUrl/$id?userId=$userId&title=$title&completed=$completed'),
      body: convert.jsonEncode(<String, dynamic>{
        'title' : title,
        'userId' : userId,
        'completed' : completed,
      })
    );
    if (response.statusCode == 200){
      showSuccessMessage('Updated Successfully');
      return TodosModel.fromJson(convert.jsonDecode(response.body));
    } else {
      showErrorMessage('Request failed with a status: ${response.statusCode}');
      throw Exception('Failed to update todo');
    }
  }

  //DELETE
  Future <TodosModel> todoDelete (String id) async {
    var response = await http.delete(
        Uri.parse('$baseUrl/$id'),
    );
    if (response.statusCode == 200){
      showSuccessMessage('Deleted Successfully');
      return TodosModel.fromJson(convert.jsonDecode(response.body));
    } else {
      showErrorMessage('Request failed with a status: ${response.statusCode}');
      throw Exception('Failed to delete todo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todos'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: todoModel.length,
            itemBuilder: (context, index){
            var finalTodo = todoModel[index];
            return Dismissible(
              direction: DismissDirection.endToStart,
                key: UniqueKey(),
                child: Card(
                  elevation: 4.0,
                  child: ListTile(
                    title: Text(finalTodo.title),
                    subtitle: Text(finalTodo.id.toString()),
                    trailing: IconButton(
                        onPressed: () async {
                          TodosModel todoPost = await Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateTodoForm(
                                    title: finalTodo.title,
                                    id: finalTodo.id,
                                    completed: finalTodo.completed,
                                    userId: finalTodo.userId,
                                  )));
                          setState(() {
                            todoModel[index].title = todoPost.title;
                            todoModel[index].completed = todoPost.completed;
                            todoPatch(todoPost.title, todoPost.id,
                                todoPost.userId, todoPost.completed);
                          });
                        },
                         icon: const Icon(Icons.edit,)
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder:(context) => TodoDetailsPage(
                              todoModel: todoModel[index])));
                    }
                  ),
                ),
              onDismissed: (direction){
                setState(() {
                  todoList.removeAt(index);
                  todoModel.removeAt(index);
                  todoDelete(todoModel[index].id.toString());
                });
              },
            );
            }
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
          onPressed: () async {
            TodosModel todoCreate = await Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => AddTodoForm(todoList: todoModel,)));
            setState(() {
              todoModel.add(todoCreate);
              todoPost(todoCreate.title,
                  todoCreate.completed,
                  todoCreate.userId,
                  todoCreate.id,
              );
            });
          }),
    );
  }
  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
        content: Text(message),
      backgroundColor: Colors.green,

    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void showErrorMessage(String message) {
    final snackBar = SnackBar(
        content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
