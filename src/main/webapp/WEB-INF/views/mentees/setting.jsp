<%@page import="com.mentees.web.entity.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	Member member = session.getAttribute("mentee")!=null?(Member) session.getAttribute("mentee"):null;
	String tmp = "";
	if(member!=null){
		String pw = member.getPw();
		for(String i: pw.split("")){
			tmp+=0;
		}
		pageContext.setAttribute("fakePw", tmp);
	}
%>
<c:set var="tags" value="${fn:replace(mentee.interest,',','_')}"/>
<div class="flex-grow-1">
	
	<div class="container-fluid container-lg">
		<div class="container">
			<div class="h3">회원정보 수정</div>
			<form class="alert alert-light custom-validate border p-3 my-3" action="/mentees/setting/${mentee.num}" method="post" novalidate>
				<div class="row g-3">
					<input type="hidden" name="_method" value="put">
					<div class="col-md-4">
						<label for="id" class="form-label">아이디</label>
						<input type="text" class="form-control" name="id" id="id" value="${mentee.id}" required>
						<div data-valid="id"></div>
					</div>
					<div class="col-md-4">
						<label for="name" class="form-label">이름</label>
						<input type="text" class="form-control" name="name" id="name" value="${mentee.name}" required>
						<div data-valid="name"></div>
					</div>
					<div class="col-md-4">
						<label for="email" class="form-label">이메일</label>
						<input type="email" class="form-control" name="email" id="email" value="${mentee.email}" required>
						<div data-valid="email"></div>
					</div>
					<div class="col-md-4">
						<label for="pw" class="form-label">비밀번호</label>
						<input type="password" class="form-control" name="checkPw" id="checkPw" value="${fakePw}" required>
						<div data-valid="checkPw"></div>
					</div>
					<div class="col-md-4">
						<label for="checkPw" class="form-label">비밀번호 확인</label>
						<input type="password" class="form-control" name="pw" id="pw" required>
						<div data-valid="pw"></div>
					</div>
					<div class="form-floating">
						<textarea class="form-control" placeholder="Leave a comment here" name="msg" id="msg" style="height: 100px">${mentee.msg }</textarea>
						<label for="msg" class="ms-2">프로필 메세지</label>
					</div>
					<div class="col-md-4 pe-none user-select-none">
						<c:set var="sub" value="${fn:substring(mentee.jumin,0,fn:length(mentee.jumin)-6)}******"/>
						<label for="jumin" class="form-label">주민등록번호</label>
						<div class="form-control-plaintext" id="jumin">${sub}</div>
					</div>
					
					<div class="col-md-6">
						<label for="address" class="form-label">주소지</label>
						<input type="text" class="form-control" name="address" id="address" value="${mentee.address}" required>
						<div data-valid="address"></div>
					</div>
					<div class="col-md-3">
						<label for="zip" class="form-label">우편번호</label>
						<input type="text" class="form-control" name="zip" id="zip" value="${mentee.zip}" required>
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
							<input class="form-check-input" type="checkbox" 
								name="checks" id="checks">
							<label class="form-check-label" for="checks">광고 및 알림 허용</label>
						</div>
					</div>
					<div class="col-12">
						<button class="btn btn-primary" type="submit">수정</button>
						<button class="btn btn-secondary" type="button" onclick="history.back();">취소</button>
					</div>
				</div>
			</form>
			
			<div class="alert alert-danger p-5">
				<div class="text-danger h3">Danger Zone</div>
				<p>
					회원 탈퇴 및 휴면 신청에 관한 설정입니다. 신중하게 생각하시기 바랍니다.
				</p>
				
				<div class="border-3 border-start border-danger ps-2 py-1 h4 d-flex justify-content-between">
					<span class="py-1">회원 탈퇴</span>
				</div>
				<p>
					회원 탈퇴 후 계정복구 및 결제내용에 대한 모든 책임을 지지않습니다. 빠진 사항이 없는지 확인 하시고 탈퇴 진행하시기 바랍니다.
					회원님의 탈퇴로 발생하는 모든 불이익은 당사자에 있음을 알립니다.
				</p>
				<div class="text-end"><button class="col-2 btn btn-outline-danger" data-code="53448" onclick="check_danger(this)">탈퇴</button></div>
				<hr>
				<div class="border-3 border-start border-danger ps-2 py-1 h4 d-flex justify-content-between">
					<span class="py-1">계정 휴면 요청</span>
				</div>
				<p>
					계정 휴면 요청은 1개월 ~ 6개월간 모든 기능(로그인 포함)이 정지되며, 계정찾기 또한 불가합니다. MENTEES와 관련한
					모든 사항들이 정지되오니 신중한 결정 부탁드립니다. 계정 휴면을 중도 해지를 원하시면 '1:1 상담 요청하기'를 통해 신속한 도움을
					받으시길 바랍니다.
				</p>
				<div class="text-end"><button class="col-2 btn btn-outline-danger" data-code="50836" onclick="check_danger(this)">요청</button></div>
			</div>
			
		</div>
	</div>
	
</div>

<script type="text/javascript">

	function check_danger(self){
		let s = self.innerText;
		let sdc = self.dataset.code;
		let check = confirm("알림 사항을 충분히 숙지하셨습니까?\n"+s+"에 관한 내용에 동의한 것으로 간주됩니다.");
		if(check){
			if(String.fromCharCode(sdc)==='탈'){
				let frm = document.createElement("form");
				let ipt = document.createElement("input");
				ipt.type = "hidden";
				ipt.name = "_method";
				ipt.value = "delete";
				frm.append(ipt);
				frm.action = "/mentees/setting/${mentee.num}";
				frm.method = "post";
				frm.style.display = "none";
				document.body.prepend(frm);
				frm.submit();
			} else if(String.fromCharCode(sdc)==='요') {
				
			}
		} else {
			return false;
		}
	}
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
		span.classList.add("badge", "tag", "tag-mentee", "tag-1");
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