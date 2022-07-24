<?php
//NEED TO CHANGE CONFIG      configで設定してください。
include "config.php";

//status文字に日本語は使用できない。


//参考
//https://blog.senseshare.jp/php-database.html

//データベースに接続
$pdo = new PDO("mysql:dbname=$dbname;host=$host;", $username, $password);

//入力取り込み
$status = $_POST['status'];

if (isset($_POST['red']))$status = "red";
if (isset($_POST['green']))$status = "green";
if (isset($_POST['blue']))$status = "blue";
if (isset($_POST['rainbow']))$status = "rainbow";

//SQL文を作成
$stmt = $pdo->prepare("UPDATE ledstatus SET status='$status' WHERE id=1;");
$stmt->execute();


header( "Location: index.php" ) ;
?>