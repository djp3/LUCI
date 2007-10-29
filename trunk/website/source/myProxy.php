<?php
  $url = $_SERVER['QUERY_STRING'];
  $ch = curl_init($url);
  curl_exec($ch);
?>
