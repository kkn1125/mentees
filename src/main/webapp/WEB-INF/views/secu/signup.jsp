<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="mentee" value="${sessionScope.mentee }"/>
<c:set var="tags" value="${mentee.interest}"/>
<div class="flex-grow-1">

	<div class="container-fluid container-lg my-3">
		<div class="container">
			<div class="h3">회원가입</div>
			<form class="row g-3 custom-validate border p-3 my-3" action="/signup" method="post" novalidate>
				<div class="col-md-4">
					<label for="id" class="form-label">아이디</label>
					<input type="text" class="form-control" name="id" id="id" value="" required>
					<div data-valid="id"></div>
				</div>
				<div class="col-md-4">
					<label for="pw" class="form-label">비밀번호</label>
					<input type="password" class="form-control" name="pw" id="pw" value="" required>
					<div data-valid="pw"></div>
				</div>
				<div class="col-md-4">
					<label for="name" class="form-label">이름</label>
					<input type="text" class="form-control" name="name" id="name" value="" required>
					<div data-valid="name"></div>
				</div>
				<div class="col-md-4">
					<label for="jumin" class="form-label">주민등록번호</label>
					<input type="text" class="form-control" name="jumin" id="jumin" value="" required>
					<div data-valid="jumin"></div>
				</div>
				<div class="col-md-4">
					<label for="email" class="form-label">이메일</label>
					<input type="email" class="form-control" name="email" id="email" value="" required>
					<div data-valid="email"></div>
				</div>
				<div class="form-floating">
					<textarea class="form-control" placeholder="Leave a comment here" name="msg" id="msg" style="height: 100px"></textarea>
					<label for="msg" class="ms-2">프로필 메세지</label>
				</div>
				<div class="col-md-6">
					<label for="address" class="form-label">주소지</label>
					<input type="text" class="form-control" name="address" id="address" required>
					<div data-valid="address"></div>
				</div>
				<div class="col-md-3">
					<label for="zip" class="form-label">우편번호</label>
					<input type="text" class="form-control" name="zip" id="zip" required>
					<div data-valid="zip"></div>
				</div>
				<div class="col-md-12">
					<label for="interest" class="form-label">관심분야</label>
					<div class="p-3 border rounded bg-white">
						<span class="tag-list"></span>
						<input type="text" style="width: 150px;" class="tag-input" id="interest" required>
						<input type="hidden" name="interest" value="${tags}">
					</div>
				</div>
				<div class="col-12">
					<div class="form-check">
						<input class="form-check-input" type="checkbox" value=""
							name="checks" id="checks">
						<label class="form-check-label" for="checks">광고 및 알림 허용</label>
					</div>
				</div>
				<div class="col-12">
					<button class="btn btn-primary" type="submit">Submit form</button>
				</div>
			</form>
		</div>
	</div>

</div>

<script type="text/javascript">
	//localStorage setting
	let checks = document.querySelector("#checks");
	let mentee = getLS();
	console.log(mentee)
	function initLS(){
		let ls = localStorage.getItem("mentee");
		if(ls==''||ls=='{}'){
			localStorage.setItem("mentee","{\"user\":{\"ad\":false}}");
		}
	}
	function getLS(data){
		initLS();
		let value = localStorage.getItem("mentee");
		if(data){
			value = JSON.parse(value);
			let re = value['user'][data];
			return re;
		}
		if(value.length>0){
			value = JSON.parse(value);
			return value;
		} else {
			return {};
		}
	}
	function addLS(k, v){
		let data = getLS();
		data[k] = v;
		mentee = data;  
		data = JSON.stringify(data);
		localStorage.setItem("mentee", data);
	}
	if(getLS("ad")){
		checks.setAttribute("checked","checked");
	} else {
		checks.removeAttribute("checked");
	}
	checks.addEventListener('change',(ev)=>{
		if(ev.target.checked){
			addLS('user',{ad: true});
		} else {
			addLS('user',{ad: false});
		}
	});
	
	// wow
	let itr = document.querySelector("#interest");
	let tagList = document.querySelector(".tag-list");
	let prt = tagList.parentNode;
	let tagarr = [];
	let inter = document.querySelector('[name="interest"]');
	let v = inter.value.indexOf('_')>-1?inter.value.replaceAll(' ','').split('_'):[];
	v.forEach(x=>{
		addTag(x);
	});
	
	function tagRender(){
		let tmp = document.createElement('span');
		if(tagList.childNodes.length>0){
			tagList.innerHTML = '';
		}
		let tmps = '';
		tagarr.forEach((x,ids)=>{
			tagList.append(x);
			if(ids==tagarr.length-1){
				tmps += x.innerText.slice(0,-1);
			}else{
				tmps += x.innerText.slice(0,-1)+'_';
			}
		});
		inter.value = tmps;
	}
	function addTag(data){
		let span = document.createElement("span");
		span.classList.add("badge", "tag-mentee", "tag-1", "tag");
		span.innerHTML = data+`<button type="button" class="btn btn-sm close tag-close">&times;</button>`;
		tagarr.push(span);
	}
	function removeLastTag(){
		tagarr.pop();
	}
	
	function removeTag(data){
		let idx = tagarr.indexOf(data);
		tagarr.splice(idx,1);
	}
	tagRender();
	itr.addEventListener('keydown',(ev)=>{
		if(ev.key===","){
			ev.preventDefault();
			let sp = itr.value.split(',')[0].split(" ");
			sp.forEach(x=>{
				addTag(x);
			});
			tagRender();
			itr.value = '';
		}
		if(ev.key==='Backspace' && itr.value.length==0){
			removeLastTag();
			tagRender();
		}
	});
	
	prt.addEventListener('click',(ev)=>{
		ev.preventDefault();
		itr.focus();
		if(ev.poiterType!="")
		if(ev.target.classList.contains('tag-close')){
			let test = ev.target;
			let parent = test.parentNode;
			removeTag(parent);
			tagRender();
		}
	});
</script>