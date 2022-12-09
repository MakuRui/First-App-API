import 'package:api_practice/models/todos_model.dart';
import 'package:flutter/material.dart';

class UpdateTodoForm extends StatefulWidget {
  final int userId;
  final bool completed;
  final String title;
  final int id;
  const UpdateTodoForm({Key? key,
    required this.title,
    required this.id,
    required this.userId,
    required this.completed
  }) : super(key: key);


  @override
  State<UpdateTodoForm> createState() => _UpdateTodoFormState();
}

class _UpdateTodoFormState extends State<UpdateTodoForm> {

  var formKey = GlobalKey<FormState>();
  TextEditingController titleCon = TextEditingController();
  bool? completedVal = false;
  int updateId = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      titleCon.text = widget.title;
      updateId = widget.id;
      completedVal = widget.completed;
    });

    // print(widget.userId);
    // print(widget.completed);
    // print(widget.title);
    // print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit the task data', style: TextStyle(fontSize: 25),),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: titleCon,
                  decoration: const InputDecoration(
                    labelText: 'Title'),
                ),
                const SizedBox(height: 10,),
                CheckboxListTile(
                  title: const Text(' Todo completed'),
                  controlAffinity: ListTileControlAffinity.trailing,
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
                ElevatedButton(onPressed: (){
                  if(formKey.currentState!.validate()){
                    TodosModel todoPatch = TodosModel(
                        userId: widget.id,
                        title: titleCon.text,
                        completed: completedVal!,
                        id: updateId,
                    );
                    Navigator.pop(context, todoPatch);
                  }
                },
                    child:const Text('Update')
                )
              ],
            )
        )
      ),
    );
  }
}
