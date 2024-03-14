class Todo {
  int? id;
  String name;
  String description;
  String completeBy;
  int priority;

  Todo({this.id, required this.name, required this.description, required this.completeBy, required this.priority});

  // To.do 클래스의 인스턴스를 Map 형태로 변환할 때 사용
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'completeBy': completeBy,
      'priority': priority,
    };
  }

  // Map<String, dynamic> 형태의 데이터를 To.do 클래스의 인스턴스로 변환할 때 사용
  static Todo formMap(Map<String, dynamic> map) {
    return Todo(name: map['name'], description: map['description'], completeBy:map['completeBy'], priority: map['priority']);
  }

}

