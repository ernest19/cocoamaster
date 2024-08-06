import 'package:cocoa_master/controller/entity/farm.dart';
import 'package:floor/floor.dart';

@dao
abstract class FarmDao {
  @Query('SELECT * FROM Farm')
  Stream<List<Farm>> findAllFarmStream();

  @Query('SELECT * FROM Farm')
  Future<List<Farm>> findAllFarm();

  @Query('SELECT * FROM Farm WHERE status = :status')
  Stream<List<Farm>> findFarmByStatusStream(int status);

  @Query(
      'SELECT * FROM Farm WHERE status = :status LIMIT :limit OFFSET :offset')
  Future<List<Farm>> findFarmByStatusWithLimit(
      int status, int limit, int offset);

  @Query('SELECT * FROM Farm WHERE status = :status')
  Future<List<Farm>> findFarmByStatus(int status);

  @Query('SELECT * FROM Farm WHERE uid = :id')
  Future<List<Farm>> findFarmByUID(String id);

  @Query('DELETE FROM Farm WHERE uid = :id')
  Future<int?> deleteFarmByUID(String id);

  @delete
  Future<int?> deleteFarm(Farm farm);

  @Query('DELETE FROM Farm')
  Future<void> deleteAllFarm();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFarm(Farm farm);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> bulkInsertFarm(List<Farm> farmList);

  @Query('UPDATE Farm SET status = :status WHERE uid = :id')
  Future<int?> updateFarmSubmissionStatusByUID(int status, String id);

  @update
  Future<void> updateFarm(Farm farm);
}
