<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="flex-grow-1 p-5 exception">
	<div class="text-center mt-5">
		<span class="display-1 fw-bold">${exception.status}</span>
		<br>
		<span class="h3">${exception.code}</span>
		<br>
		<span>${exception.message}</span>
	</div>
	<div class="text-center mt-3">
		<button class="btn btn-outline-white text-white" onclick="location.href='/'">home</button>
		<button class="btn btn-outline-white text-white" onclick="history.back()">돌아가기</button>
	</div>
</div>