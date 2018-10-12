<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<!--style-->

<link rel="stylesheet" href="css/main-cafe-style.css">
<link rel="stylesheet" href="css/location-food-style.css">
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
<title>location-food.jsp</title>
<script src='js/jquery-3.3.1.min.js'></script>
<script src='js/jquery.bpopup.min.js'></script>
<script src='js/score.js'></script> <!-- 별점구현을 위한 파일 -->
<script src='js/hash.js'></script>
<!--팝업창을 위한 파일-->
<!--로그인 팝업창 jquery-->
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
		
		//지도마커를 바꾸기 위해 위치를 아예열린상태로 실행하기 시작한다. 
		//그 후 코드를 실행시키면서 display none으로 바꾼다. 
		$('.list-detail').css('display', 'none');
	})

	
</script>
<!--로그인 팝업창 jquery-->

<!--회원가입 팝업창 jquery-->
<script>
	$(document).ready(function() {

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
		
	      //검색기능
	      //이벤트를 달기 위해선 document.ready안에 써야 함 
	      $("#search").on('keyup', function(e){ /*key가 눌렸다 올라올 때-뗐을때*/
	    	  //search가 e에 담김
	    	 
	      	var keyword =  $(this).val(); //this = id가 search인 것, val값을 가져옴
	    	var type = $("#type").val(); //select  
				 
	      	if(e.keyCode == 13){
		      	//alert(keyword); //enter키는 13이다.
	      		//사용자가 뭘 입력할지 모르니까 keyword를 +keyword+해서 넣어준다.
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
	      
	      
	      
	   // 클릭 시 detail나오게
	      $('.list > .list-view').on('click', function(){
	       var listNum = $(this).find('#listNum').val();   // 게시물 넘버를 가지고 온다.
	       var detailView = $(this).next('.list-detail-'+listNum);
	       //find는 자기의 자식노드를 찾는 것
	       //next는 자신과 같은 위치의 노드를 찾는 것

	       if(detailView.hasClass('open')){
	          detailView.removeClass('open');
	          detailView.addClass('close');
	          detailView.css('display', 'none');   // display라는 속성을 none으로 수정
	       }else if(detailView.hasClass('close')){
	          detailView.removeClass('close');
	          detailView.addClass('open');
	          detailView.css('display', 'block');   // display라는 속성을 none으로 수정
	       }
	      })
	      
		    //댓글 입력시 제한길이 초과
		    //keyup : 키를 눌렀다 뗐을 때 글자가 100글자 이상이면 발생
			$('.comment-maxlength').on('keyup', function() {

		        if($(this).val().length > 40) {
		        	alert('글자수 제한길이 초과');
		            $(this).val($(this).val().substring(0, 40));
		        }
		        
		        
    		});
	    
	      
	      //로그인 안하고 댓글 입력시 로그인 바랍니다.
				$('.comment-maxlength').on('click', function() {

					var userID = '${sessionID}';

					
					if(userID == "") {
			        	alert('로그인 해주세요.');
			        	$(this).blur(); //focus된것 지우기
			        } 
			         
			        
	    		});

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
					<input type="text" placeholder="검색어를 입력하세요." name="search"
						id="search"> <a href="#" id="searchI"><i
						class="fas fa-search"></i></a>
				</div>


				<!--search-bar-->
				<div class="hash">
					<h3 id="hotKeyword" class="black">Hot Keyword</h3>
					<a href="/YYProject/user?actionName=search&t=tbHash&k=데이트"> <!-- searchAction에서 type과 keyword를 t, k로 받아주기 때문에 바꾼다. -->
						<p>#데이트</p>
					</a> 
					<a href="/YYProject/user?actionName=search&t=tbHash&k=분위기">
						<p>#분위기</p>
					</a> 
					<a href="/YYProject/user?actionName=search&t=tbHash&k=친구랑">
						<p>#친구랑</p>
					</a> 
					<a href="/YYProject/user?actionName=search&t=tbHash&k=인스타">
						<p>#인스타</p>
					</a> 
					<a href="/YYProject/user?actionName=search&t=tbHash&k=핫플레이스">
						<p>#핫플레이스</p>
					</a> 
					<a href="/YYProject/user?actionName=search&t=tbHash&k=아늑한">
						<p>#아늑한</p>
					</a> 
					<a href="/YYProject/user?actionName=search&t=tbHash&k=드라이브">
						<p>#드라이브</p>
					</a> 
					<a href="/YYProject/user?actionName=search&t=tbHash&k=나들이">
						<p>#나들이</p>
					</a> 
					<a href="/YYProject/user?actionName=search&t=tbHash&k=고급진">
						<p>#고급진</p>
					</a>
				</div>
				<!--hash-->
			</div>
			<!--bar-->
			<!-- 관리자접속 -->
			<%
				String sessionID2 = (String) session.getAttribute("sessionID");
				if ("admin".equals(sessionID2)) {
			%>
			<!-- 관리자로 접속시만 보이는 글작성 버튼 -->
			<div class="writeAdmin">
				<a href="food-write.jsp" id="writeAdminBtn"><i
					class="fas fa-pencil-alt"></i></a>
			</div>
			<!-- 관리자로 접속하지 않았다면 -->
			<%
				} else {
				}
			%>
			<!-- 관리자접속 -->
			<div class="contents2">
				<div class="container2">
					<div class="title">
						<!--jstl태그
			조건이 1개일땐 c:if를 단독사용 가능
			조건이 여러개일땐 c:choose로 전체를 감싼 후, when(if또는 else if)과 otherwise(else)를 사용한다.
		-->
								
					<h1>< ${title }${keyword } 맛집 리스트 ></h1>
					</div>
					<!-- 제목 -->

					<!-- 리스트 -->
					<c:set var="i" value="1" />
					<c:forEach items="${list }" var="vo" begin="0" end="4">
						<!-- list(uploadServlet)안에 있는 것들을 하나씩 뽑아온다. -->
						<div class="list" id="list1">
							<!-- 게시물에 중복안되는 유일한 요소인 bNum를 줘서 클릭했을 때 같은 번호를 찾아서 열도록 함 -->
							<div class="list-view">
								<input type="hidden" id="listNum" name="listNum" value="${vo.getbNum() }">
								<div class="list-img">
									<img src="upload/${vo.getbImg() }">
								</div>
								<!-- 카페 사진 -->
								<div class="list-intro">
									<div class="list-intro-top">
										<div class="top-name">
											<p>${vo.getbName() }</p>
										</div>
										<!-- 가게이름 -->
										<!-- admin에서만 나타나게 -->
										<%
											String sessionID3 = (String) session.getAttribute("sessionID");
												if ("admin".equals(sessionID3)) {
										%>
										<div class="top-manage">
											<div class="board-modify">
												<a
													href="/YYProject/user?bNum=${vo.getbNum() }&actionName=boardUpdateForm"><p>수정</p></a>
											</div>

											<div class="board-delete">
												<a
													href="/YYProject/user?bNum=${vo.getbNum() }&actionName=boardDelete&l=${title}"><p>삭제</p></a>
											</div>
										</div>
										<%
											} else {
												}
										%>






										<!-- 별점 -->
										<div class="top-star">
											<div class="top-star-admin">
												<div class="star-admin">
													<h6>관리자평점</h6>
												</div>
												<div class="admins-star">
													<c:forEach begin="1" end="${vo.getbStar() }">
														<!-- val값에 따라 for문이 종료됨 -->
														<i class="fas fa-star"></i>
													</c:forEach>
													<c:forEach begin="1" end="${5 - vo.getbStar() }">
														<!-- 3개가 채워지면 5-2니까 그것만 출력 -->
														<i class="far fa-star"></i>
													</c:forEach>
												</div>
												<div class="admins-star-avg">
													<h6>${vo.getbStar() }/5</h6>
												</div>
											</div>
											<div class="top-star-user">
												<div class="star-user">
													<h6>사용자평점</h6>
												</div>
												<div class="users-star">
													<c:forEach begin="1" end="${vo.getcStar() }">
														<!-- val값에 따라 for문이 종료됨 -->
														<i class="fas fa-star"></i>
													</c:forEach>
													<c:forEach begin="1" end="${5 - vo.getcStar() }">
														<!-- 3개가 채워지면 5-2니까 그것만 출력 -->
														<i class="far fa-star"></i>
													</c:forEach>
												</div>
												<div class="users-star-avg">
													<h6>${vo.getcStar() }/5</h6>
												</div>
											</div>
										</div>
										<!-- 별점 -->






									</div>

									<div class="list-intro-bottom">
										<div class="bottom-intro">
											<div class="bottom-kind">
												<c:forEach items="${vo.getbKind() }" var="kind">
													<p>${kind }</p>
												</c:forEach>
											</div>
											<!-- 분류 -->
											<div class="bottom-location">
												<p>${vo.getbAdd1()}${vo.getbAdd2()}</p>
											</div>
											<!-- 위치 -->
											<div class="bottom-arrow">
												<i class="fas fa-arrow-circle-down"></i>
											</div>
											<!-- 화살표 -->
										</div>
										<!-- 분류, 위치 -->
										<div class="bottom-hash">
											<p>${vo.getbHash() }</p>
										</div>
										<!-- 해시태그 -->
									</div>
								</div>
								<!-- 카페 간단소개 -->
							</div>
							<!-- 리스트뷰 -->



							<div class="list-detail list-detail-${vo.getbNum() } close">
								<div class="detail-intro">
									<div class="intro-detail">
										<div class="intro-intro">
											<span>
												<p>
													<i class="fas fa-map-marker-alt"></i>${vo.getbLocation() }
												</p>
												<p>
													<i class="fas fa-phone"></i>${vo.getbTel() }
												</p>
												<p>
													<i class="far fa-clock"></i>${vo.getbTime() }
												</p>
											</span>
										</div>
										<div class="intro-contents">
											<h1>Introduce</h1>
											<p>${vo.getbInfo() }</p>
										</div>
									</div>

									<!-- intro-map -->
									<div class="intro-map">
										<div id="map${i}" style="width: 100%; height: 100%;"></div>

										<script type="text/javascript"
											src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a6f008212e1529b1308588e7741ffd94&libraries=services"></script>
										<script>
											var mapContainer = document
													.getElementById('map${i}'), // 지도를 표시할 div 
											mapOption = {
												center : new daum.maps.LatLng(
														33.450701, 126.570667), // 지도의 중심좌표
												level : 3
											// 지도의 확대 레벨
											};

											// 지도를 생성합니다    
											var map${i} = new daum.maps.Map(
													mapContainer, mapOption);

											// 주소-좌표 변환 객체를 생성합니다
											var geocoder = new daum.maps.services.Geocoder();

											// 주소로 좌표를 검색합니다
											geocoder
													.addressSearch(
															'${vo.getbLocation() }',
															function(result,
																	status) {

																// 정상적으로 검색이 완료됐으면 
																if (status === daum.maps.services.Status.OK) {

																	var coords = new daum.maps.LatLng(
																			result[0].y,
																			result[0].x);

																	// 결과값으로 받은 위치를 마커로 표시합니다
																	var marker${i} = new daum.maps.Marker(
																			{
																				map : map${i},
																				position : coords
																			});

																	// 인포윈도우로 장소에 대한 설명을 표시합니다
																	var infowindow = new daum.maps.InfoWindow(
																			{
																				content : '<div style="width:150px;text-align:center;padding:6px 0;">${vo.getbName() }</div>'
																			});
																	infowindow
																			.open(
																					map${i},
																					marker${i});

																	// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
																	map${i}
																			.setCenter(coords);
																}
															});
											
														/* $(document).ready(function(){
															$('.list > .list-view').on('click', function(){
																map${i}.relayout();
															})
														}) */
										</script>
									</div>
									<!-- intro-map -->
								</div>
								<div class="detail-menu">
									<h1>Menu</h1>
									<div class="menu1">
										<img src="upload/${vo.getbMenu1_Img() }">
										<h6>${vo.getbMenu1_Detail() }</h6>
									</div>
									<div class="menu2">
										<img src="upload/${vo.getbMenu2_Img() }">
										<h6>${vo.getbMenu2_Detail() }</h6>
									</div>
									<div class="menu3">
										<img src="upload/${vo.getbMenu3_Img() }">
										<h6>${vo.getbMenu3_Detail() }</h6>
									</div>
								</div>
								<!-- menu -->



								<!-- comment -->
								<div class="detail-reply">
									<form action="/YYProject/user" method="post">
										<input type="hidden" name="actionName" value="commentWrite">
										<input type="hidden" id="listNum" name="listNum" value="${vo.getbNum() }">
										<input type="hidden" name="l" value="${title }">
										<!-- 댓글작성란 -->
										<div class="reply-write">
											<div class="r-write-star">
												<input type="hidden" name="cStar" class="score" value="0">
												<i class="far fa-star one"></i> 
												<i class="far fa-star two"></i> 
												<i class="far fa-star three"></i> 
												<i class="far fa-star four"></i> 
												<i class="far fa-star five"></i> 
									
												
											</div>
											<div class="r-write-comment">
												<!-- 최대 입력 글자수 100 -->
												<input type="text" name="cContent" class="comment-maxlength"
													maxlength="100"
													placeholder="댓글을 입력하세요. 최대 한글 40자까지 가능합니다.">
											</div>
											<div class="r-write-button">
												<input type="submit" value="등록">
											</div>
										</div>
										<!-- 댓글작성란 -->

									</form>
									<!-- 댓글보이는곳 -->
									<div class="reple">
										<ul>
											<!-- 댓글 -->
											<!-- 게시글 자체가 foreach문으로 감싸져 있다.  -->
											<c:forEach items="${cList }" var="cVo"> <!-- var은 안에서 쓸 변수명 -->
												<!-- 위의 게시글 전체를 foreach문으로 감쌌는데 그거의 var명이 var="vo"이다. 
												아래의 vo.getbNum()은 저 변수명의 getbNum()을 말하는 것이다. -->
												<c:if test="${vo.getbNum() == cVo.getcReg_flag() }">
													<li>
														<div class="reple-star">
															<c:forEach begin="1" end="${cVo.getcStar() }">
																<i class="fas fa-star"></i>
															</c:forEach>
															<c:forEach begin="1" end="${5 - cVo.getcStar() }">
																<i class="far fa-star"></i>
															</c:forEach>
														</div>
														<div class="reple-content">
															<div class="content-reple">
																<p>${cVo.getcContent() }</p>
															</div>
															<div class="content-reple-user">
																<div class="reple-id">
																	<p>${cVo.getcId() }</p>
																</div><!-- 아이디 -->
																<div class="reple-date">
																	<p>${cVo.getcReg_date() }</p>
																</div><!-- 등록일자 -->
															</div>
														</div>
														
														<!-- 작성자의 댓글만 삭제버튼이 보이도록 한다. -->
														<div class="reple-button">
															<c:if test = "${sessionID.equals(cVo.getcId()) }">
																<div class="reple-delete">
																	<a href="/YYProject/user?actionName=commentDelete&c=${cVo.getcNum()}&l=${title}">삭제</a> 
																</div>
															</c:if>
														</div>
													</li>
												</c:if>
											</c:forEach>


										</ul>
									</div>
									<!-- 댓글보이는곳 -->
								</div>
								<!-- comment -->


							</div>
							<!-- 펼칠거 -->
						</div>
						<c:set var="i" value="${i+1 }" />
					</c:forEach>
					<!-- 리스트 -->


				</div>
				<!-- container -->
			</div>

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
							placeholder="id" autocomplete="off" required
							autofocus="autofocus">

					</div>
					<div class="login-password">
						<i class="fas fa-unlock"></i> <input type="password"
							name="password" placeholder="password" autocomplete="off"
							required>

					</div>
				</div>
				<!--login-middle-->
				<div class="login-bottom">
					<div class="login-button">
						<input type="submit" value="login">
					</div>
					<div class="forget-pwd">
						<input type="submit" value="forget password?">
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
							name="password" placeholder="password" autocomplete="off"
							required>
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
