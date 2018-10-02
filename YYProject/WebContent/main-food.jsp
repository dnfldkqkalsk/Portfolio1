<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<!--style-->
<link rel="stylesheet" href="css/main-food-style.css">
<link rel="stylesheet" href="css/member-style.css">
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
	integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
	crossorigin="anonymous">
<!--font-->
<link href="https://fonts.googleapis.com/css?family=Jua"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Baloo+Tammudu|Nanum+Gothic+Coding"
	rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>main-food.jsp</title>

<script src='js/jquery-3.3.1.min.js'></script>
<script src='js/jquery.bpopup.min.js'></script>
<!--팝업창을 위한 파일-->
<!--로그인 팝업창 jquery-->
<script>
    $(document).ready(function(){
      //member-login에 있는 a태그에 click이벤트를 걸어준다.
      $('.member-login').find('a').on('click', function(e){
        e.preventDefault();//하이퍼링크 실행 막기
        //login-box를 띄운다.
        $('.login-box').bPopup({
          modalClose: true, //다른곳 클릭하면 팝업창 닫힘
          speed: 650,
          opacity:0.5,
          transition: 'slideIn', //실행시 동작
	      transitionClose: 'slideBack' //실행종료시 동작
        })
      })
      //member-login에 걸은 이벤트 코드종료
      
      
      //검색기능
      //이벤트를 달기 위해선 document.ready안에 써야 함 
      $("#search").on('keyup', function(e){ /*key가 눌렸다 올라올 때-뗐을때*/
    	  //search가 e에 담김
    	 
      	var keyword =  $(this).val(); //this = id가 search인 것, val값을 가져옴
    	var type = $("#type").val(); //select  
			 
      	if(e.keyCode == 13){
	      	//alert(keyword); //enter키는 13이다.
      		location.href = "/YYProject/user?actionName=search&k="+keyword+"&t="+type; //keyword는 자바스크립트 변수이므로 +로 연결
      		
      	}
      	
      })
      
      //서치바 돋보기 아이콘
      $("#searchI").on("click", function(e){
    	  e.preventDefault(); //a태그 이벤트 걸 시 기존 이벤트를 제거한다.
      	  var keyword =  $(this).val(); //this = id가 search인 것, val값을 가져옴
     	  var type = $("#type").val(); //select  
		      	  
      	  location.href = "/YYProject/user?actionName=search&k="+keyword+"&t="+type; //keyword는 자바스크립트 변수이므로 +로 연결
    	  
      })
      
    })
  </script>
<!--로그인 팝업창 jquery-->



<!--회원가입 팝업창 jquery-->
<script>
    $(document).ready(function(){
    	
    	
      $("#checkId").on("click", function(){
    	  var inputId = $("#joinId").val(); //사용자가 입력한 값을 가져온다.
    	  
    	  $.ajax({//중괄호 안에선 ;안된다.
    		  //옵션
    		  url : "/YYProject/user", //매핑값
    		  type : "post",
    		  data : {id : inputId, actionName:"checkId"}, //url로 갈때 가져갈 값
    		  dataType : "text", //ajax가 처리하고 돌아왔을때(joinAction같은것의(갔다가 dao를 간다) 리턴타입의 자료형) 데이터의 자료형
			  //json은 배열, vo객체를 담아줄때 사용한다.
			  success : function(result){//url로 갔다가 성공처리되면 실행된다.
			  		//중복이면 0 아니면 1
			  		//스크립트에선 number로 한다

				  if(Number(result)==1){ //숫자로 형변환
				  	//중복되지 않음
					alert('사용가능한 아이디입니다.');
					$('#join-button').removeAttr('disabled');
				  }else if(Number(result)==0){
					  $('#join-button').attr('disabled', 'disabled');
					alert('중복된 아이디입니다.');  
				  }else if(Number(result)==-1){
					  $('#join-button').attr('disabled', 'disabled');
					alert('아이디를 입력해주세요.');  
				  }
			  }
    	  })
      })  
      //member-join에 있는 a태그에 click이벤트를 걸어준다.
      $('.member-join').find('a').on('click', function(e){
        e.preventDefault();//하이퍼링크 실행 막기
        //join-box를 띄운다.
        $('.join-box').bPopup({
          modalClose: true, //다른곳 클릭하면 팝업창 닫힘
          speed: 650,
          opacity:0.5,
          transition: 'slideIn', //실행시 동작
          transitionClose: 'slideBack' //실행종료시 동작
        })
      })
      //member-join에 걸은 이벤트 코드종료

      
      //비밀번호 일치 불일치
      var password = $('#password').val;
      var repassword = $('#repassword').val;
      
      $('#repassword').on('keyup', function(){//key가 올라가면
    	  
    	var password = $('#password').val();
    	var repassword = $('#repassword').val();
    	
    	if(password!=repassword){ //일치하지 않는다면
    		$('#checkPassword').html('비밀번호 불일치');
    		$('#checkPassword').css('color', 'red');	
    		$('#checkPassword').css('font-weight', 'bold');
    		$('#join-button').attr('disabled', 'disabled'); //불일치하면 가입버튼이 안눌림
    	}else if(password==repassword){ //일치한다면
    		$('#checkPassword').html('비밀번호 일치');
    		$('#checkPassword').css('color', 'green');
    		$('#checkPassword').css('font-weight', 'bold');
    		$('#join-button').removeAttr('disabled');
    	}else{//아무것도 입력되지 않았다면
    		$('#checkPassword').html(''); //아무것도 출력하지 않는다.
			$('#checkPassword').css('color', 'black');
    		$('#checkPassword').css('font-weight', 'bold');
    		$('#join-button').attr('disabled', 'disabled'); //비어있다면 가입버튼이 안눌림
    	}
      })
      //비밀번호 일치 불일치
    })
    

 </script>

</head>
<body>
	<div id="wrap">
		<div id="container">
			<div class="header">
				<div class="menu">
					<div class="menu-food">
						<div class="menu-food-i">
							<i class="fas fa-check"></i><!-- check 아이콘 -->
						</div>
						<a href="main-food.jsp"> <img src="img/food.png">
							<p>Food</p>
						</a>
					</div>
					<div class="menu-cafe">
						<a href="main-cafe.jsp"> <img src="img/cafe.png">
							<p>Cafe</p>
						</a>
					</div>
				</div>
				<!--메뉴바-->
					<div class="logo">
					<a href="main-food.jsp">
						<p>PPick!</p>
					</a>
				</div>
				<!--로고-->
				
				<!--회원 -->
 				<%
					String sessionID = (String)session.getAttribute("sessionID");
				
					if(sessionID != null){
				%>
				<!-- sessionID가 있을 경우 → 로그인 했을경우 -->
				<div class="member2">
					<div class="member-user">
						<a href="mypage.jsp">
							<p>${sessionID}'s </p>
						</a>
					</div>
					<!--로그아웃-->
					<div class="member-logout">
						<a href="/YYProject/user?actionName=userLogout" ><img src="img/logout.png">
							<p>Logout</p>
						</a>
					</div>
				</div>	
				<%		
					}else{
				%>
				<!-- sessionID가 없을 경우 -->
				<div class="member">
					<div class="member-login">
						<a href="#"> <img src="img/login.png">
							<p>Login</p>
						</a>
					</div>
					<!--로그인-->
					<div class="member-join">
						<a href="#"> <img src="img/join.png">
							<p>Join</p>
						</a>
					</div>
					<!--회원가입-->
				</div>
				<%		
					}
				%>
	
				<!--회원-->
			</div>
			<!--header-->
			
				<div class="bar">
					<!-- select -->
					<div class="search-type">
						<select name="type" id="type">
							<option value="tbName">가게명</option>
							<option value="tbLocation">주소</option>
							<option value="tbHash">#</option>
						</select>
					</div>
				
					<!--search-bar-->
					<div class="search-bar">
						<input type="text" placeholder="검색어를 입력하세요." name="search" id="search">
						<a href="#" id="searchI"><i class="fas fa-search"></i></a>
					</div>
					<!--search-bar-->
					<div class="hash">
						<a href="/YYProject/user?actionName=search&t=tbHash&k=데이트">
						<!-- searchAction에서 type과 keyword를 t, k로 받아주기 때문에 바꾼다. -->
							<p>#데이트</p> <!-- 검색하는것과 마찬가지기 때문에 위에 search-type의 name명이 type인
												것의 tbHash를 넣어주는 것이다. -->
						</a>
						<a href="/YYProject/user?actionName=search&t=tbHash&k=분위기 깡패">
							<p>#분위기 깡패</p>
						</a>
						<a href="/YYProject/user?actionName=search&t=tbHash&k=친구랑">
							<p>#친구랑</p>
						</a>
						<a href="/YYProject/user?actionName=search&t=tbHash&k=인스타 갬성">
							<p>#인스타 갬성</p>
						</a>
					</div>
					<!--hash-->
				</div>
				<!--bar-->
			<div class="contents">



				<div class="container">
					<div class="seoul">
					<!--어디로 가든 (user)actionFactory로 가기 때문에 경로는 상관없음-->
						<a href="/YYProject/user?actionName=list&l=서울">
							<div class="box-title">
								<h1>서울</h1>
							</div> <img src="img/seoul.jpg">
							<div class="cover"></div>
							<div class="cover-title">
								<h1>서울</h1>
							</div>
						</a>
					</div>
					<!--seoul-->
					<div class="incheon">
						<a href="/YYProject/user?actionName=list&l=인천">
							<div class="box-title">
								<h1>인천</h1>
							</div> <img src="img/incheon.jpg">
							<div class="cover"></div>
							<div class="cover-title">
								<h1>인천</h1>
							</div>
						</a>
					</div>
					<!--incheon-->
					<div class="busan">
						<a href="/YYProject/user?actionName=list&l=부산">
							<div class="box-title">
								<h1>부산</h1>
							</div> <img src="img/busan.jpg">
							<div class="cover"></div>
							<div class="cover-title">
								<h1>부산</h1>
							</div>
						</a>
					</div>
					<!--busan-->
					<div class="jeju">
						<a href="/YYProject/user?actionName=list&l=제주도">
							<div class="box-title">
								<h1>제주도</h1>
							</div> <img src="img/jeju.jpg">
							<div class="cover"></div>
							<div class="cover-title">
								<h1>제주도</h1>
							</div>
						</a>
					</div>
					<!--jeju-->
					<div class="gyeonggi">
						<a href="/YYProject/user?actionName=list&l=경기도">
							<div class="box-title">
								<h1>경기도</h1>
							</div> <img src="img/gyeonggi.jpg">
							<div class="cover"></div>
							<div class="cover-title">
								<h1>경기도</h1>
							</div>
						</a>
					</div>
					<!--gyeonggi-->
					<div class="gyeongsang">
						<a href="/YYProject/user?actionName=list&l=경상도">
							<div class="box-title">
								<h1>경상도</h1>
							</div> <img src="img/gyeongsang.jpg">
							<div class="cover"></div>
							<div class="cover-title">
								<h1>경상도</h1>
							</div>
						</a>
					</div>
					<!--gyeongsang-->
					<div class="jeonla">
						<a href="/YYProject/user?actionName=list&l=전라도">
							<div class="box-title">
								<h1>전라도</h1>
							</div> <img src="img/jeonla.jpg">
							<div class="cover"></div>
							<div class="cover-title">
								<h1>전라도</h1>
							</div>
						</a>
					</div>
					<!--jeonla-->
					<div class="gangwon">
						<a href="/YYProject/user?actionName=list&l=강원도">
							<div class="box-title">
								<h1>강원도</h1>
							</div> <img src="img/gangwon.jpg">
							<div class="cover"></div>
							<div class="cover-title">
								<h1>강원도</h1>
							</div>
						</a>
					</div>
				</div>
				<!--gangwon-->
				<!--container-->

			</div>
			<!--contents-->
			<div class="footer">
				<div class="footer-top">
					<p>logo</p>
				</div>
				<div class="footer-bottom">
					<p>
						(주)YYcompany<br> 박아영 a01259@naver.com / 이유진
						dnfldkqkalsk@naver.com<br> Copyright© 2018-09-03 Park A
						young, Lee yu jin
					</p>
				</div>
			</div>
			<!--footer-->
		</div>
		<!--container-->
	</div>
	<!--wrap-->

	<!--login.html-->
	<div class="login-box">
		<form action="/YYProject/user" method="post">
			<input type="hidden" name="actionName" value="userLogin">
			<div class="login-top">
				<h1>LOGIN</h1>
			</div>
			<!--login-top-->
			<div class="login-middle">
				<div class="login-id">
					<i class="fas fa-user"></i> <input type="text" name="id"
						placeholder="id" autocomplete="off" autofocus="autofocus">
				</div>
				<div class="login-password">
					<i class="fas fa-unlock"></i> <input type="password"
						name="password" placeholder="password" autocomplete="off">
				</div>
			</div>
			<!--login-middle-->
			<div class="login-bottom">
				<div class="login-button">
					<input type="submit" value="login">
				</div>
				<div class="forget-pwd">
					<a href = "mypage.jsp"><p>forget password?</p></a>
				</div>
			</div>
			<!--login-bottom-->
		</form>
	</div>

	<!--login.html-->


	<!--join.html-->
	<div class="join-box">
		<form action="/YYProject/user" method="post">
			<input type="hidden" name="actionName" value="userJoin">
			<div class="join-top">
				<h1>JOIN</h1>
			</div>
			<div class="join-middle">
				<div class="join-name">
					<i class="fas fa-user"></i> <input type="text" name="name"
						placeholder="name" autocomplete="off" required autofocus="autofocus">
				</div>
				<div class="join-id">
					<i class="fas fa-user"></i> <input type="text" name="id"
						id="joinId" placeholder="id" autocomplete="off" required>
					<a href="#" id="checkId">check id</a>
				</div>
				
				
				<div class="join-password">
					<i class="fas fa-unlock"></i> <input type="password" id="password"
						name="password" placeholder="password" autocomplete="off" required>
				</div>
				<div class="join-repassword">
					<i class="fas fa-unlock"></i> <input type="password" id="repassword"
						name="repassword" placeholder="repassword" autocomplete="off"
						required>
					<p id="checkPassword"></p> <!-- 비밀번호 일치or불일치 나타남 -->
				</div>
				
				
				<div class="join-email">
					<i class="fas fa-envelope"></i> <input type="email" name="email"
						placeholder="e-mail" autocomplete="off" required>
				</div>
			</div>
			<div class="join-bottom">
				<div class="join-button">
					<input type="submit" value="join" id="join-button" disabled><!-- 작동 or 작동x -->
				</div>
			</div>
		</form>
	</div>
	<!--join.html-->

</body>
</html>
