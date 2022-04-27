<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="signin" value="${mentee.id}님 환영합니다."/>
<c:set var="signFailed" value="이메일과 비밀번호를 다시 확인해주세요."/>
<c:set var="signup" value="회원가입에 성공하였습니다. 로그인 해주세요."/>
<c:set var="signout" value="로그아웃 되었습니다."/>
<c:set var="deleteSign" value="🙋 좋은 멘토로 성장하시기를 바라며, 이용해주셔서 감사합니다."/>
<c:set var="editError" value="확인 비밀번호가 틀립니다. 다시 입력해주세요."/>
<c:set var="changePw" value="비밀번호가 변경되었습니다. 다시 로그인 해주세요."/>
<c:set var="changeInfo" value="회원정보가 수정되었습니다."/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- JQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- font awesome -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"
    integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm" crossorigin="anonymous">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- AOS css -->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<!-- google font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
    rel="stylesheet">
<link rel="stylesheet" href="/resources/css/main.css">
<!-- sun editor -->
<link href="https://cdn.jsdelivr.net/npm/suneditor@latest/dist/css/suneditor.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/suneditor@latest/dist/suneditor.min.js"></script>
<!-- languages (Basic Language: English/en) -->
<script src="https://cdn.jsdelivr.net/npm/suneditor@latest/src/lang/ko.js"></script>
<title><tiles:insertAttribute name="title"/></title>
</head>
<body>
	<div id="alertPop" class="alertPop${err!=null or param.err!=null?' show':''}">
		<c:if test="${param.err==0}">
			${signin}
		</c:if>
		<c:if test="${err==1}">
			${signFailed}
		</c:if>
		<c:if test="${err==2}">
			${signup}
		</c:if>
		<c:if test="${err==3}">
			${signout}
		</c:if>
		<c:if test="${param.err==4}">
			${deleteSign}
		</c:if>
		<c:if test="${param.err==5}">
			${editError}
		</c:if>
		<c:if test="${param.err==6}">
			${changePw}
		</c:if>
		<c:if test="${param.err==7}">
			${changeInfo}
		</c:if>
	</div>
	<div class="d-flex flex-column h-100" style="margin-top: 56px;">
	
		<!-- header -->
		<tiles:insertAttribute name="header"/>
		<!-- header -->

		<!-- body -->
		<tiles:insertAttribute name="body"/>
		<tiles:insertAttribute name="remote" ignore="true"/>
		<!-- body -->
	
		<!-- footer -->
		<tiles:insertAttribute name="footer"/>
		<!-- footer -->
		
	</div>
	<!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous">
    </script>
    <!-- AOS js -->
    <script src="https://unpkg.com/aos@next/dist/aos.js"></script>
    <script>
        AOS.init();
    </script>
    <script src="/resources/js/main.js"></script>
    <script src="/resources/js/imgController.js"></script>
    <script src="/resources/js/btnController.js"></script>
    <script src="/resources/js/ordered.js"></script>
    <script src="/resources/js/sunedit.js" defer></script>
</body>
</html>