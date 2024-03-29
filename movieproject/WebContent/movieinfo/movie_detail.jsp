<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
<link rel="stylesheet" href="../movieui/css/mstyles.css" />
<link rel="stylesheet" href="../MovieProject/movieui/css/mstyles.css" />
<meta charset="UTF-8">
<title>영화 상세 정보</title>
<style>
.main-body {
  position: relative;
}
.main-contents {
  display: flex;
  flex-direction: column;
}
.movie-info {
  margin: 30px;
  width: 90%;
}
.movie-info:first-child {
  margin: 40px;
}
.movie-info__upper {
  width: 70%;
  padding-bottom: 70px;
}

.movie__title {
  font-size: 37px;
  font-weight: 500;
  border-bottom: 2px solid rgba(0, 0, 0, 0.1);
  padding: 30px 0;
  padding-bottom: 55px;
  margin-bottom: 30px;
}
.movie__detail-img {
  position: absolute;
  top: 160px;
  left: 70%;
}
.movie__detail-each {
  font-size: 20px;
  margin-bottom: 20px;
}
.movie__detail-head {
  font-weight: 700;
}
.lower {
  padding-top: 25px;
  margin-bottom: 15px;
}
.head{
	padding-bottom: 15px;
	font-size: 23px;
}
.movie__detail-detail{
  border-top: 1px solid black;
  padding: 15px 0;
  margin-top: 15px;
  white-space: pre-line;
}
.movie__video{
	display: flex;
	justify-content: center;
}
.movie-info__review {
  font-weight: 700;
  font-size: 25px;
  border-bottom: 2px solid rgba(0, 0, 0, 0.1);
  padding-bottom: 20px;
  margin: 20px 0;
}
.movie-review__btn {
  	display: inline;
  	float:right;
}
.mtitle{
	float:left;
}
.avg{
	float:right;
	font-size: 27px;
	padding-top: 10px;
}
</style>
</head>
<body>
	<!--main 화면 header start-->
	<!-- 로그인 전과 후, 관리자 모두 볼 수 있는 페이지 -->
    <div class="main-bar">
      <div class="main-bar__column">
        <span
          ><a href="/MovieProject/moviemain.do"><img src="<%=request.getContextPath() %>/movieui/css/screen/images/logo.png" /></a
        ></span>
      </div>
      <div class="main-bar__column">
        <span>
          <a class="main-bar__movie" href="/MovieProject/moviemain.do">홈</a>
          <a class="main-bar__movie" href="/MovieProject/movieselect.do">영화정보</a>
        </span>
      </div>
      <c:if test="${session_id == null }">
      <div class="main-bar__column">
        <span><a class="main-bar__btn" href="/MovieProject/userjoin.do">로그인</a></span>
        <span>|</span>
        <span><a class="main-bar__btn" href="/MovieProject/requserjoin.do">회원가입</a></span>
      </div>
      </c:if>
      <c:if test="${session_id != null }">
      <div class="main-bar__column">
        <span><a class="main-bar__btn">${session_id } 님 환영합니다!</a></span>
        <span>|</span>
        <c:if test="${session_admin == 1 }">
        <span><a class="main-bar__btn" href="/MovieProject/movieadminmain.do">관리자페이지</a></span>
        </c:if>
        <c:if test="${session_admin == 0 }">
        <form class="main-bar__btn"  action = "/MovieProject/userdetail.do" method = "post">
		<input type = "hidden" name = "uId" value = "${session_id }" />
		<input type = "submit" value = "마이페이지" />
		</form>
        </c:if>
        <span>|</span>
        <span><a class="main-bar__btn" href="/MovieProject/userlogout.do">로그아웃</a></span>
      </div>
      </c:if>
    </div>
    <!-- main 화면 header end-->
	<!-- BODY START -->
	<div class="main-body">
      <div class="main-sidebar"></div>
      <div class="main-contents">
      
      
		<div class="movie-info">
			<div class="movie-info__upper">
				<div class="movie__detail">
	              	<div class="movie__title">
	             		<div class="mtitle"> ${movie.mtitle }</div>
	              	<div class="avg">
	              	평점 |
	              	<c:set var="avg" value="${avg }" /> 
	              	<c:choose>
	              	<c:when test="${1 > avg.rRate}">☆☆☆☆☆</c:when>
	              	<c:when test="${1.6 >= avg.rRate}">★☆☆☆☆</c:when>
	              	<c:when test="${2.6 >= avg.rRate}">★★☆☆☆</c:when>
	              	<c:when test="${3.6 >= avg.rRate}">★★★☆☆</c:when>
	              	<c:when test="${4.6 >= avg.rRate}">★★★★☆</c:when>
	              	<c:when test="${4.6 < avg.rRate}">★★★★★</c:when>
	              	</c:choose>
	              	${avg.rRate }
	              	</div>
	              	
	              	 </div>
		              <div class="movie__detail-each">
		                <span class="movie__detail-head">개요&nbsp;</span>|
		                &nbsp;${movie.mgenre } &nbsp;|&nbsp; ${movie.mcountry } &nbsp;|&nbsp; 
		                ${movie.mtime } &nbsp;|&nbsp; ${movie.mpremiere }
		                
						<!-- 찜 버튼 -->
						<c:if test="${session_id != null }">
							<c:if test="${favoritemovie == 0}">
								<form class="movie-review__btn" action="/MovieProject/favoritemovieinsert.do" method="post">
									<input type="hidden" name="mid" value="${movie.mid }" />
									<input type="hidden" name="uid" value="${session_id }" />
									<input type="submit" value="찜하기" class="btn btn-dark">
								</form>
							</c:if>
							<c:if test="${favoritemovie == 1}">
								<form class="movie-review__btn" action="/MovieProject/favoritemoviedelete.do" method="post">
									<input type="hidden" name="mid" value="${movie.mid }" />
									<input type="hidden" name="uid" value="${session_id }" />
									<input type="submit" value="찜 취소" class="btn btn-dark">
								</form>
							</c:if>
							<c:if test="${favorite_result == 1 }">
								<script>alert("찜목록에 저장되었습니다.");</script>
							</c:if>
							<c:if test="${favorite_result == 0 }">
								<script>alert("저장에 실패했습니다.");</script>
							</c:if>
						</c:if>
						<!-- 찜 버튼 끝 -->
		              </div>	
				
		              <div class="movie__detail-each">
		                <span class="movie__detail-head">감독&nbsp;</span>|
		                &nbsp;${movie.mdirector }
		              </div>
				
		             <div class="movie__detail-each">
		                <span class="movie__detail-head">출연&nbsp;</span>|
		                &nbsp;${movie.mactor }
		              </div>
				
		              <div class="movie__detail-each">
		                <span class="movie__detail-head">등급&nbsp;</span>|
		                &nbsp;${movie.mgrade }
		              </div>
            		</div>
            	</div>
			<c:if test="${session_admin == 1}">
			<form class="movie-review__btn" action="/MovieProject/movieupdate.do?mId=${movie.mid }" method="post">
				<input type="submit" value="영화 수정" class="btn btn-dark">
			</form>
			</c:if>
            <div class = "movie-info__lower lower">
	            <div class="movie__detail-each">
	              <span class="movie__detail-head head">줄거리</span>
	              	<div class="movie__detail-detail">
	              	${movie.mplot}
	              	</div> 
	            </div>            			
		    </div>
           	<div class="movie__detail">
              <div class="movie__detail-img">
                <img
                  src="${movie.mposter }"
                  width="240px"
                  height="339px"
                />
              </div>
            </div>
		</div>
		<div class="movie-info">
			<div class="movie__video">
				<script type="text/javascript">
					var address = "${mPaddress }";
					address = address.replace("watch?v=", "embed/");
					document.write("<iframe width='1120' height='630' src='" + address + "' title='YouTube video player' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe>");
				</script>
			</div>
		</div>
        <div class="movie-info">
          <h1 class="movie-info__review">리뷰 목록</h1>
          <form action="/MovieProject/moviereviewdetail.do" method="post">
            <input type="hidden" name="mId" value="${movie.mid }" />
            <input type="submit" value="리뷰 더보기" class="btn btn-dark" />
          </form>
          <table class="table table-hover">
            <thead>
              <tr>
                <th>회원아이디</th>
                <th>평점</th>
                <th>리뷰내용</th>
                <th>작성일</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="review" items="${reviewList}">
                <tr>
                  <td>${review.uId}</td>
                  <td><c:set var="selectedRate" value="${selectedRate }" />
						<c:choose>
							<c:when test="${1 eq review.rRate }">★</c:when>
							<c:when test="${2 eq review.rRate }">★★</c:when>
							<c:when test="${3 eq review.rRate }">★★★</c:when>
							<c:when test="${4 eq review.rRate }">★★★★</c:when>
							<c:when test="${5 eq review.rRate }">★★★★★</c:when>
						</c:choose></td>
                  <td>${review.rContent}</td>
                  <td>${review.rDate}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
			</div>
		</div>
      <div class="main-sidebar"></div>
    </div>
	<!-- BODY END -->
	
    <!-- footer start -->
	<div class="footer">
      <div class="footer-info">
        <div>CREATORS&nbsp;&nbsp;김지우 , 최재인 , 이한빈 , 김영훈</div>
        <div>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</div>
        <div>
          CONTACT&nbsp;&nbsp;<a href="https://github.com/GITJIWOO"
            >https://github.com/GITJIWOO</a
          >
        </div>
      </div>
      <div class="footer-copyright">
        <div>Copyright © MOVING All right reserved.</div>
      </div>
    </div>
	<!-- footer end -->
	
	<%-- 김영훈 임시작성 --%>
	<script type="text/javascript">
	
// 	// 즉시 실행함수 정의
// 	(function() {
		
// 		// insert 처리후 MovieWriteReviewService에서 반환 되는 모델 
// 		var resultMessage = '${resultMessage}';
		
// 		if(resultMessage != ''){ // 모델의 반환값이 없을 때 
		
// 			alert(resultMessage);
// 			if (resultMessage != 1) {	// 에러 반환시 뒤로가기
// 				window.history.back();
// 			}
			
// 		}
// 	})();
	
	function showMovieReviewInsertMsg () {
		// insert 처리후 MovieWriteReviewService에서 반환 되는 모델 
		var resultMessage = '${resultMessage}'; // 처리결과 메세지
		var resultCode = '${resultCode}'; // 처리결과 코드
		var mId = '${movie.mid }';
		
		if(resultMessage != ''){ // 모델의 반환값이 없을 때 
			alert(resultMessage);
			if (resultCode != 1) {	// 에러 반환시 뒤로가기
				window.history.back();
			} else { 
				location.href = '/MovieProject/moviedetail.do?mId='+mId; // 리뷰 등록 성공시 새로고침 
			}
		}
		
	}
	showMovieReviewInsertMsg();
	
	</script>
</body>
</html>