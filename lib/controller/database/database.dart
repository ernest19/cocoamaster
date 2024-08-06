import 'dart:async';
import 'dart:typed_data';

import 'package:cocoa_master/controller/dao/assigned_farm_dao.dart';
import 'package:cocoa_master/controller/dao/farm_dao.dart';
import 'package:cocoa_master/controller/dao/farmer_dao.dart';
import 'package:cocoa_master/controller/dao/farmer_from_server_dao.dart';
import 'package:cocoa_master/controller/entity/assigned_farm.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../view/utils/datetime_converter.dart';
import '../dao/calculated_area_dao.dart';
import '../dao/po_location_dao.dart';
import '../dao/society_dao.dart';
import '../entity/calculated_area.dart';
import '../entity/farm.dart';
import '../entity/farmer.dart';
import '../entity/farmer_from_server.dart';
import '../entity/po_location.dart';
import '../entity/society.dart';

part 'database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [
  CalculatedArea,
  PoLocation,
  Farmer,
  Farm,
  AssignedFarm,
  Society,
  FarmerFromServer,
])
abstract class AppDatabase extends FloorDatabase {
  CalculatedAreaDao get calculatedAreaDao;
  POLocationDao get poLocationDao;
  FarmerDao get farmerDao;
  SocietyDao get societyDao;
  FarmerFromServerDao get farmerFromServerDao;
  FarmDao get farmDao;
  AssignedFarmDao get assignedFarmDao;
}
