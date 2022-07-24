<?php
//NEED TO CHANGE CONFIG      configで設定してください。
include "config.php";

//connect to database         データベースに接続
$pdo = new PDO("mysql:dbname=$dbname;host=$host;", $username, $password);

$stmt = $pdo->prepare("SELECT * FROM ledstatus WHERE id = 1;");
//$stmt = $pdo->prepare("INSERT INTO ledstatus values();");

//$stmt->execute();
$res = $stmt->execute();

if( $res ) {
	$data = $stmt->fetch();
	echo $data['status'];
}
?>