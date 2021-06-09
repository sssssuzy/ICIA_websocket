<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<link rel="stylesheet" href="/resources/chat.css" />
<title>채팅</title>
</head>
<body>
	<div class="chat_wrap">
		<div class="header">채 팅 방</div>
		<div id="chat"></div>
		<script id="temp" type="text/x-handlebars-template">
 			<div class="{{printLeftRight sender}}">
			<div class="sender">{{sender}}</div>
 			<div class="message">{{message}}</div>
 			<div class="date">{{date}}</div>
 			</div>
 		</script>
		<script>
			var uid = "${sessionScope.id}";
			Handlebars.registerHelper("printLeftRight", function(sender) {
				if (uid != sender) {
					return "left";
				} else {
					return "right";
				}
			});
		</script>
		<div class="input-div">
			<textarea id="txtMessage" placeholder="Press Enter for send message."></textarea>
		</div>
	</div>
</body>
<script type="text/javascript">
	//메세지 보내기
	var uid = "${sessionScope.id}";
	$("#txtMessage").on('keydown', function(e) {
		if (e.keyCode == 13 && !e.shiftKey) {
			e.preventDefault();
			var message = $(this).val();
			if (message == "") {
				alert("내용을 입력하세요!");
				return;
			}
			$("#txtMessage").val("");
			// 메시지 전송
			sock.send(uid + "|" + message);
			$("#txtMessage").clear();
		}
	});
	//웹소켓 정의
	var sock = new SockJS("http://localhost:8088/echo/");
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	//서버로부터 메시지를 받았을 때
	function onMessage(msg) {
		var items = msg.data.split("|");
		var sender = items[0];
		var message = items[1];
		var date = items[2];
		var data = {
			"sender" : sender,
			"message" : message,
			"date" : date
		};
		var template = Handlebars.compile($("#temp").html());
		$("#chat").append(template(data));
		//스크롤바 아래 고정
		window.scrollTo(0, $('#chat').prop('scrollHeight'));
	}
	//서버와 연결을 끊었을 때
	function onClose(evt) {
		console.log("연결이 끊김");
	}
</script>
</html>