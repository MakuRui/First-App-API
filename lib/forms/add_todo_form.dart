import 'package:api_practice/models/todos_model.dart';
import 'package:flutter/material.dart';

class AddTodoForm extends StatefulWidget {
  final List <dynamic> todoList;
  const AddTodoForm({Key? key, required this.todoList}) : super(key: key);

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {

  var formKey = GlobalKey<FormState>();

  TextEditingController titleCon = TextEditingController();
  TextEditingController userIdCon = TextEditingController();
  bool? completedVal = false;
  int idGenerate = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Todo',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(right: 40, left: 40),
        child: Form(
          key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: userIdCon,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: '1',
                    labelText: 'Please input a user id',
                  ),
                  validator: (value){
                    return value == null
                        || value.isEmpty ? 'user id is required' : null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: titleCon,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Hello World',
                    labelText: 'Please input a title',
                  ),
                  validator: (value){
                    return value == null
                        || value.isEmpty ? 'title is required' : null;
                  },
                ),
                const SizedBox(height:10,),
                Checkbox(
                  value: completedVal,
                  activeColor: Colors.green,
                  onChanged: (newBool){
                    setState(() {
                      completedVal = newBool;
                      newBool = true;
                    });
                  },
                ),
                const SizedBox(height: 10,),
                ElevatedButton(
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        int finalId = idGenerate + widget.todoList.length;
                            TodosModel todoPost = TodosModel(
                          userId: int.parse(userIdCon.text),
                          title: titleCon.text,
                          completed: completedVal!,
                          id: finalId,
                        );
                        Navigator.pop(context, todoPost);
                      }
                      },
                    child: const Text('Submit to add todo')
                )
              ],
            ),
        ),
      ),
    );
  }
}
