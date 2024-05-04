

import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import '../widgets/todo_item.dart';
import '../model/todo.dart';
// import '../widgets/search_box.dart';



final todoslist = ToDo.todoList();
final _todoController = TextEditingController();
List<ToDo> _foundToDo = [];
class Home extends StatefulWidget {
  
   const Home({super.key});
   
  
  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  @override 
void initState(){
  _foundToDo = todoslist;
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                SearchBox(
                  onTextChanged: _runFilter,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Text('All ToDos', style: TextStyle(fontSize:30, fontWeight: FontWeight.w500)),
                      ),
          
                      for (ToDo todoo in _foundToDo) 
                        TodoItem(
                          todo: todoo,
                          onTodoChange: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem
                        
                        ),
                      
                      
          
                    ],
                    
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                    )],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Add a new todo item',
                      border: InputBorder.none
                    ),
                    controller: _todoController,
                  )
                ),
                 
                ),
                
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(child:Text('+', style: TextStyle(fontSize: 40, color: Colors.white),) ,
                  onPressed: (){
                    _addToDo(_todoController.text);
                  },
                    style: ElevatedButton.styleFrom(
                    backgroundColor: tdBlue,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.circular(4)

                    )
                  ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoChange (ToDo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
    
  }

  void _deleteToDoItem (String id){
    setState(() {
      todoslist.removeWhere((item) => item.id == id);
    });
  }

  void _addToDo (String toDo){
    setState(() {
      todoslist.add(ToDo(id: DateTime.fromMillisecondsSinceEpoch.toString(), todoText: toDo));
    });
    _todoController.clear();
  }

  void _runFilter (String enteredKeyword){
    List<ToDo> results = [];
    if(enteredKeyword.isEmpty){
      results = todoslist;
    }else{
      results = todoslist.where((item) => item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }
  
  

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),

          Container(
            width: 40,
            height: 40,
           
            
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatar.jpeg'),
            )
            
           
          ),
         
        ],
      ),
  );
  }
}

class SearchBox extends StatelessWidget {
  final Function(String) onTextChanged; // Define callback function
  const SearchBox({
    Key? key,
    required this.onTextChanged, // Accept the callback function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration( color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          onChanged: onTextChanged,
          // onChanged: (value)=>_runFilter(value),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
            prefixIconConstraints: BoxConstraints(maxHeight: 25, maxWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: tdGrey)
          ),
        ),
      ),
    );
  }
}