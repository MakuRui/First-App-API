import 'package:api_practice/custom_widgets/custom_text_widget.dart';
import 'package:api_practice/models/todos_model.dart';
import 'package:flutter/material.dart';

class TodoDetailsPage extends StatefulWidget {
  final TodosModel todoModel;
  const TodoDetailsPage({Key? key, required this.todoModel}) : super(key: key);

  @override
  State<TodoDetailsPage> createState() => _TodoDetailsPageState();
}

class _TodoDetailsPageState extends State<TodoDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo Details', style: TextStyle(fontSize: 25),),
      ),
      body: ListView(
        children: [
          CustomTextWidget(
              textTitle: 'User Id',
              textDetails: ':${widget.todoModel.userId.toString()}',
          ),
          CustomTextWidget(
            textTitle: 'Id',
            textDetails: ':${widget.todoModel.id.toString()}',
          ),
          CustomTextWidget(
            textTitle: 'Title',
            textDetails: ':${widget.todoModel.title.toString()}',
          ),
          CustomTextWidget(
            textTitle: 'Completed',
            textDetails: ':${widget.todoModel.completed.toString()}',
          ),
        ],
      ),
    );
  }
}
