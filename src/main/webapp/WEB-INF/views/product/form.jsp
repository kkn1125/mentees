<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="menteePoint" value="${fn:length(getRecommend)}"/>
<fmt:parseNumber var="level" value="${menteePoint/100}" integerOnly="true"/>
<c:if test="${empty mentee}">
<jsp:forward page="/signin"/>
</c:if>
<div class="flex-grow-1">
	<div class="w-100 position-relative overflow-hidden" style="height: 50vh;">
		<img class="img-fluid" alt="cover" src="${edit!=null?edit.cover:'/resources/img/sample.jpg'}">
	</div>
    <!-- Main Section -->
    <div class="container d-lg-flex row-reverse">
        <!-- main content -->
        <div class="col-12 px-lg-3 mt-3 mt-lg-0" style="padding-top: 56px;">

            <div class="mb-3 pb-3">
                <div class="container-fluid">
                	<div class="">
               			<span class="d-flex justify-content-between align-items-center">
               				<span class="h2">프로그램 등록</span>
               				<span>
               					<span>등록자</span> 
	               				<span>
	               				${mentee.id!=''?mentee.id:'admin'}
	               				</span>
               				</span>
               			</span>
                	</div>
                	<hr>
                	<div>
                		<div>
							<form class="row g-3 custom-validate" action="/program/list${edit!=null?'/':''}${edit!=null?edit.num:''}" method="post" novalidate autocomplete="on" enctype="multipart/form-data">
								<c:if test="${edit!=null}">
									<input type="hidden" name="_method" value="put">
								</c:if>
								<div class="col-12">
									<label for="file" class="form-label">커버</label>
									<input type="file" class="form-control" name="file" id="file">
									<div data-valid="file"></div>
								</div>
								<div class="col-12">
									<label for="title" class="form-label">제목</label>
									<input type="text" class="form-control" name="title" id="title" placeholder="종로 세미나" value="${edit.title}" required>
									<div data-valid="title"></div>
								</div>
								<div class="col-md-4">
									<label for="start" class="form-label">시작일</label>
									<input pattern="[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}" required data-type="cur" type="datetime-local" class="form-control" name="dstart" id="start" required>
									<div data-valid="start"></div>
								</div>
								<div class="col-md-4">
									<label for="end" class="form-label">종료일</label>
									<input pattern="[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}" data-type="cur" type="datetime-local" class="form-control" name="dend" id="end" required>
									<div data-valid="end"></div>
								</div>
								<div class="col-4">
									<label for="until" class="form-label">마감기간</label>
									<input pattern="[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}" data-type="cur" type="datetime-local" class="form-control" name="duntil" id="until" required>
									<div data-valid="until"></div>
								</div>
								<div class="col-md-6">
									<label for="address" class="form-label">장소</label>
									<input type="text" class="form-control" name="address" id="address" value="${edit.address}" required>
									<div data-valid="address"></div>
								</div>
								<div class="col-md-4">
									<label for="type" class="form-label">프로그램 종류</label>
									<select name="type" id="type" class="form-select" required>
									<option value="" selected>선택하세요</option>
									<option value="seminar">세미나</option>
									<option value="lecture">강연</option>
									</select>
									<div data-valid="type"></div>
								</div>
								<div class="col-md-2">
									<label for="capacity" class="form-label">최대 인원</label>
									<input type="number" class="form-control" name="capacity" id="capacity" min="1" max="999" value="${edit!=null?edit.capacity:1}" required>
									<div data-valid="capacity"></div>
								</div>
								<div class="col-12">
									<%-- <label for="content" class="form-label"></label> --%>
									<textarea class="form-control" name="content" id="content" rows="3" required>${edit.content}</textarea>
									<div data-valid="content"></div>
								</div>
								<div class="col-md-12">
									<label for="tags" class="form-label">관련 태그</label>
									<div class="p-3 border rounded bg-white">
										<span class="tag-list"></span>
										<input type="text" style="width: 150px;" class="tag-input" id="tags" required>
										<input type="hidden" name="tags" value="${edit.tags}">
									</div>
								</div>
								<%-- <div class="col-12">
									<div class="form-check">
									<input class="form-check-input" type="checkbox" id="gridCheck">
									<label class="form-check-label" for="gridCheck">
										Check me out
									</label>
									</div>
								</div> --%>
                				<hr>
                				<input type="hidden" name="id" value="${mentee.id}">
								<div class="">
									<button type="submit" class="btn btn-lg btn-info">등록</button>
									<button class="btn btn-lg btn-secondary" onclick="location.href='/program/list'">취소</button>
								</div>
							</form>
                		</div>
                	</div>
                </div>
                
            </div>
            
        </div>

    </div>
</div>

<script>
if(${edit!=null}){
	document.querySelector("#type").value = "${edit.type}";
}
document.querySelectorAll('[data-type="cur"]').forEach((x)=>{
	x.min = new Date().toISOString().slice(0,-8);
	x.value = new Date().toISOString().slice(0,-8);
	if((${edit!=null})){
		let start;
		let end;
		let until;
		start = "${edit.start}";
		end = "${edit.end}";
		until = "${edit.until}";
		x.value = eval(x.name.slice(1)).slice(0,-5).replace(" ", "T");
	}
});
//wow
let itr = document.querySelector("#tags");
let tagList = document.querySelector(".tag-list");
let prt = tagList.parentNode;
let tagarr = [];
let inter = document.querySelector('[name="tags"]');
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
	span.classList.add("badge", "tag-info", "tag-1", "user-select-none");
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