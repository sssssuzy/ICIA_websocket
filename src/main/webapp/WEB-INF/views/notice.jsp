<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
   <head>
      <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
      <link rel="stylesheet" href="/resources/notice.css"/>
      <title>Notice</title>
      <style>
      #header { 
				 overflow: hidden;
				 background: #F18C7E; 
				 color: white;
				 padding: 15px 0px 15px 30px;
				}
				.left-item{ 
				 float: left;
				}
      #notice-content{
         font-size: 10px;
         display: block;
         white-space: nowrap;
         overflow: hidden;
         text-overflow: ellipsis;
      }
      </style>
   </head>
   <body>
   <!-- 메뉴바 ---------------------------------------------------------------->
      <div id="header">
         <div class="right-item"><div id="bell"><span id="count">${count}</span></div></div>
         <div class="right-item"><div id="user-id">[ ${sessionScope.id} ]</div></div>
         <div class="left-item"><div id="notice-send">알림전송</div></div>
      </div>   
      <!-- 알림 목록출력 ------------------------------------------------------ -->
      <div id="content">
         <div id="divNotice"></div>
         <script id="temp" type="text/x-handlebars-template">
         {{#each .}}
            <div class="panel panel-default" style="margin:30px">
                 <div class="panel-heading">
                  {{writeDate}}
                  <button style="{{display}}" type="button" class="close" data-dismiss="modal" nid="{{nid}}">×</button>
               </div>
                 <div class="panel-body">
                      <p>{{content}}</p>
                 </div>
            </div>
         {{/each}}
         </script>
         <script>
         	//매니저가 아닐때는 알림 삭제버튼 안보이도록
         	Handlebars.registerHelper("display",function(){
         		var id="${sessionScope.id}";
         		if(id!="manager") return "display:none;";
         	});
         </script>
      </div>
   <!-- 알림작성 모달창 ----------------------------------------------------------->
   <div class="modal fade" id="notice-modal" role="dialog">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal">×</button>
               <h4 class="modal-title">알림전송</h4>
            </div>
            <div class="modal-body">
               <p><input type="text" name="id" class="form-control" id="txtContent" placeholder="알림내용" /></p>
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-primary" data-dismiss="modal"
                  id="btnSend">Send</button>
               <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
         </div>
      </div>
   </div>
   <!-- 새로운 알람창------------------------------------------------------------------->
 <div style="width:250px; float:right; margin:10px;" id="notice-div">
	 <div class="panel panel-default">
		 <div class="panel-heading">
		 	<span id="notice-date" style="font-size:10px;">2021-05-05</span>
			 <button type="button" class="close" data-dismiss="modal">×</button>
		 </div>
		 <div class="panel-body">
		 	<span id="notice-content" >여기에는 알림 내용을 출력합니다.</span>
		 </div>
	 </div>
 </div>
	 <script>
	 $("#notice-div").on("click", ".panel-heading button", function(){
		 $("#notice-div").hide();
	 });
	 </script>
</body>
   <script>
   		//페이지가 로드될 때   		
   		$("#notice-div").hide();   		
   		//manager로 로그인한 경우
		var uid="${sessionScope.id}";
		if(uid == "manager"){
			$("#bell").hide();
			getList();
		}else{
			$("#notice-send").hide();
			$("#content").hide();
			if("${count}"==0) {
	   			$("#count").hide();
	   		}			
		}
		//일반사용자가 알림목록을 볼 경우
		$("#bell").on("click",function(){
			getList();
		});
		 //알림 목록 출력
	      //getList();
	      function getList(){
	    	  $("#content").show();
	    	  $("#count").hide();
	    	  $("#notice-div").hide();
	         $.ajax({
	            type:"get",
	            url:"list.json",
	            dataType:"json",
	            data:{"uid":uid},
	            success:function(data){
	               var temp = Handlebars.compile($("#temp").html());
	               $("#divNotice").html(temp(data));
	            }
	         });
	      }      
	      
      //알림삭제 버튼을 클릭한 경우
      $("#divNotice").on("click", ".panel-heading .close", function(){
         var nid = $(this).attr("nid");
         if(!confirm(nid + "번 알림을 삭제하시겠습니까?")) return;
         $.ajax({
            type:"get",
            url:"delete",
            data:{"nid":nid},
            success:function(data){
               alert("알림 삭제 완료!");
               getList();
               sock.send("삭제");
            }
         });
      });
   
      //알림전송 버튼을 클릭한경우
      $("#txtContent").on("keydown", function(e){
         if(e.keyCode == 13) $("#btnSend").click();
      });
      
      $("#btnSend").on("click", function(){
         var content = $("#txtContent").val();
         if(content == ""){
            alert("내용을 입력하세요!");
            return;
         }
         if(!confirm("입력한 내용을 전송할까요?")) return;
         $.ajax({
            type:"get",
            url:"insert",
            data:{"content":content},
            success:function(data){
               alert("알림 전송완료");
               $("#txtContent").val("");
               getList();
               sock.send(content);
            }
         });
      });
   
      //알림전송 메뉴를 선택한 경우
      $("#notice-send").on("click", function(){
         $("#notice-modal").modal("show");
      });   
      
     
      //웹소켓 정의
      var sock = new SockJS("http://localhost:8088/notice");
      sock.onmessage = onMessage;
      sock.onclose = onClose;
      
      //서버에서 메시지를 받았을 때
      function onMessage(msg){
            var items = msg.data.split("|");           
            var message=items[1] ;
            var count=items[2];
            var date=items[3];
            if($("#content").is(":visible")){
            	$.ajax({
            		type:"get",
            		url:"readDateUpdate",
            		data:{"uid":uid},
            		success:function(){
            			getList();
            		}
            	});
            }else{            	
            	 $("#count").show();
            	 $("#notice-div").show();
                 $("#notice-date").html(date);
                 $("#notice-content").html(message);
                 $("#count").html(count);
                 if(count==0){
         			$("#count").hide();
         		}
                 
            }           
      }
      
      //서버연결이 끊겼을 때
      function onClose(evt){
         console.log("연결이 끊김")
      }
   </script>
</html>