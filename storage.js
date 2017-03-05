//storage.js
// 首先創建一個helper方法連接資料庫
function  getDatabase() {
     return  LocalStorage.openDatabaseSync( "MyAppName" ,  "1.0" ,  "StorageDatabase" , 100000);
}

// 程序打開時，初始化表
function  initialize() {
    var  db = getDatabase();
    db.transaction(
        function (tx) {
            // 如果setting表不存在，則創建一個
            // 如果表存在，則跳過此步
            tx.executeSql( 'CREATE TABLE IF NOT EXISTS settings(setting TEXT UNIQUE, value TEXT)' );
      });
}

// 插入資料
function  set(setting, value) {
   var  db = getDatabase();
   var  res =  "" ;
   db.transaction( function (tx) {
        var  rs = tx.executeSql( 'INSERT OR REPLACE INTO settings VALUES (?,?);' , [setting,value]);
              //console.log(rs.rowsAffected)
              if  (rs.rowsAffected > 0) {
                res =  "OK" ;
              }  else  {
                res =  "Error" ;
              }
        }
  );
  return  res;
}

 // 獲取資料
function  get(setting) {
   var  db = getDatabase();
   var  res= "" ;
   db.transaction( function (tx) {
     var  rs = tx.executeSql( 'SELECT value FROM settings WHERE setting=?;' , [setting]);
     if  (rs.rows.length > 0) {
          res = rs.rows.item(0).value;
     }  else  {
         res =  "Unknown" ;
     }
  })
  return  res
}

// 獲取全部資料
function  getall() {
  var  db = getDatabase();
  var  res= "" ;
  db.transaction( function (tx) {
    var  rs = tx.executeSql( 'SELECT * FROM settings ');

      var data = [];
      for(var i = 0; i < rs.rows.length; i++) {
          data.push(rs.rows.item(i).value);
      }
      res = data;
 })
 return  res
}
// 獲取全部資料數量
function  getallNum() {
  var  db = getDatabase();
  var  res= "" ;
  db.transaction( function (tx) {
    var  rs = tx.executeSql( 'SELECT * FROM settings ');
      res = rs.rows;
 })
 return  res
}
 // 刪除資料
function delet(setting){
    var  db = getDatabase();
    var  res= "" ;
    db.transaction( function (tx) {
      var  rs = tx.executeSql( 'DELETE FROM settings WHERE setting=?;' , [setting]);
        if  (rs.rowsAffected > 0) {
          res =  "OK" ;
        }  else  {
          res =  "Error" ;
        }
   })
    return res
}
