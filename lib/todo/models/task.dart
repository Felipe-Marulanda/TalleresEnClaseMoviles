class Task {
  final String id;
  final String title;
  final bool completed;
  final DateTime updatedAt;
  final bool deleted;

  const Task({
    required this.id,
    required this.title,
    this.completed = false,
    required this.updatedAt,
    this.deleted = false,
  });

  // Copy with method for immutability
  Task copyWith({
    String? id,
    String? title,
    bool? completed,
    DateTime? updatedAt,
    bool? deleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
    );
  }

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
      'updatedAt': updatedAt.toIso8601String(),
      'deleted': deleted,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      completed: json['completed'] as bool? ?? false,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deleted: json['deleted'] as bool? ?? false,
    );
  }

  // SQLite serialization
  Map<String, dynamic> toSqlite() {
    return {
      'id': id,
      'title': title,
      'completed': completed ? 1 : 0,
      'updated_at': updatedAt.toIso8601String(),
      'deleted': deleted ? 1 : 0,
    };
  }

  factory Task.fromSqlite(Map<String, dynamic> sqlite) {
    return Task(
      id: sqlite['id'] as String,
      title: sqlite['title'] as String,
      completed: (sqlite['completed'] as int) == 1,
      updatedAt: DateTime.parse(sqlite['updated_at'] as String),
      deleted: (sqlite['deleted'] as int? ?? 0) == 1,
    );
  }

  // API serialization (without internal fields)
  Map<String, dynamic> toApi() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Task.fromApi(Map<String, dynamic> api) {
    return Task(
      id: api['id'] as String,
      title: api['title'] as String,
      completed: api['completed'] as bool? ?? false,
      updatedAt: DateTime.parse(api['updatedAt'] as String),
    );
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, completed: $completed, updatedAt: $updatedAt, deleted: $deleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Task &&
        other.id == id &&
        other.title == title &&
        other.completed == completed &&
        other.updatedAt == updatedAt &&
        other.deleted == deleted;
  }

  @override
  int get hashCode {
    return Object.hash(id, title, completed, updatedAt, deleted);
  }
}