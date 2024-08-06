import 'package:floor/floor.dart';

import '../entity/calculated_area.dart';

@dao
abstract class CalculatedAreaDao {
  @Query('SELECT * FROM CalculatedArea ORDER BY date')
  Stream<List<CalculatedArea>> findAllCalculatedAreaStream();

  @Query('SELECT * FROM CalculatedArea ORDER BY date')
  Future<List<CalculatedArea>> findAllCalculatedArea();

  @delete
  Future<int?> deleteCalculatedArea(CalculatedArea calculatedArea);

  @Query('DELETE FROM CalculatedArea')
  Future<void> deleteAllCalculatedArea();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCalculatedArea(CalculatedArea calculatedArea);

}
