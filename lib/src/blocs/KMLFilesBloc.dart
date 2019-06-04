import 'package:bloc/bloc.dart';
import 'package:lg_controller/src/gdrive/FileRequests.dart';
import 'package:lg_controller/src/models/KMLData.dart';
import 'package:lg_controller/src/states_events/KMLFilesActions.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class KMLFilesBloc extends Bloc<KMLFilesEvent, KMLFilesState> {
  @override
  KMLFilesState get initialState => UninitializedState();
  final fileRequests = FileRequests();

  @override
  Stream<KMLFilesState> mapEventToState(KMLFilesEvent event) async* {
    if (event is GET_FILES) {
      yield LoadingState();
      List<KMLData> data = await getData();
      if (data != null) {
        yield LoadedState(data);
      }
      data = await fileRequests.getPOIFiles();
      if (data != null) {
        yield LoadedState(data);
        saveData(data);
      }
    }
  }

  Future<void> saveData(List<KMLData> data) async {
    final Database db = await createDatabase();
    for (var mod in data) {
      await db.insert(
        'modules',
        mod.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<Database> createDatabase() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'modules_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE modules(id INTEGER PRIMARY KEY, title TEXT UNIQUE, desc TEXT UNIQUE)",
        );
      },
      version: 1,
    );
    return database;
  }

  Future<List<KMLData>> getData() async {
    final Database db = await createDatabase();
    final List<Map<String, dynamic>> maps = await db.query('modules');
    if (maps == null) return [];
    return List.generate(maps.length, (i) {
      return KMLData(maps[i]['title'], maps[i]['desc']);
    });
  }
}