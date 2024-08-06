import 'package:floor/floor.dart';

import '../entity/po_location.dart';

@dao
abstract class POLocationDao {
  @Query('SELECT * FROM PoLocation')
  Stream<List<PoLocation>> findAllPOLocationStream();

  @Query('SELECT * FROM PoLocation')
  Future<List<PoLocation>> findAllPOLocations();

  @Query('SELECT * FROM PoLocation LIMIT :limit OFFSET :offset')
  Future<List<PoLocation>> findPoLocationWithLimit(int limit, int offset);

  @delete
  Future<int?> deletePOLocation(PoLocation poLocation);

  @Query('DELETE FROM PoLocation')
  Future<void> deleteAllPOLocation();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPOLocation(PoLocation poLocation);

}

