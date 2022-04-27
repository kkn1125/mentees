<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="curPath" value="${requestScope['javax.servlet.forward.request_uri']}" scope="request"/>
<c:set var="path" value="/${fn:split(curPath, '/')[0]}/list"/>

<div class="remote text-center d-flex flex-column justify-content-start">
	<span class="badge bg-dark mb-3">
		MENU
	</span>
	<c:if test="${curPath==path}">
	<button class="mb-2 btn btn-sm btn-info" onclick="location.href='/'">메인</button>
	</c:if>
	<c:if test="${curPath!=path}">
	<button class="mb-2 btn btn-sm btn-info" onclick="location.href='${path}'">목록</button>
	</c:if>
	<button class="mb-2 btn btn-sm btn-secondary" onclick="history.back()">이전</button>
	<c:if test="${mentee==null}">
	<button class="mb-2 btn btn-sm btn-success" onclick="location.href='/signin'">
		Sign in<i class="fas fa-sign-in-alt"></i>
	</button>
	</c:if>
</div>