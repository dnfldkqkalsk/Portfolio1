<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<!--style-->
<link rel="stylesheet" href="css/location-food-style.css">
<link rel="stylesheet" href="css/member-style.css">
<link rel="stylesheet" href="css/food-write-style.css">
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
<title>food-write.jsp</title>

<script src='js/jquery-3.3.1.min.js'></script>
<script src='js/jquery.bpopup.min.js'></script>
<script src='js/score.js'></script> <!-- 별점구현을 위한 파일 -->
<!--팝업창을 위한 파일-->
<!--로그인 팝업창 jquery-->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- 우편번호 검색 파일 -->
<script>
	$(document).ready(function() {
		//member-login에 있는 a태그에 click이벤트를 걸어준다.
		$('.member-login').find('a').on('click', function(e) {
			e.preventDefault();//하이퍼링크 실행 막기
			//login-box를 띄운다.
			$('.login-box').bPopup({
				modalClose : true, //다른곳 클릭하면 팝업창 닫힘
				speed : 650,
				opacity : 0.5,
				transition : 'slideIn', //실행시 동작
				transitionClose : 'slideBack' //실행종료시 동작
			})
		})
		//member-login에 걸은 이벤트 코드종료

	})
</script>
<!--로그인 팝업창 jquery-->

<!--회원가입 팝업창 jquery-->
<script>
	$(document).ready(
			function() {

				$("#checkId").on("click", function() {
					var inputId = $("#joinId").val(); //사용자가 입력한 값을 가져온다.

					$.ajax({//중괄호 안에선 ;안된다.
						//옵션
						url : "/YYProject/user", //매핑값
						type : "post",
						data : {
							id : inputId,
							actionName : "checkId"
						}, //url로 갈때 가져갈 값
						dateType : "text", //ajax가 처리하고 돌아왔을때(joinAction같은것의(갔다가 dao를 간다) 리턴타입의 자료형) 데이터의 자료형
						//json은 배열, vo객체를 담아줄때 사용한다.
						success : function(result) {//url로 갔다가 성공처리되면 실행된다.
							//중복이면 0 아니면 1
							//스크립트에선 number로 한다
							if (Number(result) == 1) { //숫자로 형변환
								//중복되지 않음
								alert('사용가능한 아이디입니다.');
							} else if (Number(result) == 0) {
								alert('중복된 아이디입니다.');
							}
						}
					})
				})

				//member-join에 있는 a태그에 click이벤트를 걸어준다.
				$('.member-join').find('a').on('click', function(e) {
					e.preventDefault();//하이퍼링크 실행 막기
					//join-box를 띄운다.
					$('.join-box').bPopup({
						modalClose : true, //다른곳 클릭하면 팝업창 닫힘
						speed : 650,
						opacity : 0.5,
						transition : 'slideIn', //실행시 동작
						transitionClose : 'slideBack' //실행종료시 동작
					})
				})
				//member-join에 걸은 이벤트 코드종료

				//비밀번호 일치 불일치
				var password = $('#password').val;
				var repassword = $('#repassword').val;

				$('#repassword').on('keyup', function() {//key가 올라가면

					var password = $('#password').val();
					var repassword = $('#repassword').val();

					if (password != repassword) { //일치하지 않는다면
						$('#checkPassword').html('비밀번호 불일치');
						$('#checkPassword').css('color', 'red');
						$('#checkPassword').css('font-weight', 'bold');
						$('#join-button').attr('disabled', 'disabled'); //불일치하면 가입버튼이 안눌림
					} else if (password == repassword) { //일치한다면
						$('#checkPassword').html('비밀번호 일치');
						$('#checkPassword').css('color', 'green');
						$('#checkPassword').css('font-weight', 'bold');
						$('#join-button').removeAttr('disabled');
					} else {//아무것도 입력되지 않았다면
						$('#checkPassword').html(''); //아무것도 출력하지 않는다.
						$('#checkPassword').css('color', 'black');
						$('#checkPassword').css('font-weight', 'bold');
						$('#join-button').attr('disabled', 'disabled'); //비어있다면 가입버튼이 안눌림
					}
				})
				//비밀번호 일치 불일치

				//지역 select-box
				$('#bAdd1').on(
						'change',
						function() {
							var bAdd1 = $(this).val();
							var bAdd2 = $('#bAdd2');

							var seoul = "<option>종로구</option>"
									+ "<option>중구</option>"
									+ "<option>용산구</option>"
									+ "<option>성동구</option>"
									+ "<option>광진구</option>"
									+ "<option>동대문구</option>"
									+ "<option>중랑구</option>"
									+ "<option>성북구</option>"
									+ "<option>강북구</option>"
									+ "<option>도봉구</option>"
									+ "<option>노원구</option>"
									+ "<option>은평구</option>"
									+ "<option>서대문구</option>"
									+ "<option>마포구</option>"
									+ "<option>양천구</option>"
									+ "<option>강서구</option>"
									+ "<option>구로구</option>"
									+ "<option>금천구</option>"
									+ "<option>영등포구</option>"
									+ "<option>동작구</option>"
									+ "<option>관악구</option>"
									+ "<option>서초구</option>"
									+ "<option>강남구</option>"
									+ "<option>송파구</option>"
									+ "<option>강동구</option>"

							var incheon = "<option>중구</option>"
									+ "<option>동구</option>"
									+ "<option>미추홀구</option>"
									+ "<option>연수구</option>"
									+ "<option>남동구</option>"
									+ "<option>부평구</option>"
									+ "<option>계양구</option>"
									+ "<option>서구</option>"
									+ "<option>강화군</option>"
									+ "<option>옹진군</option>"

							var busan = "<option>중구</option>"
									+ "<option>서구</option>"
									+ "<option>동구</option>"
									+ "<option>영도구</option>"
									+ "<option>부산진구</option>"
									+ "<option>동래구</option>"
									+ "<option>남구</option>"
									+ "<option>북구</option>"
									+ "<option>해운대구</option>"
									+ "<option>사하구</option>"
									+ "<option>금정구</option>"
									+ "<option>강서구</option>"
									+ "<option>연제구</option>"
									+ "<option>수영구</option>"
									+ "<option>사상구</option>"
									+ "<option>기장군</option>"

							var jeju = "<option>제주시</option>"
									+ "<option>서귀포시</option>"

							var gyeonggi = "<option>수원시</option>"
									+ "<option>수원시 장안구</option>"
									+ "<option>수원시 권선구</option>"
									+ "<option>수원시 팔달구</option>"
									+ "<option>수원시 영통구</option>"
									+ "<option>성남시</option>"
									+ "<option>성남시 수정구</option>"
									+ "<option>성남시 중원구</option>"
									+ "<option>성남시 분당구</option>"
									+ "<option>의정부시</option>"
									+ "<option>안양시</option>"
									+ "<option>안양시 만안구</option>"
									+ "<option>안양시 동안구</option>"
									+ "<option>부천시</option>"
									+ "<option>평택시</option>"
									+ "<option>광명시</option>"
									+ "<option>동두천시</option>"
									+ "<option>안산시</option>"
									+ "<option>안산시 상록구</option>"
									+ "<option>안산시 단원구</option>"
									+ "<option>고양시</option>"
									+ "<option>고양시 덕양구</option>"
									+ "<option>고양시 일산동구</option>"
									+ "<option>고양시 일산서구</option>"
									+ "<option>과천시</option>"
									+ "<option>구리시</option>"
									+ "<option>남양주시</option>"
									+ "<option>오산시</option>"
									+ "<option>시흥시</option>"
									+ "<option>군포시</option>"
									+ "<option>의왕시</option>"
									+ "<option>하남시</option>"
									+ "<option>용인시</option>"
									+ "<option>용인시 처인구</option>"
									+ "<option>용인시 기흥구</option>"
									+ "<option>용인시 수지구</option>"
									+ "<option>파주시</option>"
									+ "<option>이천시</option>"
									+ "<option>안성시</option>"
									+ "<option>김포시</option>"
									+ "<option>화성시</option>"
									+ "<option>광주시</option>"
									+ "<option>양주시</option>"
									+ "<option>포천시</option>"
									+ "<option>여주시</option>"
									+ "<option>연천군</option>"
									+ "<option>가평군</option>"
									+ "<option>양평군</option>"

							var gyeongsang = "<option>대구광역시</option>"
									+ "<option>포항시</option>"
									+ "<option>포항시 남구</option>"
									+ "<option>포항시 북구</option>"
									+ "<option>경주시</option>"
									+ "<option>김천시</option>"
									+ "<option>안동시</option>"
									+ "<option>구미시</option>"
									+ "<option>영주시</option>"
									+ "<option>영천시</option>"
									+ "<option>상주시</option>"
									+ "<option>문경시</option>"
									+ "<option>경산시</option>"
									+ "<option>군위군</option>"
									+ "<option>의성군</option>"
									+ "<option>청송군</option>"
									+ "<option>영양군</option>"
									+ "<option>영덕군</option>"
									+ "<option>청도군</option>"
									+ "<option>고령군</option>"
									+ "<option>성주군</option>"
									+ "<option>칠곡군</option>"
									+ "<option>예천군</option>"
									+ "<option>봉화군</option>"
									+ "<option>울진군</option>"
									+ "<option>울릉군</option>"

							var jeonla = "<option>광주광역시</option>"
									+ "<option>전주시</option>"
									+ "<option>전주시 완산구</option>"
									+ "<option>전주시 덕진구</option>"
									+ "<option>군산시</option>"
									+ "<option>익산시</option>"
									+ "<option>정읍시</option>"
									+ "<option>남원시</option>"
									+ "<option>김제시</option>"
									+ "<option>완주군</option>"
									+ "<option>진안군</option>"
									+ "<option>무주군</option>"
									+ "<option>장수군</option>"
									+ "<option>임실군</option>"
									+ "<option>순창군</option>"
									+ "<option>고창군</option>"
									+ "<option>부안군</option>"

							var gangwon = "<option>춘천시</option>"
									+ "<option>원주시</option>"
									+ "<option>강릉시</option>"
									+ "<option>동해시</option>"
									+ "<option>태백시</option>"
									+ "<option>속초시</option>"
									+ "<option>삼척시</option>"
									+ "<option>홍천군</option>"
									+ "<option>횡성군</option>"
									+ "<option>영월군</option>"
									+ "<option>평창군</option>"
									+ "<option>정선군</option>"
									+ "<option>철원군</option>"
									+ "<option>화천군</option>"
									+ "<option>양구군</option>"
									+ "<option>인제군</option>"
									+ "<option>고성군</option>"
									+ "<option>양양군</option>"

							if (bAdd1 == '서울') {
								bAdd2.empty();
								bAdd2.html(seoul);
							} else if (bAdd1 == '인천') {
								bAdd2.empty();
								bAdd2.html(incheon);
							} else if (bAdd1 == '부산') {
								bAdd2.empty();
								bAdd2.html(busan);
							} else if (bAdd1 == '제주도') {
								bAdd2.empty();
								bAdd2.html(jeju);
							} else if (bAdd1 == '경기도') {
								bAdd2.empty();
								bAdd2.html(gyeonggi);
							} else if (bAdd1 == '경상도') {
								bAdd2.empty();
								bAdd2.html(gyeongsang);
							} else if (bAdd1 == '전라도') {
								bAdd2.empty();
								bAdd2.html(jeonla);
							} else if (bAdd1 == '강원도') {
								bAdd2.empty();
								bAdd2.html(gangwon);
							}
						})
						
			//해시
			$('#addHash').on('keyup', function(e){
				//이벤트가 발생할 객체이기 때문에 그 입력된 키를 받아와야 하기 때문에 매개변수가 필요하다
				
				if(e.keyCode == 13){
					var hashTag = $(this).val(); //입력된 값을 hashTag에 담는다.
					
					$('#tags').append('<li>#'+hashTag+'</li>'); //append란 괄호안에 있는 내용들을 채워준다. 
					$('#tags').append('<input type=hidden name=hashTag value=#'+hashTag+'>'); //자체가 html태그이다. 
					//실제 작업을 처리하기 위해 추가한다. submit하면 hashTag값이 넘어가는 실질적인 부분이다. 
					
					//위에서 가져온 hashTag를 가져온다. 
					//엔터를 치고 나면 칸을 비워준다.
					$(this).val(""); //공백으로 바꿔준다. 
 				}
			})
			

		})
		//form태그에서 사용할 함수를 만들어준다. 
		//해시태그를 위해 만들음
		//document.ready를 하기 전에 이거먼저 읽어옴 
		function captureReturnKey(e){
			if(e.keyCode==13 && e.srcElement.type != 'textarea') 
				//해시태그를 위한 함수이긴 하지만 textarea빼고 모든 input태그에 적용되는 것이다. 
				//이벤트가 일어난 부분이 textarea가 아니면 (textarea에서는 엔터를 쳐서 줄바꿈을 할 수 있어야 한다.)
				return false; //엔터키를 누르면 submit으로 넘어가는걸 막아주는 것이다.
		}
</script>


</head>
<body>
	<div id="wrap">
		<div id="container">
			<div class="header">
				<div class="menu">
					<div class="menu-food">
						<div class="menu-food-i">
							<i class="fas fa-check"></i>
							<!-- check 아이콘 -->
						</div>
						<a href="main-food.jsp"> <img src="img/food.png">
							<p>Food</p>
						</a>
					</div>
					<div class="menu-cafe">
						<a href="main-food.jsp"> <img src="img/cafe.png">
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
					String sessionID = (String) session.getAttribute("sessionID");

					if (sessionID != null) {
				%>
				<!-- sessionID가 있을 경우 → 로그인 했을경우 -->
				<div class="member2">
					<div class="member-user">
						<a href="mypage.jsp">
							<p>${sessionID}'s</p>
						</a>
					</div>
					<!--로그아웃-->
					<div class="member-logout">
						<a href="/YYProject/user?actionName=userLogout"><img
							src="img/logout.png">
							<p>Logout</p> </a>
					</div>
				</div>
				<%
					} else {
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



			<!-- food-write -->
			<!-- foodWrite는 서블릿 매핑값 -->
			<form action="/YYProject/UploadServlet" method="post"
				name="foodWrite" enctype="multipart/form-data" onkeydown="return captureReturnKey(event)">
				<!-- box안에 하나씩 input이 있기 때문에 엔터를 치면 바로 submit을 해버린다. 그래서 function captureReturnKey(e)를 만들어 사용한다.  -->
				<!-- 키를 눌렀을 때 form태그 자체에 이벤트를 걸어준 것이다. 그래서 어느부분에서 keydown이 일어나면 저 함수가 captureReturnKey(e) 실행된다.   -->
				<!-- return을 붙여주는 이유는 반환형을 form태그에 반환해주기 위해서이다.    -->
				<!--form의 name값은 a태그를 위한 자바스크립트 코드이기 때문에 사용한다. -->
				<div class="food-write">
					<div class="write-title">
						<h1>글 작성</h1>
					</div>

					<div class="write-left">
						<div class="bName">
							<p>가게명</p>
						</div>
						<div class="bTel">
							<p>전화번호</p>
						</div>
						<div class="bTime">
							<p>영업시간</p>
						</div>
						<div class="bImg">
							<p>대표이미지</p>
						</div>
						<div class="bAdd">
							<p>지역</p>
						</div>
						<div class="bLocation">
							<p>주소</p>
						</div>
						<div class="bKind">
							<p>음식 종류</p>
						</div>
						<div class="bMenu">
							<p>메뉴</p>
						</div>
						<div class="bInfo">
							<p>소개</p>
						</div>
						<div class="bHash">
							<p>해시태그</p>
						</div>
						<div class="bStar">
							<p>관리자 평점</p>
						</div>

					</div>
					<!-- write-left -->

					<input type="hidden" name="actionName" value="foodInsert">
					<!-- foodInsert는 팩토리 구분값-->
					<!-- servlet에서 여기 있는 actionName의 값으로 구분하기 때문에 servlet을 구분할 필요없다. -->

					<div class="write-right">
						<div class="bName">
							<input type="text" name="bName" required="required"
								placeholder="가게명을 입력하세요.">
						</div>
						<!-- bName -->
						<div class="bTel">
							<input type="text" name="bTel" required="required"
								placeholder="00-0000-0000">
						</div>
						<!-- bTel -->
						<div class="bTime">
							<input type="text" name="bTime" required="required"
								placeholder="00:00~00:00">
						</div>
						<!-- bTime -->
						<div class="bImg">
							<input type="file" name="bImg" required="required">
						</div>
						<!-- bImg -->

						<!-- selectBox -->
						<div class="bAdd">
							<select name="bAdd1" onchange="addChange()" id="bAdd1">
								<option>--도.시--</option>
								<option value='서울'>서울</option>
								<option value='인천'>인천</option>
								<option value='부산'>부산</option>
								<option value='제주도'>제주도</option>
								<option value='경기도'>경기도</option>
								<option value='경상도'>경상도</option>
								<option value='전라도'>전라도</option>
								<option value='강원도'>강원도</option>
							</select> <select name="bAdd2" id="bAdd2">
								<option>--시.군--</option>
							</select>
						</div>
						<!-- bAdd -->
						<!-- 우편번호(주소) -->
						<div class="bLocation">
							<input type="text" id="sample4_roadAddress" name="bLocation"
								placeholder="도로명주소" required="required"> <input type="button"
								class="bLocationBtn" onclick="sample4_execDaumPostcode()"
								value="우편번호 찾기"><br> <span id="guide" st
								yle="color:#999"></span>

							<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
							<script>
								//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
								function sample4_execDaumPostcode() {
									new daum.Postcode(
											{
												oncomplete : function(data) {
													// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

													// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
													// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
													var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
													var extraRoadAddr = ''; // 도로명 조합형 주소 변수

													// 법정동명이 있을 경우 추가한다. (법정리는 제외)
													// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
													if (data.bname !== ''
															&& /[동|로|가]$/g
																	.test(data.bname)) {
														extraRoadAddr += data.bname;
													}
													// 건물명이 있고, 공동주택일 경우 추가한다.
													if (data.buildingName !== ''
															&& data.apartment === 'Y') {
														extraRoadAddr += (extraRoadAddr !== '' ? ', '
																+ data.buildingName
																: data.buildingName);
													}
													// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
													if (extraRoadAddr !== '') {
														extraRoadAddr = ' ('
																+ extraRoadAddr
																+ ')';
													}
													// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
													if (fullRoadAddr !== '') {
														fullRoadAddr += extraRoadAddr;
													}

													// 우편번호와 주소 정보를 해당 필드에 넣는다.
													document
															.getElementById('sample4_roadAddress').value = fullRoadAddr;

													// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
													if (data.autoRoadAddress) {
														//예상되는 도로명 주소에 조합형 주소를 추가한다.
														var expRoadAddr = data.autoRoadAddress
																+ extraRoadAddr;
														document
																.getElementById('guide').innerHTML = '(예상 도로명 주소 : '
																+ expRoadAddr
																+ ')';

													} else {
														document
																.getElementById('guide').innerHTML = '';
													}
												}
											}).open();
								}
							</script>
						</div>
						<!-- bLocation -->
						<div class="bKind">
							<input type="checkbox" name="bKind" value="한식">한식 <input
								type="checkbox" name="bKind" value="양식">양식 <input
								type="checkbox" name="bKind" value="중식">중식 <input
								type="checkbox" name="bKind" value="일식">일식<br> <input
								type="checkbox" name="bKind" value="이태리음식">이태리음식 <input
								type="checkbox" name="bKind" value="남미음식">남미음식 <input
								type="checkbox" name="bKind" value="아시아음식">아시아음식 <input
								type="checkbox" name="bKind" value="동남아음식">동남아음식<br>

							<input type="checkbox" name="bKind" value="레스토랑">레스토랑 <input
								type="checkbox" name="bKind" value="맥주,호프">맥주,호프 <input
								type="checkbox" name="bKind" value="바">바 <input
								type="checkbox" name="bKind" value="브런치">브런치<br>
						</div>
						<div class="bMenu">
							<div class="bMenu1">
								<div class="bMenu1-Img">
									<input type="file" name="bMenu1-Img" required>
								</div>
								<div class="bMenu1-Detail">
									<input type="text" name="bMenu1-Detail"
										placeholder="메뉴명(가격)을 입력하세요." required>
								</div>
							</div>
							<div class="bMenu2">
								<div class="bMenu2-Img">
									<input type="file" name="bMenu2-Img" required>
								</div>
								<div class="bMenu2-Detail">
									<input type="text" name="bMenu2-Detail"
										placeholder="메뉴명(가격)을 입력하세요." required>
								</div>
							</div>
							<div class="bMenu3">
								<div class="bMenu3-Img">
									<input type="file" name="bMenu3-Img" required>
								</div>
								<div class="bMenu3-Detail">
									<input type="text" name="bMenu3-Detail"
										placeholder="메뉴명(가격)을 입력하세요." required>
								</div>
							</div>
						</div>
						<!-- bMenu -->
						<div class="bInfo">
							<textarea name="bInfo" rows="9" cols="100"
								placeholder="소개글을 입력하세요." required="required"></textarea>
						</div>
						<!-- bInfo -->
						<div class="bHash">
							<input type="text" id="addHash" placeholder="#해시태그">
							<!-- 입력하고 엔터를 치면 넘어감 -->
							<ul id="tags">
								<!-- 엔터칠때마다 아래 쳐지게 한다.  -->
							</ul>
						</div>
						<!-- bHash -->
						 
						<div class="bStar">
						<input type="hidden" name="bStar" class="score" value="0">
							<i class="far fa-star one"></i>
							<i class="far fa-star two"></i>
							<i class="far fa-star three"></i>
							<i class="far fa-star four"></i>
							<i class="far fa-star five"></i>
						</div>
						<!-- bStar -->
					</div>
					<!-- write-right -->
				</div>
				<!-- food-write -->
				<!-- bWriteBtn -->
				<div class="bWriteBtn">
					<input type="submit" value="작성하기">
				</div>
				<!-- bWriteBtn -->
			</form>


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
						placeholder="id" autocomplete="off" required autofocus="autofocus">

				</div>
				<div class="login-password">
					<i class="fas fa-unlock"></i> <input type="password"
						name="password" placeholder="password" autocomplete="off" required>

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
						placeholder="name" autocomplete="off" required
						autofocus="autofocus">
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
					<i class="fas fa-unlock"></i> <input type="password"
						id="repassword" name="repassword" placeholder="repassword"
						autocomplete="off" required>
					<p id="checkPassword"></p>
					<!-- 비밀번호 일치or불일치 나타남 -->
				</div>


				<div class="join-email">
					<i class="fas fa-envelope"></i> <input type="email" name="email"
						placeholder="e-mail" autocomplete="off" required>
				</div>
			</div>
			<div class="join-bottom">
				<div class="join-button">
					<input type="submit" value="join" id="join-button" disabled>
					<!-- 작동 or 작동x -->
				</div>
			</div>
		</form>
	</div>
	<!--join.html-->

</body>
</html>
