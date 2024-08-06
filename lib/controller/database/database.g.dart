// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CalculatedAreaDao? _calculatedAreaDaoInstance;

  POLocationDao? _poLocationDaoInstance;

  FarmerDao? _farmerDaoInstance;

  SocietyDao? _societyDaoInstance;

  FarmerFromServerDao? _farmerFromServerDaoInstance;

  FarmDao? _farmDaoInstance;

  AssignedFarmDao? _assignedFarmDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CalculatedArea` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date` INTEGER NOT NULL, `title` TEXT NOT NULL, `value` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PoLocation` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `lat` REAL NOT NULL, `lng` REAL NOT NULL, `accuracy` INTEGER NOT NULL, `uid` TEXT NOT NULL, `userid` INTEGER NOT NULL, `inspectionDate` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Farmer` (`uid` TEXT, `agent` TEXT, `submissionDate` TEXT, `currentFarmerPic` BLOB, `fname` TEXT, `lname` TEXT, `phoneNumber` TEXT, `idType` TEXT, `idNumber` TEXT, `idExpiryDate` TEXT, `society` INTEGER, `cocoaFarmNumberCount` TEXT, `certifiedCropsNumber` TEXT, `totalPreviousYearsBagsSoldToGroup` TEXT, `totalPreviousYearHarvestedCocoa` TEXT, `currentYearBagYieldEstimate` TEXT, `status` INTEGER, PRIMARY KEY (`uid`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Farm` (`uid` TEXT, `agent` TEXT, `farmboundary` BLOB, `farmer` INTEGER, `farmArea` REAL, `registrationDate` TEXT, `status` INTEGER, `societyCode` INTEGER, PRIMARY KEY (`uid`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `AssignedFarm` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `farmBoundary` BLOB, `farmername` TEXT, `location` TEXT, `farmReference` TEXT, `farmSize` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Society` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `societyCode` INTEGER, `societyName` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FarmerFromServer` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `farmerFullName` TEXT, `farmerFirstName` TEXT, `farmerLastName` TEXT, `farmerId` INTEGER, `farmerCode` TEXT, `farmerPhoto` TEXT, `idType` TEXT, `idExpiryDate` TEXT, `phoneNumber` TEXT, `societyName` TEXT, `nationalIdNumber` TEXT, `numberOfCocoaFarms` INTEGER, `numberOfCertifiedCrops` INTEGER, `cocoaBagsHarvestedPreviousYear` INTEGER, `cocoaBagsSoldToGroup` INTEGER, `currentYearYieldEstimate` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CalculatedAreaDao get calculatedAreaDao {
    return _calculatedAreaDaoInstance ??=
        _$CalculatedAreaDao(database, changeListener);
  }

  @override
  POLocationDao get poLocationDao {
    return _poLocationDaoInstance ??= _$POLocationDao(database, changeListener);
  }

  @override
  FarmerDao get farmerDao {
    return _farmerDaoInstance ??= _$FarmerDao(database, changeListener);
  }

  @override
  SocietyDao get societyDao {
    return _societyDaoInstance ??= _$SocietyDao(database, changeListener);
  }

  @override
  FarmerFromServerDao get farmerFromServerDao {
    return _farmerFromServerDaoInstance ??=
        _$FarmerFromServerDao(database, changeListener);
  }

  @override
  FarmDao get farmDao {
    return _farmDaoInstance ??= _$FarmDao(database, changeListener);
  }

  @override
  AssignedFarmDao get assignedFarmDao {
    return _assignedFarmDaoInstance ??=
        _$AssignedFarmDao(database, changeListener);
  }
}

class _$CalculatedAreaDao extends CalculatedAreaDao {
  _$CalculatedAreaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _calculatedAreaInsertionAdapter = InsertionAdapter(
            database,
            'CalculatedArea',
            (CalculatedArea item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'title': item.title,
                  'value': item.value
                },
            changeListener),
        _calculatedAreaDeletionAdapter = DeletionAdapter(
            database,
            'CalculatedArea',
            ['id'],
            (CalculatedArea item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'title': item.title,
                  'value': item.value
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CalculatedArea> _calculatedAreaInsertionAdapter;

  final DeletionAdapter<CalculatedArea> _calculatedAreaDeletionAdapter;

  @override
  Stream<List<CalculatedArea>> findAllCalculatedAreaStream() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM CalculatedArea ORDER BY date',
        mapper: (Map<String, Object?> row) => CalculatedArea(
            id: row['id'] as int?,
            date: _dateTimeConverter.decode(row['date'] as int),
            title: row['title'] as String,
            value: row['value'] as String),
        queryableName: 'CalculatedArea',
        isView: false);
  }

  @override
  Future<List<CalculatedArea>> findAllCalculatedArea() async {
    return _queryAdapter.queryList('SELECT * FROM CalculatedArea ORDER BY date',
        mapper: (Map<String, Object?> row) => CalculatedArea(
            id: row['id'] as int?,
            date: _dateTimeConverter.decode(row['date'] as int),
            title: row['title'] as String,
            value: row['value'] as String));
  }

  @override
  Future<void> deleteAllCalculatedArea() async {
    await _queryAdapter.queryNoReturn('DELETE FROM CalculatedArea');
  }

  @override
  Future<void> insertCalculatedArea(CalculatedArea calculatedArea) async {
    await _calculatedAreaInsertionAdapter.insert(
        calculatedArea, OnConflictStrategy.replace);
  }

  @override
  Future<int> deleteCalculatedArea(CalculatedArea calculatedArea) {
    return _calculatedAreaDeletionAdapter
        .deleteAndReturnChangedRows(calculatedArea);
  }
}

class _$POLocationDao extends POLocationDao {
  _$POLocationDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _poLocationInsertionAdapter = InsertionAdapter(
            database,
            'PoLocation',
            (PoLocation item) => <String, Object?>{
                  'id': item.id,
                  'lat': item.lat,
                  'lng': item.lng,
                  'accuracy': item.accuracy,
                  'uid': item.uid,
                  'userid': item.userid,
                  'inspectionDate':
                      _dateTimeConverter.encode(item.inspectionDate)
                },
            changeListener),
        _poLocationDeletionAdapter = DeletionAdapter(
            database,
            'PoLocation',
            ['id'],
            (PoLocation item) => <String, Object?>{
                  'id': item.id,
                  'lat': item.lat,
                  'lng': item.lng,
                  'accuracy': item.accuracy,
                  'uid': item.uid,
                  'userid': item.userid,
                  'inspectionDate':
                      _dateTimeConverter.encode(item.inspectionDate)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PoLocation> _poLocationInsertionAdapter;

  final DeletionAdapter<PoLocation> _poLocationDeletionAdapter;

  @override
  Stream<List<PoLocation>> findAllPOLocationStream() {
    return _queryAdapter.queryListStream('SELECT * FROM PoLocation',
        mapper: (Map<String, Object?> row) => PoLocation(
            id: row['id'] as int?,
            lat: row['lat'] as double,
            lng: row['lng'] as double,
            accuracy: row['accuracy'] as int,
            uid: row['uid'] as String,
            userid: row['userid'] as int,
            inspectionDate:
                _dateTimeConverter.decode(row['inspectionDate'] as int)),
        queryableName: 'PoLocation',
        isView: false);
  }

  @override
  Future<List<PoLocation>> findAllPOLocations() async {
    return _queryAdapter.queryList('SELECT * FROM PoLocation',
        mapper: (Map<String, Object?> row) => PoLocation(
            id: row['id'] as int?,
            lat: row['lat'] as double,
            lng: row['lng'] as double,
            accuracy: row['accuracy'] as int,
            uid: row['uid'] as String,
            userid: row['userid'] as int,
            inspectionDate:
                _dateTimeConverter.decode(row['inspectionDate'] as int)));
  }

  @override
  Future<List<PoLocation>> findPoLocationWithLimit(
    int limit,
    int offset,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM PoLocation LIMIT ?1 OFFSET ?2',
        mapper: (Map<String, Object?> row) => PoLocation(
            id: row['id'] as int?,
            lat: row['lat'] as double,
            lng: row['lng'] as double,
            accuracy: row['accuracy'] as int,
            uid: row['uid'] as String,
            userid: row['userid'] as int,
            inspectionDate:
                _dateTimeConverter.decode(row['inspectionDate'] as int)),
        arguments: [limit, offset]);
  }

  @override
  Future<void> deleteAllPOLocation() async {
    await _queryAdapter.queryNoReturn('DELETE FROM PoLocation');
  }

  @override
  Future<void> insertPOLocation(PoLocation poLocation) async {
    await _poLocationInsertionAdapter.insert(
        poLocation, OnConflictStrategy.replace);
  }

  @override
  Future<int> deletePOLocation(PoLocation poLocation) {
    return _poLocationDeletionAdapter.deleteAndReturnChangedRows(poLocation);
  }
}

class _$FarmerDao extends FarmerDao {
  _$FarmerDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _farmerInsertionAdapter = InsertionAdapter(
            database,
            'Farmer',
            (Farmer item) => <String, Object?>{
                  'uid': item.uid,
                  'agent': item.agent,
                  'submissionDate': item.submissionDate,
                  'currentFarmerPic': item.currentFarmerPic,
                  'fname': item.firstName,
                  'lname': item.lastName,
                  'phoneNumber': item.phoneNumber,
                  'idType': item.idType,
                  'idNumber': item.idNumber,
                  'idExpiryDate': item.idExpiryDate,
                  'society': item.society,
                  'cocoaFarmNumberCount': item.cocoaFarmNumberCount,
                  'certifiedCropsNumber': item.certifiedCropsNumber,
                  'totalPreviousYearsBagsSoldToGroup':
                      item.totalPreviousYearsBagsSoldToGroup,
                  'totalPreviousYearHarvestedCocoa':
                      item.totalPreviousYearHarvestedCocoa,
                  'currentYearBagYieldEstimate':
                      item.currentYearBagYieldEstimate,
                  'status': item.status
                },
            changeListener),
        _farmerUpdateAdapter = UpdateAdapter(
            database,
            'Farmer',
            ['uid'],
            (Farmer item) => <String, Object?>{
                  'uid': item.uid,
                  'agent': item.agent,
                  'submissionDate': item.submissionDate,
                  'currentFarmerPic': item.currentFarmerPic,
                  'fname': item.firstName,
                  'lname': item.lastName,
                  'phoneNumber': item.phoneNumber,
                  'idType': item.idType,
                  'idNumber': item.idNumber,
                  'idExpiryDate': item.idExpiryDate,
                  'society': item.society,
                  'cocoaFarmNumberCount': item.cocoaFarmNumberCount,
                  'certifiedCropsNumber': item.certifiedCropsNumber,
                  'totalPreviousYearsBagsSoldToGroup':
                      item.totalPreviousYearsBagsSoldToGroup,
                  'totalPreviousYearHarvestedCocoa':
                      item.totalPreviousYearHarvestedCocoa,
                  'currentYearBagYieldEstimate':
                      item.currentYearBagYieldEstimate,
                  'status': item.status
                },
            changeListener),
        _farmerDeletionAdapter = DeletionAdapter(
            database,
            'Farmer',
            ['uid'],
            (Farmer item) => <String, Object?>{
                  'uid': item.uid,
                  'agent': item.agent,
                  'submissionDate': item.submissionDate,
                  'currentFarmerPic': item.currentFarmerPic,
                  'fname': item.firstName,
                  'lname': item.lastName,
                  'phoneNumber': item.phoneNumber,
                  'idType': item.idType,
                  'idNumber': item.idNumber,
                  'idExpiryDate': item.idExpiryDate,
                  'society': item.society,
                  'cocoaFarmNumberCount': item.cocoaFarmNumberCount,
                  'certifiedCropsNumber': item.certifiedCropsNumber,
                  'totalPreviousYearsBagsSoldToGroup':
                      item.totalPreviousYearsBagsSoldToGroup,
                  'totalPreviousYearHarvestedCocoa':
                      item.totalPreviousYearHarvestedCocoa,
                  'currentYearBagYieldEstimate':
                      item.currentYearBagYieldEstimate,
                  'status': item.status
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Farmer> _farmerInsertionAdapter;

  final UpdateAdapter<Farmer> _farmerUpdateAdapter;

  final DeletionAdapter<Farmer> _farmerDeletionAdapter;

  @override
  Stream<List<Farmer>> findAllFarmerStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Farmer',
        mapper: (Map<String, Object?> row) => Farmer(
            uid: row['uid'] as String?,
            agent: row['agent'] as String?,
            submissionDate: row['submissionDate'] as String?,
            currentFarmerPic: row['currentFarmerPic'] as Uint8List?,
            firstName: row['fname'] as String?,
            lastName: row['lname'] as String?,
            phoneNumber: row['phoneNumber'] as String?,
            idType: row['idType'] as String?,
            idNumber: row['idNumber'] as String?,
            idExpiryDate: row['idExpiryDate'] as String?,
            society: row['society'] as int?,
            cocoaFarmNumberCount: row['cocoaFarmNumberCount'] as String?,
            certifiedCropsNumber: row['certifiedCropsNumber'] as String?,
            totalPreviousYearsBagsSoldToGroup:
                row['totalPreviousYearsBagsSoldToGroup'] as String?,
            totalPreviousYearHarvestedCocoa:
                row['totalPreviousYearHarvestedCocoa'] as String?,
            currentYearBagYieldEstimate:
                row['currentYearBagYieldEstimate'] as String?,
            status: row['status'] as int?),
        queryableName: 'Farmer',
        isView: false);
  }

  @override
  Future<List<Farmer>> findAllFarmer() async {
    return _queryAdapter.queryList('SELECT * FROM Farmer',
        mapper: (Map<String, Object?> row) => Farmer(
            uid: row['uid'] as String?,
            agent: row['agent'] as String?,
            submissionDate: row['submissionDate'] as String?,
            currentFarmerPic: row['currentFarmerPic'] as Uint8List?,
            firstName: row['fname'] as String?,
            lastName: row['lname'] as String?,
            phoneNumber: row['phoneNumber'] as String?,
            idType: row['idType'] as String?,
            idNumber: row['idNumber'] as String?,
            idExpiryDate: row['idExpiryDate'] as String?,
            society: row['society'] as int?,
            cocoaFarmNumberCount: row['cocoaFarmNumberCount'] as String?,
            certifiedCropsNumber: row['certifiedCropsNumber'] as String?,
            totalPreviousYearsBagsSoldToGroup:
                row['totalPreviousYearsBagsSoldToGroup'] as String?,
            totalPreviousYearHarvestedCocoa:
                row['totalPreviousYearHarvestedCocoa'] as String?,
            currentYearBagYieldEstimate:
                row['currentYearBagYieldEstimate'] as String?,
            status: row['status'] as int?));
  }

  @override
  Future<List<Farmer>> findFarmerWithLimit(
    int limit,
    int offset,
  ) async {
    return _queryAdapter.queryList('SELECT * FROM Farmer LIMIT ?1 OFFSET ?2',
        mapper: (Map<String, Object?> row) => Farmer(
            uid: row['uid'] as String?,
            agent: row['agent'] as String?,
            submissionDate: row['submissionDate'] as String?,
            currentFarmerPic: row['currentFarmerPic'] as Uint8List?,
            firstName: row['fname'] as String?,
            lastName: row['lname'] as String?,
            phoneNumber: row['phoneNumber'] as String?,
            idType: row['idType'] as String?,
            idNumber: row['idNumber'] as String?,
            idExpiryDate: row['idExpiryDate'] as String?,
            society: row['society'] as int?,
            cocoaFarmNumberCount: row['cocoaFarmNumberCount'] as String?,
            certifiedCropsNumber: row['certifiedCropsNumber'] as String?,
            totalPreviousYearsBagsSoldToGroup:
                row['totalPreviousYearsBagsSoldToGroup'] as String?,
            totalPreviousYearHarvestedCocoa:
                row['totalPreviousYearHarvestedCocoa'] as String?,
            currentYearBagYieldEstimate:
                row['currentYearBagYieldEstimate'] as String?,
            status: row['status'] as int?),
        arguments: [limit, offset]);
  }

  @override
  Stream<List<Farmer>> findFarmerByStatusStream(int status) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Farmer WHERE status = ?1',
        mapper: (Map<String, Object?> row) => Farmer(
            uid: row['uid'] as String?,
            agent: row['agent'] as String?,
            submissionDate: row['submissionDate'] as String?,
            currentFarmerPic: row['currentFarmerPic'] as Uint8List?,
            firstName: row['fname'] as String?,
            lastName: row['lname'] as String?,
            phoneNumber: row['phoneNumber'] as String?,
            idType: row['idType'] as String?,
            idNumber: row['idNumber'] as String?,
            idExpiryDate: row['idExpiryDate'] as String?,
            society: row['society'] as int?,
            cocoaFarmNumberCount: row['cocoaFarmNumberCount'] as String?,
            certifiedCropsNumber: row['certifiedCropsNumber'] as String?,
            totalPreviousYearsBagsSoldToGroup:
                row['totalPreviousYearsBagsSoldToGroup'] as String?,
            totalPreviousYearHarvestedCocoa:
                row['totalPreviousYearHarvestedCocoa'] as String?,
            currentYearBagYieldEstimate:
                row['currentYearBagYieldEstimate'] as String?,
            status: row['status'] as int?),
        arguments: [status],
        queryableName: 'Farmer',
        isView: false);
  }

  @override
  Future<List<Farmer>> findFarmerByStatus(int status) async {
    return _queryAdapter.queryList('SELECT * FROM Farmer WHERE status = ?1',
        mapper: (Map<String, Object?> row) => Farmer(
            uid: row['uid'] as String?,
            agent: row['agent'] as String?,
            submissionDate: row['submissionDate'] as String?,
            currentFarmerPic: row['currentFarmerPic'] as Uint8List?,
            firstName: row['fname'] as String?,
            lastName: row['lname'] as String?,
            phoneNumber: row['phoneNumber'] as String?,
            idType: row['idType'] as String?,
            idNumber: row['idNumber'] as String?,
            idExpiryDate: row['idExpiryDate'] as String?,
            society: row['society'] as int?,
            cocoaFarmNumberCount: row['cocoaFarmNumberCount'] as String?,
            certifiedCropsNumber: row['certifiedCropsNumber'] as String?,
            totalPreviousYearsBagsSoldToGroup:
                row['totalPreviousYearsBagsSoldToGroup'] as String?,
            totalPreviousYearHarvestedCocoa:
                row['totalPreviousYearHarvestedCocoa'] as String?,
            currentYearBagYieldEstimate:
                row['currentYearBagYieldEstimate'] as String?,
            status: row['status'] as int?),
        arguments: [status]);
  }

  @override
  Future<List<Farmer>> findFarmerByStatusWithLimit(
    int status,
    int limit,
    int offset,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Farmer WHERE status = ?1 LIMIT ?2 OFFSET ?3',
        mapper: (Map<String, Object?> row) => Farmer(
            uid: row['uid'] as String?,
            agent: row['agent'] as String?,
            submissionDate: row['submissionDate'] as String?,
            currentFarmerPic: row['currentFarmerPic'] as Uint8List?,
            firstName: row['fname'] as String?,
            lastName: row['lname'] as String?,
            phoneNumber: row['phoneNumber'] as String?,
            idType: row['idType'] as String?,
            idNumber: row['idNumber'] as String?,
            idExpiryDate: row['idExpiryDate'] as String?,
            society: row['society'] as int?,
            cocoaFarmNumberCount: row['cocoaFarmNumberCount'] as String?,
            certifiedCropsNumber: row['certifiedCropsNumber'] as String?,
            totalPreviousYearsBagsSoldToGroup:
                row['totalPreviousYearsBagsSoldToGroup'] as String?,
            totalPreviousYearHarvestedCocoa:
                row['totalPreviousYearHarvestedCocoa'] as String?,
            currentYearBagYieldEstimate:
                row['currentYearBagYieldEstimate'] as String?,
            status: row['status'] as int?),
        arguments: [status, limit, offset]);
  }

  @override
  Future<List<Farmer>> findFarmerByUID(String id) async {
    return _queryAdapter.queryList('SELECT * FROM Farmer WHERE uid = ?1',
        mapper: (Map<String, Object?> row) => Farmer(
            uid: row['uid'] as String?,
            agent: row['agent'] as String?,
            submissionDate: row['submissionDate'] as String?,
            currentFarmerPic: row['currentFarmerPic'] as Uint8List?,
            firstName: row['fname'] as String?,
            lastName: row['lname'] as String?,
            phoneNumber: row['phoneNumber'] as String?,
            idType: row['idType'] as String?,
            idNumber: row['idNumber'] as String?,
            idExpiryDate: row['idExpiryDate'] as String?,
            society: row['society'] as int?,
            cocoaFarmNumberCount: row['cocoaFarmNumberCount'] as String?,
            certifiedCropsNumber: row['certifiedCropsNumber'] as String?,
            totalPreviousYearsBagsSoldToGroup:
                row['totalPreviousYearsBagsSoldToGroup'] as String?,
            totalPreviousYearHarvestedCocoa:
                row['totalPreviousYearHarvestedCocoa'] as String?,
            currentYearBagYieldEstimate:
                row['currentYearBagYieldEstimate'] as String?,
            status: row['status'] as int?),
        arguments: [id]);
  }

  @override
  Future<int?> deletePeFarmerUID(String id) async {
    return _queryAdapter.query('DELETE FROM Farmer WHERE uid = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [id]);
  }

  @override
  Future<void> deleteAllFarmers() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Farmer');
  }

  @override
  Future<int?> updateFarmerSubmissionStatusByUID(
    int status,
    String id,
  ) async {
    return _queryAdapter.query('UPDATE Farmer SET status = ?1 WHERE uid = ?2',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [status, id]);
  }

  @override
  Future<void> insertFarmer(Farmer farmer) async {
    await _farmerInsertionAdapter.insert(farmer, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> bulkInsertFarmer(List<Farmer> farmerList) {
    return _farmerInsertionAdapter.insertListAndReturnIds(
        farmerList, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateFarmer(Farmer farmer) async {
    await _farmerUpdateAdapter.update(farmer, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteFarmer(Farmer farmer) {
    return _farmerDeletionAdapter.deleteAndReturnChangedRows(farmer);
  }
}

class _$AssignedFarmDao extends AssignedFarmDao {
  _$AssignedFarmDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _assignedFarmInsertionAdapter = InsertionAdapter(
            database,
            'AssignedFarm',
            (AssignedFarm item) => <String, Object?>{
                  'id': item.id,
                  'farmBoundary': item.farmBoundary,
                  'farmername': item.farmername,
                  'location': item.location,
                  'farmReference': item.farmReference,
                  'farmSize': item.farmSize
                },
            changeListener),
        _assignedFarmDeletionAdapter = DeletionAdapter(
            database,
            'AssignedFarm',
            ['id'],
            (AssignedFarm item) => <String, Object?>{
                  'id': item.id,
                  'farmBoundary': item.farmBoundary,
                  'farmername': item.farmername,
                  'location': item.location,
                  'farmReference': item.farmReference,
                  'farmSize': item.farmSize
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AssignedFarm> _assignedFarmInsertionAdapter;

  final DeletionAdapter<AssignedFarm> _assignedFarmDeletionAdapter;

  @override
  Stream<List<AssignedFarm>> findAllAssignedFarmsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM AssignedFarm',
        mapper: (Map<String, Object?> row) => AssignedFarm(
            id: row['id'] as int?,
            farmBoundary: row['farmBoundary'] as Uint8List?,
            farmername: row['farmername'] as String?,
            location: row['location'] as String?,
            farmReference: row['farmReference'] as String?,
            farmSize: row['farmSize'] as String?),
        queryableName: 'AssignedFarm',
        isView: false);
  }

  @override
  Future<List<AssignedFarm>> findAllAssignedFarms() async {
    return _queryAdapter
        .queryList('SELECT * FROM AssignedFarm',
            mapper: (Map<String, Object?> row) => AssignedFarm(
                id: row['id'] as int?,
                farmBoundary: row['farmBoundary'] as Uint8List?,
                farmername: row['farmername'] as String?,
                location: row['location'] as String?,
                farmReference: row['farmReference'] as String?,
                farmSize: row['farmSize'] as String?))
        .onError((error, stackTrace) {
      // FirebaseCrashlytics.instance.recordError(error, stackTrace);
      // FirebaseCrashlytics.instance.log('findAllAssignedFarms');

      throw "assgined farms erros";
    });
  }

  @override
  Future<List<AssignedFarm>> findAssignedFarmWithLimit(
    int limit,
    int offset,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM AssignedFarm LIMIT ?1 OFFSET ?2',
        mapper: (Map<String, Object?> row) => AssignedFarm(
            id: row['id'] as int?,
            farmBoundary: row['farmBoundary'] as Uint8List?,
            farmername: row['farmername'] as String?,
            location: row['location'] as String?,
            farmReference: row['farmReference'] as String?,
            farmSize: row['farmSize'] as String?),
        arguments: [limit, offset]);
  }

  @override
  Future<List<AssignedFarm>> findAssignedFarmsByFarmRef(String ref) async {
    return _queryAdapter.queryList(
        'SELECT * FROM AssignedFarm WHERE farmReference = ?1',
        mapper: (Map<String, Object?> row) => AssignedFarm(
            id: row['id'] as int?,
            farmBoundary: row['farmBoundary'] as Uint8List?,
            farmername: row['farmername'] as String?,
            location: row['location'] as String?,
            farmReference: row['farmReference'] as String?,
            farmSize: row['farmSize'] as String?),
        arguments: [ref]);
  }

  @override
  Future<void> deleteAllAssignedFarms() async {
    await _queryAdapter.queryNoReturn('DELETE FROM AssignedFarm');
  }

  @override
  Future<void> insertAssignedFarms(AssignedFarm assignedFarm) async {
    await _assignedFarmInsertionAdapter.insert(
        assignedFarm, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> bulkInsertAssignedFarms(
      List<AssignedFarm> assignedFarmList) {
    return _assignedFarmInsertionAdapter.insertListAndReturnIds(
        assignedFarmList, OnConflictStrategy.replace);
  }

  @override
  Future<int> deleteAssignedFarms(AssignedFarm assignedFarm) {
    return _assignedFarmDeletionAdapter
        .deleteAndReturnChangedRows(assignedFarm);
  }
}

class _$SocietyDao extends SocietyDao {
  _$SocietyDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _societyInsertionAdapter = InsertionAdapter(
            database,
            'Society',
            (Society item) => <String, Object?>{
                  'id': item.id,
                  'societyCode': item.societyCode,
                  'societyName': item.societyName
                }),
        _societyDeletionAdapter = DeletionAdapter(
            database,
            'Society',
            ['id'],
            (Society item) => <String, Object?>{
                  'id': item.id,
                  'societyCode': item.societyCode,
                  'societyName': item.societyName
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Society> _societyInsertionAdapter;

  final DeletionAdapter<Society> _societyDeletionAdapter;

  @override
  Future<List<Society>> findAllSociety() async {
    return _queryAdapter.queryList('SELECT * FROM Society',
        mapper: (Map<String, Object?> row) => Society(
            id: row['id'] as int?,
            societyCode: row['societyCode'] as int?,
            societyName: row['societyName'] as String?));
  }

  @override
  Future<List<Society>> findSocietyBySocietyName(String societyName) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Society WHERE societyName = ?1',
        mapper: (Map<String, Object?> row) => Society(
            id: row['id'] as int?,
            societyCode: row['societyCode'] as int?,
            societyName: row['societyName'] as String?),
        arguments: [societyName]);
  }

  @override
  Future<List<Society>> findSocietyBySocietyCode(int societyCode) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Society WHERE societyCode = ?1',
        mapper: (Map<String, Object?> row) => Society(
            id: row['id'] as int?,
            societyCode: row['societyCode'] as int?,
            societyName: row['societyName'] as String?),
        arguments: [societyCode]);
  }

  @override
  Future<void> deleteAllSociety() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Society');
  }

  @override
  Future<void> insertSociety(Society society) async {
    await _societyInsertionAdapter.insert(society, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> bulkInsertSociety(List<Society> societyList) {
    return _societyInsertionAdapter.insertListAndReturnIds(
        societyList, OnConflictStrategy.replace);
  }

  @override
  Future<int> deleteSociety(Society society) {
    return _societyDeletionAdapter.deleteAndReturnChangedRows(society);
  }
}

class _$FarmerFromServerDao extends FarmerFromServerDao {
  _$FarmerFromServerDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _farmerFromServerInsertionAdapter = InsertionAdapter(
            database,
            'FarmerFromServer',
            (FarmerFromServer item) => <String, Object?>{
                  'id': item.id,
                  'farmerFullName': item.farmerFullName,
                  'farmerFirstName': item.farmerFirstName,
                  'farmerLastName': item.farmerLastName,
                  'farmerId': item.farmerId,
                  'farmerCode': item.farmerCode,
                  'phoneNumber': item.phoneNumber,
                  'societyName': item.societyName,
                  'nationalIdNumber': item.nationalIdNumber,
                  'numberOfCocoaFarms': item.numberOfCocoaFarms,
                  'numberOfCertifiedCrops': item.numberOfCertifiedCrops,
                  'cocoaBagsHarvestedPreviousYear':
                      item.cocoaBagsHarvestedPreviousYear,
                  'cocoaBagsSoldToGroup': item.cocoaBagsSoldToGroup,
                  'currentYearYieldEstimate': item.currentYearYieldEstimate,
                  'farmerPhoto': item.farmerPhoto,
                  'idType': item.idType,
                  'idExpiryDate': item.idExpiryDate,
                },
            changeListener),
        _farmerFromServerDeletionAdapter = DeletionAdapter(
            database,
            'FarmerFromServer',
            ['id'],
            (FarmerFromServer item) => <String, Object?>{
                  'id': item.id,
                  'farmerFullName': item.farmerFullName,
                  'farmerFirstName': item.farmerFirstName,
                  'farmerLastName': item.farmerLastName,
                  'farmerId': item.farmerId,
                  'farmerCode': item.farmerCode,
                  'phoneNumber': item.phoneNumber,
                  'societyName': item.societyName,
                  'nationalIdNumber': item.nationalIdNumber,
                  'numberOfCocoaFarms': item.numberOfCocoaFarms,
                  'numberOfCertifiedCrops': item.numberOfCertifiedCrops,
                  'cocoaBagsHarvestedPreviousYear':
                      item.cocoaBagsHarvestedPreviousYear,
                  'cocoaBagsSoldToGroup': item.cocoaBagsSoldToGroup,
                  'currentYearYieldEstimate': item.currentYearYieldEstimate,
                  'farmerPhoto': item.farmerPhoto,
                  'idType': item.idType,
                  'idExpiryDate': item.idExpiryDate,
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FarmerFromServer> _farmerFromServerInsertionAdapter;

  final DeletionAdapter<FarmerFromServer> _farmerFromServerDeletionAdapter;

  @override
  Stream<List<FarmerFromServer>> findAllFarmersFromServerStream() {
    return _queryAdapter.queryListStream('SELECT * FROM FarmerFromServer',
        mapper: (Map<String, Object?> row) => FarmerFromServer(
              id: row['id'] as int?,
              farmerFullName: row['farmerFullName'] as String?,
              farmerFirstName: row['farmerFirstName'] as String?,
              farmerLastName: row['farmerLastName'] as String?,
              farmerId: row['farmerId'] as int?,
              farmerCode: row['farmerCode'] as String?,
              phoneNumber: row['phoneNumber'] as String?,
              societyName: row['societyName'] as String?,
              nationalIdNumber: row['nationalIdNumber'] as String?,
              numberOfCocoaFarms: row['numberOfCocoaFarms'] as int?,
              numberOfCertifiedCrops: row['numberOfCertifiedCrops'] as int?,
              cocoaBagsHarvestedPreviousYear:
                  row['cocoaBagsHarvestedPreviousYear'] as int?,
              cocoaBagsSoldToGroup: row['cocoaBagsSoldToGroup'] as int?,
              currentYearYieldEstimate: row['currentYearYieldEstimate'] as int?,
              farmerPhoto: row['farmerPhoto'] as Uint8List?,
              idType: row['idType'] as String?,
              idExpiryDate: row['idExpiryDate'] as String?,
            ),
        queryableName: 'FarmerFromServer',
        isView: false);
  }

  @override
  Stream<List<FarmerFromServer>> streamAllFarmersFromServerWithNamesLike(
      String farmerName) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM FarmerFromServer WHERE LOWER(farmerFullName) LIKE ?1 OR LOWER(farmerCode) LIKE ?1',
        mapper: (Map<String, Object?> row) => FarmerFromServer(
              id: row['id'] as int?,
              farmerFullName: row['farmerFullName'] as String?,
              farmerFirstName: row['farmerFirstName'] as String?,
              farmerLastName: row['farmerLastName'] as String?,
              farmerId: row['farmerId'] as int?,
              farmerCode: row['farmerCode'] as String?,
              phoneNumber: row['phoneNumber'] as String?,
              societyName: row['societyName'] as String?,
              nationalIdNumber: row['nationalIdNumber'] as String?,
              numberOfCocoaFarms: row['numberOfCocoaFarms'] as int?,
              numberOfCertifiedCrops: row['numberOfCertifiedCrops'] as int?,
              cocoaBagsHarvestedPreviousYear:
                  row['cocoaBagsHarvestedPreviousYear'] as int?,
              cocoaBagsSoldToGroup: row['cocoaBagsSoldToGroup'] as int?,
              currentYearYieldEstimate: row['currentYearYieldEstimate'] as int?,
              farmerPhoto: row['farmerPhoto'] as Uint8List?,
              idType: row['idType'] as String?,
              idExpiryDate: row['idExpiryDate'] as String?,
            ),
        arguments: [farmerName],
        queryableName: 'FarmerFromServer',
        isView: false);
  }

  @override
  Future<List<FarmerFromServer>> findAllFarmersFromServer() async {
    return _queryAdapter.queryList('SELECT * FROM FarmerFromServer',
        mapper: (Map<String, Object?> row) => FarmerFromServer(
              id: row['id'] as int?,
              farmerFullName: row['farmerFullName'] as String?,
              farmerFirstName: row['farmerFirstName'] as String?,
              farmerLastName: row['farmerLastName'] as String?,
              farmerId: row['farmerId'] as int?,
              farmerCode: row['farmerCode'] as String?,
              phoneNumber: row['phoneNumber'] as String?,
              societyName: row['societyName'] as String?,
              nationalIdNumber: row['nationalIdNumber'] as String?,
              numberOfCocoaFarms: row['numberOfCocoaFarms'] as int?,
              numberOfCertifiedCrops: row['numberOfCertifiedCrops'] as int?,
              cocoaBagsHarvestedPreviousYear:
                  row['cocoaBagsHarvestedPreviousYear'] as int?,
              cocoaBagsSoldToGroup: row['cocoaBagsSoldToGroup'] as int?,
              currentYearYieldEstimate: row['currentYearYieldEstimate'] as int?,
              farmerPhoto: row['farmerPhoto'] as Uint8List?,
              idType: row['idType'] as String?,
              idExpiryDate: row['idExpiryDate'] as String?,
            ));
  }

  @override
  Future<List<FarmerFromServer>> findFarmersFromServerWithLimit(
    int limit,
    int offset,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM FarmerFromServer LIMIT ?1 OFFSET ?2',
        mapper: (Map<String, Object?> row) => FarmerFromServer(
              id: row['id'] as int?,
              farmerFullName: row['farmerFullName'] as String?,
              farmerFirstName: row['farmerFirstName'] as String?,
              farmerLastName: row['farmerLastName'] as String?,
              farmerId: row['farmerId'] as int?,
              farmerCode: row['farmerCode'] as String?,
              phoneNumber: row['phoneNumber'] as String?,
              societyName: row['societyName'] as String?,
              nationalIdNumber: row['nationalIdNumber'] as String?,
              numberOfCocoaFarms: row['numberOfCocoaFarms'] as int?,
              numberOfCertifiedCrops: row['numberOfCertifiedCrops'] as int?,
              cocoaBagsHarvestedPreviousYear:
                  row['cocoaBagsHarvestedPreviousYear'] as int?,
              cocoaBagsSoldToGroup: row['cocoaBagsSoldToGroup'] as int?,
              currentYearYieldEstimate: row['currentYearYieldEstimate'] as int?,
              farmerPhoto: row['farmerPhoto'] as Uint8List?,
              idType: row['idType'] as String?,
              idExpiryDate: row['idExpiryDate'] as String?,
            ),
        arguments: [limit, offset]);
  }

  @override
  Future<List<FarmerFromServer>> findFarmersFromServerWithSearchAndLimit(
    String searchTerm,
    int limit,
    int offset,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM FarmerFromServer WHERE LOWER(farmerFullName) LIKE ?1 OR LOWER(farmerCode) LIKE ?1 LIMIT ?2 OFFSET ?3',
        mapper: (Map<String, Object?> row) => FarmerFromServer(
              id: row['id'] as int?,
              farmerFullName: row['farmerFullName'] as String?,
              farmerFirstName: row['farmerFirstName'] as String?,
              farmerLastName: row['farmerLastName'] as String?,
              farmerId: row['farmerId'] as int?,
              farmerCode: row['farmerCode'] as String?,
              phoneNumber: row['phoneNumber'] as String?,
              societyName: row['societyName'] as String?,
              nationalIdNumber: row['nationalIdNumber'] as String?,
              numberOfCocoaFarms: row['numberOfCocoaFarms'] as int?,
              numberOfCertifiedCrops: row['numberOfCertifiedCrops'] as int?,
              cocoaBagsHarvestedPreviousYear:
                  row['cocoaBagsHarvestedPreviousYear'] as int?,
              cocoaBagsSoldToGroup: row['cocoaBagsSoldToGroup'] as int?,
              currentYearYieldEstimate: row['currentYearYieldEstimate'] as int?,
              farmerPhoto: row['farmerPhoto'] as Uint8List?,
              idType: row['idType'] as String?,
              idExpiryDate: row['idExpiryDate'] as String?,
            ),
        arguments: [searchTerm, limit, offset]);
  }

  @override
  Future<List<FarmerFromServer>> findFarmersFromServerInSociety(
      String societyName) async {
    return _queryAdapter.queryList(
        'SELECT * FROM FarmerFromServer WHERE societyName = ?1',
        mapper: (Map<String, Object?> row) => FarmerFromServer(
              id: row['id'] as int?,
              farmerFullName: row['farmerFullName'] as String?,
              farmerFirstName: row['farmerFirstName'] as String?,
              farmerLastName: row['farmerLastName'] as String?,
              farmerId: row['farmerId'] as int?,
              farmerCode: row['farmerCode'] as String?,
              phoneNumber: row['phoneNumber'] as String?,
              societyName: row['societyName'] as String?,
              nationalIdNumber: row['nationalIdNumber'] as String?,
              numberOfCocoaFarms: row['numberOfCocoaFarms'] as int?,
              numberOfCertifiedCrops: row['numberOfCertifiedCrops'] as int?,
              cocoaBagsHarvestedPreviousYear:
                  row['cocoaBagsHarvestedPreviousYear'] as int?,
              cocoaBagsSoldToGroup: row['cocoaBagsSoldToGroup'] as int?,
              currentYearYieldEstimate: row['currentYearYieldEstimate'] as int?,
              farmerPhoto: row['farmerPhoto'] as Uint8List?,
              idType: row['idType'] as String?,
              idExpiryDate: row['idExpiryDate'] as String?,
            ),
        arguments: [societyName]);
  }

  @override
  Future<List<FarmerFromServer>> findFarmerFromServerByFarmerId(
      int farmerId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM FarmerFromServer WHERE farmerId = ?1',
        mapper: (Map<String, Object?> row) => FarmerFromServer(
              id: row['id'] as int?,
              farmerFullName: row['farmerFullName'] as String?,
              farmerFirstName: row['farmerFirstName'] as String?,
              farmerLastName: row['farmerLastName'] as String?,
              farmerId: row['farmerId'] as int?,
              farmerCode: row['farmerCode'] as String?,
              phoneNumber: row['phoneNumber'] as String?,
              societyName: row['societyName'] as String?,
              nationalIdNumber: row['nationalIdNumber'] as String?,
              numberOfCocoaFarms: row['numberOfCocoaFarms'] as int?,
              numberOfCertifiedCrops: row['numberOfCertifiedCrops'] as int?,
              cocoaBagsHarvestedPreviousYear:
                  row['cocoaBagsHarvestedPreviousYear'] as int?,
              cocoaBagsSoldToGroup: row['cocoaBagsSoldToGroup'] as int?,
              currentYearYieldEstimate: row['currentYearYieldEstimate'] as int?,
              farmerPhoto: row['farmerPhoto'] as Uint8List?,
              idType: row['idType'] as String?,
              idExpiryDate: row['idExpiryDate'] as String?,
            ),
        arguments: [farmerId]);
  }

  @override
  Future<List<FarmerFromServer>> findFarmersFromServerByFarmerCodes(
      List<int> farmerIds) async {
    const offset = 1;
    final _sqliteVariablesForFarmerIds =
        Iterable<String>.generate(farmerIds.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryList(
        'SELECT * FROM FarmerFromServer WHERE farmerId IN (' +
            _sqliteVariablesForFarmerIds +
            ')',
        mapper: (Map<String, Object?> row) => FarmerFromServer(
              id: row['id'] as int?,
              farmerFullName: row['farmerFullName'] as String?,
              farmerFirstName: row['farmerFirstName'] as String?,
              farmerLastName: row['farmerLastName'] as String?,
              farmerId: row['farmerId'] as int?,
              farmerCode: row['farmerCode'] as String?,
              phoneNumber: row['phoneNumber'] as String?,
              societyName: row['societyName'] as String?,
              nationalIdNumber: row['nationalIdNumber'] as String?,
              numberOfCocoaFarms: row['numberOfCocoaFarms'] as int?,
              numberOfCertifiedCrops: row['numberOfCertifiedCrops'] as int?,
              cocoaBagsHarvestedPreviousYear:
                  row['cocoaBagsHarvestedPreviousYear'] as int?,
              cocoaBagsSoldToGroup: row['cocoaBagsSoldToGroup'] as int?,
              currentYearYieldEstimate: row['currentYearYieldEstimate'] as int?,
              farmerPhoto: row['farmerPhoto'] as Uint8List?,
              idType: row['idType'] as String?,
              idExpiryDate: row['idExpiryDate'] as String?,
            ),
        arguments: [...farmerIds]);
  }

  @override
  Future<List<FarmerFromServer>> findFarmersFromServerById(int farmerId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM FarmerFromServer WHERE farmerId = ?1',
        mapper: (Map<String, Object?> row) => FarmerFromServer(
              id: row['id'] as int?,
              farmerFullName: row['farmerFullName'] as String?,
              farmerFirstName: row['farmerFirstName'] as String?,
              farmerLastName: row['farmerLastName'] as String?,
              farmerId: row['farmerId'] as int?,
              farmerCode: row['farmerCode'] as String?,
              phoneNumber: row['phoneNumber'] as String?,
              societyName: row['societyName'] as String?,
              nationalIdNumber: row['nationalIdNumber'] as String?,
              numberOfCocoaFarms: row['numberOfCocoaFarms'] as int?,
              numberOfCertifiedCrops: row['numberOfCertifiedCrops'] as int?,
              cocoaBagsHarvestedPreviousYear:
                  row['cocoaBagsHarvestedPreviousYear'] as int?,
              cocoaBagsSoldToGroup: row['cocoaBagsSoldToGroup'] as int?,
              currentYearYieldEstimate: row['currentYearYieldEstimate'] as int?,
              farmerPhoto: row['farmerPhoto'] as Uint8List?,
              idType: row['idType'] as String?,
              idExpiryDate: row['idExpiryDate'] as String?,
            ),
        arguments: [farmerId]);
  }

  @override
  Future<int?> deleteFarmersFromServerByFarmerId(int farmerId) async {
    return _queryAdapter.query(
        'DELETE FROM FarmerFromServer WHERE farmerId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [farmerId]);
  }

  @override
  Future<void> deleteAllFarmersFromServer() async {
    await _queryAdapter.queryNoReturn('DELETE FROM FarmerFromServer');
  }

  @override
  Future<void> insertFarmerFromServer(FarmerFromServer farmerFromServer) async {
    await _farmerFromServerInsertionAdapter.insert(
        farmerFromServer, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> bulkInsertFarmersFromServer(
      List<FarmerFromServer> farmerFromServerList) {
    return _farmerFromServerInsertionAdapter.insertListAndReturnIds(
        farmerFromServerList, OnConflictStrategy.replace);
  }

  @override
  Future<int> deleteFarmerFromServer(FarmerFromServer farmerFromServer) {
    return _farmerFromServerDeletionAdapter
        .deleteAndReturnChangedRows(farmerFromServer);
  }
}

class _$FarmDao extends FarmDao {
  _$FarmDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _farmInsertionAdapter = InsertionAdapter(
            database,
            'Farm',
            (Farm item) => <String, Object?>{
                  'uid': item.uid,
                  'agent': item.agent,
                  'farmboundary': item.farmboundary,
                  'farmer': item.farmer,
                  'farmArea': item.farmArea,
                  'registrationDate': item.registrationDate,
                  'status': item.status,
                  'societyCode': item.societyCode
                },
            changeListener),
        _farmUpdateAdapter = UpdateAdapter(
            database,
            'Farm',
            ['uid'],
            (Farm item) => <String, Object?>{
                  'uid': item.uid,
                  'agent': item.agent,
                  'farmboundary': item.farmboundary,
                  'farmer': item.farmer,
                  'farmArea': item.farmArea,
                  'registrationDate': item.registrationDate,
                  'status': item.status,
                  'societyCode': item.societyCode
                },
            changeListener),
        _farmDeletionAdapter = DeletionAdapter(
            database,
            'Farm',
            ['uid'],
            (Farm item) => <String, Object?>{
                  'uid': item.uid,
                  'agent': item.agent,
                  'farmboundary': item.farmboundary,
                  'farmer': item.farmer,
                  'farmArea': item.farmArea,
                  'registrationDate': item.registrationDate,
                  'status': item.status,
                  'societyCode': item.societyCode
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Farm> _farmInsertionAdapter;

  final UpdateAdapter<Farm> _farmUpdateAdapter;

  final DeletionAdapter<Farm> _farmDeletionAdapter;

  @override
  Stream<List<Farm>> findAllFarmStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Farm',
        mapper: (Map<String, Object?> row) => Farm(
            uid: row['uid'] as String?,
            agent: row['agent'] as String?,
            farmboundary: row['farmboundary'] as Uint8List?,
            farmer: row['farmer'] as int?,
            farmArea: row['farmArea'] as double?,
            registrationDate: row['registrationDate'] as String?,
            status: row['status'] as int?,
            societyCode: row['societyCode'] as int?),
        queryableName: 'Farm',
        isView: false);
  }

  @override
  Future<List<Farm>> findAllFarm() async {
    return _queryAdapter.queryList('SELECT * FROM Farm',
        mapper: (Map<String, Object?> row) => Farm(
            uid: row['uid'] as String?,
            agent: row['agent'] as String?,
            farmboundary: row['farmboundary'] as Uint8List?,
            farmer: row['farmer'] as int?,
            farmArea: row['farmArea'] as double?,
            registrationDate: row['registrationDate'] as String?,
            status: row['status'] as int?,
            societyCode: row['societyCode'] as int?));
  }

  @override
  Stream<List<Farm>> findFarmByStatusStream(int status) {
    return _queryAdapter.queryListStream('SELECT * FROM Farm WHERE status = ?1',
        mapper: (Map<String, Object?> row) => Farm(
            uid: row['uid'] as String?,
            agent: row['agent'] as String?,
            farmboundary: row['farmboundary'] as Uint8List?,
            farmer: row['farmer'] as int?,
            farmArea: row['farmArea'] as double?,
            registrationDate: row['registrationDate'] as String?,
            status: row['status'] as int?,
            societyCode: row['societyCode'] as int?),
        arguments: [status],
        queryableName: 'Farm',
        isView: false);
  }

  @override
  Future<List<Farm>> findFarmByStatusWithLimit(
    int status,
    int limit,
    int offset,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Farm WHERE status = ?1 LIMIT ?2 OFFSET ?3',
        mapper: (Map<String, Object?> row) => Farm(
            uid: row['uid'] as String?,
            agent: row['agent'] as String?,
            farmboundary: row['farmboundary'] as Uint8List?,
            farmer: row['farmer'] as int?,
            farmArea: row['farmArea'] as double?,
            registrationDate: row['registrationDate'] as String?,
            status: row['status'] as int?,
            societyCode: row['societyCode'] as int?),
        arguments: [status, limit, offset]);
  }

  @override
  Future<List<Farm>> findFarmByStatus(int status) async {
    return _queryAdapter.queryList('SELECT * FROM Farm WHERE status = ?1',
        mapper: (Map<String, Object?> row) => Farm(
            uid: row['uid'] as String?,
            agent: row['agent'] as String?,
            farmboundary: row['farmboundary'] as Uint8List?,
            farmer: row['farmer'] as int?,
            farmArea: row['farmArea'] as double?,
            registrationDate: row['registrationDate'] as String?,
            status: row['status'] as int?,
            societyCode: row['societyCode'] as int?),
        arguments: [status]);
  }

  @override
  Future<List<Farm>> findFarmByUID(String id) async {
    return _queryAdapter.queryList('SELECT * FROM Farm WHERE uid = ?1',
        mapper: (Map<String, Object?> row) => Farm(
            uid: row['uid'] as String?,
            agent: row['agent'] as String?,
            farmboundary: row['farmboundary'] as Uint8List?,
            farmer: row['farmer'] as int?,
            farmArea: row['farmArea'] as double?,
            registrationDate: row['registrationDate'] as String?,
            status: row['status'] as int?,
            societyCode: row['societyCode'] as int?),
        arguments: [id]);
  }

  @override
  Future<int?> deleteFarmByUID(String id) async {
    return _queryAdapter.query('DELETE FROM Farm WHERE uid = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [id]);
  }

  @override
  Future<void> deleteAllFarm() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Farm');
  }

  @override
  Future<int?> updateFarmSubmissionStatusByUID(
    int status,
    String id,
  ) async {
    return _queryAdapter.query('UPDATE Farm SET status = ?1 WHERE uid = ?2',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [status, id]);
  }

  @override
  Future<void> insertFarm(Farm farm) async {
    await _farmInsertionAdapter.insert(farm, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> bulkInsertFarm(List<Farm> farmList) {
    return _farmInsertionAdapter.insertListAndReturnIds(
        farmList, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateFarm(Farm farm) async {
    await _farmUpdateAdapter.update(farm, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteFarm(Farm farm) {
    return _farmDeletionAdapter.deleteAndReturnChangedRows(farm);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
