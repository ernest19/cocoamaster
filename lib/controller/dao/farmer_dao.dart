import 'package:cocoa_master/controller/entity/farmer.dart';
import 'package:floor/floor.dart';

@dao
abstract class FarmerDao {
  @Query('SELECT * FROM Farmer')
  Stream<List<Farmer>> findAllFarmerStream();

  @Query('SELECT * FROM Farmer')
  Future<List<Farmer>> findAllFarmer();

  @Query('SELECT * FROM Farmer LIMIT :limit OFFSET :offset')
  Future<List<Farmer>> findFarmerWithLimit(int limit, int offset);

  @Query('SELECT * FROM Farmer WHERE status = :status')
  Stream<List<Farmer>> findFarmerByStatusStream(int status);

  @Query('SELECT * FROM Farmer WHERE status = :status')
  Future<List<Farmer>> findFarmerByStatus(int status);

  @Query(
      'SELECT * FROM Farmer WHERE status = :status LIMIT :limit OFFSET :offset')
  Future<List<Farmer>> findFarmerByStatusWithLimit(
      int status, int limit, int offset);

  @Query('SELECT * FROM Farmer WHERE uid = :id')
  Future<List<Farmer>> findFarmerByUID(String id);

  @Query('DELETE FROM Farmer WHERE uid = :id')
  Future<int?> deletePeFarmerUID(String id);

  @delete
  Future<int?> deleteFarmer(Farmer farmer);

  @Query('DELETE FROM Farmer')
  Future<void> deleteAllFarmers();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFarmer(Farmer farmer);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> bulkInsertFarmer(List<Farmer> farmerList);

  @Query('UPDATE Farmer SET status = :status WHERE uid = :id')
  Future<int?> updateFarmerSubmissionStatusByUID(int status, String id);

  @update
  Future<void> updateFarmer(Farmer farmer);
}
