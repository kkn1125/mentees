<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${not empty mentee}">
<jsp:forward page="/"/>
</c:if>
<div class="flex-grow-1">

	<div class="container-fluid container-lg mb-3">
		<div class="container mt-5 d-flex flex-md-row flex-column overflow-hidden">
			<div class="col-12 col-md-6 position-relative loginCover" data-select="false" data-event="false">
				<img class="img-fluid" style="filter: brightness(0.5)" src="/resources/img/cover/login.jpg" alt="login_cover" draggable="false">
				<div class="w-100 h1 text-center position-absolute top-50 start-50 translate-middle text-white">
					Hello Mentee!!
				</div>
			</div>
			<form name="delayForm" action="/signin" method="post"
				class="p-5 col-12 col-md-6 d-flex flex-column justify-content-center align-items-center" onsubmit="return delayLogin()">
				<input type="hidden" value="${referer}" name="referer">
				<div class="w-100">
					<div class="form-floating mb-3">
						<input type="email" class="form-control" name="email" id="email" required="required" placeholder=" " autofocus="autofocus" autocomplete="on">
						<label for="email">Email address</label>
					</div>
					<div class="form-floating">
						<input type="password" class="form-control" name="pw" id="password" required="required" placeholder=" ">
						<label for="password">Password</label>
					</div>
				</div>
				<div class="mt-2 w-100">
					<button type="submit" class="w-100 btn btn-lg btn-info rounded-0">로그인</button>
				</div>
				<div class="mt-2 w-100">
					<button type="button" class="w-100 btn btn-lg btn-success rounded-0" onclick="location.href='/signup'">회원가입</button>
				</div>
			</form>
		</div>
	</div>

</div>
<script type="text/javascript">
	function delayLogin(){
		let df = document.delayForm;
		let cover = document.querySelector('.loginCover');
		cover.classList.add("loading");
		df.classList.add("loading");
		let div = document.createElement('div');
		div.classList.add("text-center","fs-6","mt-3");
		div.innerHTML = `<div class="spinner-border text-light" role="status">
			  <span class="visually-hidden">Loading...</span>
			  </div>`;
		cover.lastElementChild.appendChild(div);
		setTimeout(()=>{
			df.submit();
		}, 2000);
		return false;
	}
</script>