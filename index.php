<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="style.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+JP" rel="stylesheet">

    <title>LED操作</title>
</head>
<header>
    <img src="led_red.png">
    <h1>Lチカ(*'▽')</h1>
</header>
<body>
    
    

    <div class="page">
    <?php
    //NEED TO CHANGE CONFIG      configで設定してください。
    include "get.php";
    ?>
    <form action="update.php" method="post">
        <div class="btn-array">
            <button type="submit" class="led-btn" name="red"><img src="led_red.png"></button>
            <button type="submit" class="led-btn" name="green"><img src="led_green.png"></button>
            <button type="submit" class="led-btn" name="blue"><img src="led_blue.png"></button>
            <button type="submit" class="led-btn" name="rainbow"><img></button>
        </div>
        <br>
        <input type="text" name="status">
        <input type="submit" name="submitBtn" value="送信">
    </form>


    </div>


</body>
</html>