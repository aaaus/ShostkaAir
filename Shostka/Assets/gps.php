<?php
$ip = $_SERVER['REMOTE_ADDR']; //получаем IP адрес клиента
$client = $_SERVER['HTTP_USER_AGENT']; //получаем идентификатор HTTP клиента
$today = date("Y.m.d H:i:s"); //получаем текущие дату и время
// имя файла, в который производиться запись POST или GET запроса
$filename = "gps.html";
// имя поля в POST или GET запросе
$labId = 'labId'; //Номер лаборатории
$temp='temp'; //Коордтнаты
$pressure='pressure'; //Напряжение батареи
$altit='altit'; //Уровень сигнала
$humidity='humidity';
$co2='co2';
$tvoc='tvoc';
$ch2o='ch2o';
$pm1='pm1';
$pm2='pm2';
$pm10='pm10';
$oaq='oaq';
$aaq='aaq';
$tempDS='tempDS';
$labID='labID';

$labNamberFromID='labNamberFromID';
$labNamberFromApp = $_GET[$labNamberFromID];
$getFromApp='getFromApp';
$dataGetFromApp = $_GET[$getFromApp];
$xAxis='xAxis';
$xAxisGetFromApp = $_GET[$xAxis];


if ($_GET[$temp] != "") {
    
    // проверка существования файла
    if (file_exists($filename)) {
        // если файл существует - открываем его
        $file = fopen($filename, "a");
    } else {
        // если файл не существует - создадим его
        $file = fopen($filename, "w+");
    }
    // данные из поля $name_var в POST или GET запросе
    $tvocGetFromApp = $_GET[$tvoc];
    $labIDGetFromLab = $_GET[$labID];
    
    
    $text = " labID:".$_GET[$labID]." Temp:".$_GET[$temp]." pressure:".$_GET[$pressure]." humidity:".$_GET[$humidity]." tvoc:".$_GET[$tvoc]." ch2o:".$_GET[$ch2o]." pm1:".$_GET[$pm1]." pm2:".$_GET[$pm2]." pm10:".$_GET[$pm10]." oaq:".$_GET[$oaq]." aaq:".$_GET[$aaq]." tempDS:".$_GET[$tempDS]."</BR>";
    
    
    
    // записываем строку в файл
    fwrite($file, "$today; $ip; $client; $text; $jsonData;\r\n");
    // закрываем файл
    fclose($file);
    
    
    //Преобразование json файла с обновлением параметров
    $data = json_decode(file_get_contents('places.json'));
    foreach($data->photos as $mydata)
    {
        //echo $mydata->id . "\n";
    }
    foreach ($data->photos as $entry) {
        if ($entry->id == 100) {
            $entry->title = $_GET[$tempDS]." °C";
            $entry->latitude = 1;
        }
        if ($entry->id == 101) {
            $entry->title = $_GET[$humidity]." %";
            $entry->latitude = 1;
        }
        if ($entry->id == 102) {
            $entry->title = round($_GET[$pressure])." мм.рт.ст.";
            $entry->latitude = 1;
        }
        if ($entry->id == 103) {
            $entry->title = $_GET[$tvoc]." ppb";
            $entry->latitude = 1;
        }
        if ($entry->id == 104) {
            $entry->title = $_GET[$ch2o]." ppm";
            $entry->latitude = 1;
        }
        if ($entry->id == 105) {
            $entry->title = $_GET[$oaq]." ppm";
            $entry->latitude = 1;
        }
        if ($entry->id == 106) {
            $entry->title = $_GET[$pm1]." мкг/м";
            $entry->latitude = 1;
        }
        if ($entry->id == 107) {
            $entry->title = $_GET[$pm2]." мкг/м";
            $entry->latitude = 1;
        }
        if ($entry->id == 108) {
            $entry->title = $_GET[$pm10]." мкг/м";
            $entry->latitude = 1;
        }
        if ($entry->id == 109) {
            $entry->title = $_GET[$rain]."Сухо";
            $entry->latitude = 1;
        }
        if ($entry->id == 110) {
            $entry->title = $_GET[$winddirect]."Пд-Зах";
            $entry->latitude = 1;
        }
        if ($entry->id == 111) {
            $entry->title = $_GET[$windspeed]." м/с";
            $entry->latitude = 1;
        }
        
        if ($entry->id == 200) {
            $entry->title = $_GET[$tempDS]." °C";
            $entry->latitude = 1;
        }
        if ($entry->id == 201) {
            $entry->title = $_GET[$humidity]." %";
            $entry->latitude = 1;
        }
        if ($entry->id == 202) {
            $entry->title = round($_GET[$pressure])." мм.рт.ст.";
            $entry->latitude = 1;
        }
        if ($entry->id == 203) {
            $entry->title = $_GET[$tvoc]." ppb";
            $entry->latitude = 1;
        }
        if ($entry->id == 204) {
            $entry->title = $_GET[$ch2o]." ppm";
            $entry->latitude = 1;
        }
        if ($entry->id == 205) {
            $entry->title = $_GET[$oaq]." ppm";
            $entry->latitude = 1;
        }
        if ($entry->id == 206) {
            $entry->title = $_GET[$pm1]." мкг/м";
            $entry->latitude = 1;
        }
        if ($entry->id == 207) {
            $entry->title = $_GET[$pm2]." мкг/м";
            $entry->latitude = 1;
        }
        if ($entry->id == 208) {
            $entry->title = $_GET[$pm10]." мкг/м";
            $entry->latitude = 1;
        }
        if ($entry->id == 209) {
            $entry->title = $_GET[$rain]."Сухо";
            $entry->latitude = 1;
        }
        if ($entry->id == 210) {
            $entry->title = $_GET[$winddirect]."Пд-Зах";
            $entry->latitude = 1;
        }
        if ($entry->id == 211) {
            $entry->title = $_GET[$windspeed]." м/с";
            $entry->latitude = 1;
        }
    }
    
    $newJsonString = json_encode($data);
    file_put_contents('places4.json', $newJsonString);
    
    
    
    
    $d = getdate();
    $month = $d[mon];
    $year = $d[year];
    
    // Данные для mysql сервера
    $dbhost = "shostka.mysql.tools"; // Хост
    $dbuser = "shostka_air"; // Имя пользователя
    $dbpassword = "Cpu1866Pro"; // Пароль
    $dbname = "shostka_air"; // Имя базы данных
    // Подключаемся к mysql серверу
    $link = mysql_connect($dbhost, $dbuser, $dbpassword);
    // Выбираем нашу базу данных
    mysql_select_db($dbname, $link);
    
    // Создаём таблицу
    $query = "create table labID".$labIDGetFromLab."_".$month."_".$year." (id int(7) primary key auto_increment, labDate datetime, temp float(5,2), pressure float(5,2), humidity float(5,2), tvoc int(5), ch2o float(5,2), pm1 int(5), pm2 int(5), pm10 int(5), oaq float(5,2), aaq int(5), tempDS float(5,2))";
    mysql_query($query, $link);
    
    $query = "insert into labID".$labIDGetFromLab."_".$month."_".$year."  values(0, NOW(), ".$_GET[$temp].", ".$_GET[$pressure].", ".$_GET[$humidity].", ".$_GET[$tvoc].", ".$_GET[$ch2o].", ".$_GET[$pm1].", ".$_GET[$pm2].", ".$_GET[$pm10].", ".$_GET[$oaq].", ".$_GET[$aaq].", ".$_GET[$tempDS].")";
    mysql_query($query, $link);
    
    // http://sun.shostka.in/gps.php/?&labID=2&temp=24.26&pressure=756.10&humidity=25.91&tvoc=79&ch2o=0.35&pm1=4&pm2=7&pm10=7&oaq=62.50&aaq=1&tempDS=24.19
    
    // Закрываем соединение
    mysql_close($link);
    
    
    echo $query;
    
    //echo "dataok#TD()TD";
    //echo $tvocGetFromApp;
}




/*if ($dataGetFromApp == "json") {
 /*
 $data = json_decode(file_get_contents('places.json'));
 foreach($data->photos as $mydata)
 {
 //echo $mydata->id . "\n";
 }
 
 foreach ($data->photos as $entry) {
 if ($entry->id == 1) {
 print("1111");
 $entry->title = '55555';
 }
 }
 
 $newJsonString = json_encode($data);
 file_put_contents('places4.json', $newJsonString);
 }*/




//if ($dataGetFromApp != "json") {
if ($_GET[$temp] == "") {
    
    // Данные для mysql сервера
    $dbhost = "shostka.mysql.tools"; // Хост
    $dbuser = "shostka_air"; // Имя пользователя
    $dbpassword = "Cpu1866Pro"; // Пароль
    $dbname = "shostka_air"; // Имя базы данных
    // Подключаемся к mysql серверу
    $link = mysql_connect($dbhost, $dbuser, $dbpassword);
    // Выбираем нашу базу данных
    mysql_select_db($dbname, $link);
    
    $paramXAxisDotsCount = $xAxisGetFromApp;
    $paramShortName = "Параметр: ";
    $paramUnitsName = "";
    $paramLongName = "Графік";
    
    
    if ($dataGetFromApp == "tempDS") {
        $paramShortName = "Температура: ";
        $paramUnitsName = " °C";
        $paramLongName = "Температура повітря";
    }
    if ($dataGetFromApp == "humidity") {
        $paramShortName = "Вологість: ";
        $paramUnitsName = " %";
        $paramLongName = "Вологість повітря";
    }
    if ($dataGetFromApp == "pressure") {
        $paramShortName = "Тиск: ";
        $paramUnitsName = " мм.рт.ст.";
        $paramLongName = "Атмосферний тиск";
    }
    if ($dataGetFromApp == "tvoc") {
        $paramShortName = "ЛОС: ";
        $paramUnitsName = " ppb";
        $paramLongName = "Леткі органічні сполуки";
    }
    if ($dataGetFromApp == "ch2o") {
        $paramShortName = "Сполуки: ";
        $paramUnitsName = " ppm";
        $paramLongName = "Хімічні сполуки";
    }
    if ($dataGetFromApp == "oaq") {
        $paramShortName = "Якість: ";
        $paramUnitsName = " ppm";
        $paramLongName = "Якість повітря";
    }
    if ($dataGetFromApp == "pm1") {
        $paramShortName = "PM1.0: ";
        $paramUnitsName = " мкг/м";
        $paramLongName = "Забрудненість повітря";
    }
    if ($dataGetFromApp == "pm2") {
        $paramShortName = "PM2.5: ";
        $paramUnitsName = " мкг/м";
        $paramLongName = "Забрудненість повітря";
    }
    if ($dataGetFromApp == "pm10") {
        $paramShortName = "PM10: ";
        $paramUnitsName = " мкг/м";
        $paramLongName = "Забрудненість повітря";
    }
    if ($dataGetFromApp == "rain") {
        $paramShortName = "Опади: ";
        $paramUnitsName = "";
        $paramLongName = "Наявність дощу";
    }
    if ($dataGetFromApp == "winddirect") {
        $paramShortName = "Вітер: ";
        $paramUnitsName = "";
        $paramLongName = "Напрямок вітру";
    }
    if ($dataGetFromApp == "windspeed") {
        $paramShortName = "Вітер: ";
        $paramUnitsName = " м/с";
        $paramLongName = "Швидкість вітру";
    }
    
    
    
    $arrXAxis = array();
    $arrValues = array();
    $arrValueName = array();
    
    $query = 'SELECT * FROM labID'.$labNamberFromApp.'_4_2019 ORDER BY id DESC LIMIT '.$paramXAxisDotsCount;
    
    if ( $labNamberFromApp == 1) {
        $query = 'SELECT * FROM labID_4_2019 ORDER BY id DESC LIMIT '.$paramXAxisDotsCount;
    }
    
    //$query = 'SELECT * FROM labID_4_2019 ORDER BY id DESC LIMIT '.$paramXAxisDotsCount;
    $result = mysql_query($query) or die('Запрос не удался: ' . mysql_error());
    
    
    while ($line = mysql_fetch_assoc($result)) {
        array_push($arrXAxis, strtotime($line['labDate']));
        array_push($arrValues, floatval($line[$dataGetFromApp]));
    }
    
    mysql_free_result($result);
    
    array_push($arrValueName, $paramShortName, $paramUnitsName, $paramLongName);
    
    $arrToAPP = array('arrXAxis' => $arrXAxis, 'arrValue' => $arrValues, 'arrValueName' => $arrValueName, 'four' => 4);
    
    if ($dataGetFromApp == "google") {
        $arrXAxis = array();
        $arrValues = array();
        $arrValueName = array();
        
        $markerString1 = array();
        $markerString2 = array();
        $markerDouble1 = array();
        $markerDouble2 = array();
        
        $paramShortName = "";
        $paramUnitsName = "";
        $paramLongName = "";
        array_push($arrValueName, $paramShortName, $paramUnitsName, $paramLongName);
        
        //     array_push($arrXAxis, 51.872812, 51.872811, 51.870739, 51.870589, 51.878670, 51.879333, 51.870350, 51.879899, 51.879899);
        //     array_push($arrValues, 33.461746, 33.461560, 33.462190, 33.463723, 33.464353, 33.465153, 33.461231, 33.460314, 33.470314);
        
        array_push($arrXAxis, 51.874043, 51.870997, 51.872757, 51.872143, 51.873506, 51.871185, 51.872225, 51.873487, 51.871519, 51.872592, 51.873351, 51.872273, 51.872824);
        array_push($arrValues, 33.464443, 33.465821, 33.462422, 33.465022, 33.467050, 33.467802, 33.466776, 33.469259, 33.470199, 33.469885, 33.470551, 33.471201, 33.471804);
        
        array_push($arrXAxis, 51.864418, 51.864338, 51.864336);
        array_push($arrValues, 33.479775, 33.480448, 33.481651);
        
        
        array_push($markerString1, "Шостка.AIR №1", "Шостка.AIR №2");
        array_push($markerString2, "вул. Щедріна, 1", "вул. Миру, 11");
        array_push($markerDouble1, 51.872252, 51.864388);
        array_push($markerDouble2, 33.466748, 33.480586);
        
        
        $arrToAPP = array('arrXAxis2' => $arrXAxis, 'arrValue2' => $arrValues, 'arrValueName2' => $arrValueName, 'four2' => 5, 'markerString1' => $markerString1, 'markerString2' => $markerString2, 'markerDouble1' => $markerDouble1, 'markerDouble2' => $markerDouble2);
    }
    
    echo json_encode($arrToAPP);
    
    
}





///gps.php/?&temp=24.46&pressure=743.53&humidity=34.94&co2=754&tvoc=53&pm1=3&pm2=4&pm10=6


// ответ скрипта на запрос

//echo "dataok_IP1#TD(".date( "Дата: d.m.y Час: H:i" ).")TD#end";
?>
