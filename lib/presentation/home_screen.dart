// ignore_for_file: body_might_complete_normally_nullable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:to_do_app_1/model/taskmodel.dart';
import 'package:to_do_app_1/presentation/splash_screen.dart';
import 'package:to_do_app_1/presentation/statusDetails.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
   final _formkey = GlobalKey<FormState>();

    List<ToDoModel> todolist = [];
    // ToDoModel(taskID: "1", taskName: "walk", taskStatus: '1'),
    // ToDoModel(taskID: "2", taskName: "talk", taskStatus: '0'),
    // ToDoModel(taskID: "3", taskName: "run", taskStatus: '1'),
    // ToDoModel(taskID: "1", taskName: "walk", taskStatus: '1'),
    // ToDoModel(taskID: "2", taskName: "talk", taskStatus: '0'),
    // ToDoModel(taskID: "3", taskName: "run", taskStatus: '1'),
    // ToDoModel(taskID: "1", taskName: "walk", taskStatus: '1'),
    // ToDoModel(taskID: "2", taskName: "talk", taskStatus: '0'),
    // ToDoModel(taskID: "3", taskName: "run", taskStatus: '1'),
    // ToDoModel(taskID: "1", taskName: "walk", taskStatus: '1'),
    // ToDoModel(taskID: "2", taskName: "talk", taskStatus: '0'),
    // ToDoModel(taskID: "3", taskName: "run", taskStatus: '1'),
  
   String? editingTaskId;
   int todocounter = 0;
   String editflag='0';
   final textcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.blue,
         toolbarHeight: 80,
         leading: IconButton(onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenSplash() ));
         }, icon: Icon(Icons.arrow_back)),
         title: Text("ToDO APP",style: TextStyle(color: Colors.white,
                                                 fontSize: 35,
                                                 fontStyle: FontStyle.italic,
                                                 fontWeight: FontWeight.bold
         ),
         ),
       ),
       body: Form(
        key: _formkey,
         child: ListView(
           children: [
             SizedBox(
              height: MediaQuery.of(context).size.height * .15,
               child: Row(
                 children: [
                   Expanded(
                     child: Padding(
                       padding: EdgeInsets.only(top:20,left: 20,right: 10),
                       child: TextFormField(
                        controller: textcontroller,
                          validator: (value) {
                      if(value!.isEmpty || value == null){
                        return "Task is required";
                      }
                    },
                          decoration: InputDecoration(
                           hintText: "Enter your task here",
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(6)
                           )
                          ),
                       ),
                     ),
                   ),
                   Padding(
                     padding: EdgeInsets.only(top:20,right: 20),
                     child: Center(
                       child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           IconButton(
                              onPressed: (){
                                if (_formkey.currentState!.validate()){
                                  if(editflag=='0'){
                                  todocounter=todocounter+1;
                                  ToDoModel t=ToDoModel(taskID: todocounter.toString(), taskName: textcontroller.text, taskStatus: "0" );
                                 setState(() {
                                    addTodo(t);
                                 });
                                 }
                                 else{
                                  setState(() {
                                    updateTask(editingTaskId!,textcontroller.text);
                                    changecancel();
                                  });
                                 }}
                                 },
                              icon:  Icon(
                                 editflag == '0' ? Icons.add : Icons.save,
                                 color:  Colors.pink,
                              )
                              ),
                            Visibility(
                              visible: editflag == '0' ? false : true,
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                    changecancel();
                                  }
                                  );
                                }, 
                                icon: Icon(Icons.cancel)
                                )
                                )
                         ],
                       ),
                     ),
                   )
                 ],
               ),
             ),
             SizedBox(
              height: MediaQuery.of(context).size.height * .7,
              child: ListView.separated(
                itemBuilder: (context,index){
                  return ListTile(
                    onTap: (){
                      setState(() {
                        toggleStatus(todolist[index].taskID);
                        
                      });
                      
                    },
                     leading: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle
                      ),
                       child: Text((index+1).toString(),style: TextStyle(
                                                                        fontSize: 20,
                                                                        color: Colors.white
                       ),
                       ),
                     ),
                     title: Row(
                       children: [
                         Text(todolist[index].taskName,style: TextStyle(
                                                                          fontSize: 25
                         ),
                         ),
                         Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                     Statusdetails(task: todolist[index]),
                                ),
                              );
                            },
                            icon: Icon(Icons.arrow_forward_rounded, size: 20),
                          ),
                       ],
                     ),
                     subtitle: Row(
                       children: [
                         Text(todolist[index].taskStatus=='0' ? 'Status: Not Completed' : 'Status: Completed',
                         style: TextStyle(
                           color: todolist[index].taskStatus=='0'? Colors.red :Colors.green
                         ),),
                         Spacer(),
                         IconButton(onPressed: (){
                          setState(() {
                            deleteToDo(todolist[index].taskID);
                          });
                           
                         }, icon: Icon(Icons.delete)),
                         IconButton(onPressed: (){
                          setState(() {
                            changeEdit(todolist[index]);
                            
                          });
                         }, icon: Icon(Icons.edit))
                       ],
                     ),
                  );
                }, 
                separatorBuilder: (context,index){
                  return Divider();
                }, 
                itemCount: todolist.length
                ),

             )
           ],
         ),
       ),
    );
  }
  void addTodo(ToDoModel t){
    todolist.add(t);
  }
  void deleteToDo(String taskID){
    todolist.removeWhere((item) => item.taskID == taskID);

  }
  void changeEdit(ToDoModel task){
    editflag="1";
    editingTaskId=task.taskID;
    textcontroller.text=task.taskName;

  }
  void changecancel(){
    editflag='0';
    textcontroller.clear();
    
  }
  void toggleStatus(String taskID) {
    for (var task in todolist) {
      if (task.taskID == taskID) {
        task.taskStatus = task.taskStatus == '0' ? '1' : '0';
        break;
      }
    }
}
void updateTask(String taskID,String newName){
  for (var doc in todolist){
    if (doc.taskID==taskID){
      doc.taskName=newName;
    }
  }
}
}