<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="cur" value="${requestScope['javax.servlet.forward.request_uri']}" scope="request"></c:set>
<nav class="navbar navbar-expand-lg navbar-light bg-white shadows fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand text-success fw-bold" href="${cur=='/'?'#':'/' }">MENTEES</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto col">
                <li class="nav-item">
                    <a class="nav-link${cur=='/program/list'?' active':null}" href="${cur=='/'?'#Mentees-프로그램':'/program/list'}">Mentees 프로그램</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link${cur=='/mentees/top'?' active':null}" href="${cur=='/'?'#지금-뜨는-멘티':'/#지금-뜨는-멘티'}">지금 뜨는 멘티</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link${cur=='/mentees/recommend'?' active':null}" href="${cur=='/'?'#추천-피드백':'/feedback/list'}">추천 피드백</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link${cur=='/about'?' active':null}" href="/about">About</a>
                </li>
            </ul>
            <div class="navbar-nav me-auto col col-lg-2 justify-content-end">
                <div class="nav-item">
                    <a class="nav-link" aria-current="page" href="#">
                    	<i class="far fa-bell"></i>
                    </a>
                </div>
                <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                        data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-user-cog"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="navbarDropdown">
                    	<c:if test="${mentee!=null}">
                        <li>
	                        <span class="ms-3 badge text-white">
	                        ${mentee.id}님 접속
	                        </span>
                        </li>
                        <li><a class="dropdown-item" href="/mentees#나의-멘토/멘티">나의 멘토/멘티</a></li>
                        <li><a class="dropdown-item" href="/mentees#멘티활동-기록">멘티활동 기록</a></li>
                        <li><a class="dropdown-item" href="/mentees">회원 정보</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        </c:if>
                        <li>
                        	<c:if test="${mentee==null}">
	                            <a class="dropdown-item" href="/signin">로그인</a>
	                            <a class="dropdown-item" href="/signup">회원가입</a>
                        	</c:if>
                        	<c:if test="${mentee!=null}">
	                            <a class="dropdown-item" href="/signout">로그아웃</a>
                        	</c:if>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>
<c:set var="slice" value="${fn:split(fn:substring(cur,1,-1),'/')}"/>
<c:set var="path" value=""/>
<c:if test="${slice[0]=='mentees'}">
	<div class="container-fluid">
		<nav class="bg-light border rounded-1 mt-2 mb-5" aria-label="breadcrumb">
		  <ol class="breadcrumb my-2 px-2">
		  	<li class="breadcrumb-item">🤷‍♂️ 여기가 어디지?</li>
		  	<li class="breadcrumb-item">
		  		<a href="/">home</a>
		  	</li>
		  	<c:forEach var="s" items="${slice}">
			  	<c:set var="path" value="${path}/${s}"/>
		    	<li class="breadcrumb-item${s==slice[fn:length(slice)-1]?' active':null}" ${s==slice[fn:length(slice)-1]?'aria-current="page"':null}>
		    	
		    	<c:if test="${s==slice[fn:length(slice)-1]}">
		    	${s}
		    	</c:if>
		    	
		    	<c:if test="${s!=slice[fn:length(slice)-1]}">
		    	<a href="${path=='/program'?'/':path}">${s}</a>
		    	</c:if>
		    	
		    	</li>
		  	</c:forEach>
		  </ol>
		</nav>
	</div>
</c:if>