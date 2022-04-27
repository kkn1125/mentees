/**
 * 
 */

const likeBtn = document.querySelectorAll("[data-btn]");
const reserveBtn = document.querySelectorAll("[data-reserve]");
const delCommentBtn = document.querySelectorAll("[data-btn-comment]");
const delBtn = document.querySelectorAll("[data-del]");
const edtBtn = document.querySelectorAll("[data-edt]");
const rcdBtn = document.querySelectorAll("[data-recommend]");

window.addEventListener('load',()=>{
//	editBtns
	document.addEventListener('click', (ev)=>{
		if(edtBtn.length>0){
			let target = ev.target;
			let num = parseInt(target.dataset.edt);
			if(target.tagName === 'BUTTON' && target.dataset.edt){
				if(target.dataset.type!="feed"){
					location.href = "/program/form/"+num;
				} else {
					location.href = "/feedback/form/"+num;
				}
			}
		}
	});
	
//	deleteBtns
	document.addEventListener('click',(ev)=>{
		let target = ev.target;
		if(delBtn.length>0){
			let num = parseInt(target.dataset.del);
			if(target.tagName === 'BUTTON' && target.dataset.del){
				let result = confirm("삭제하시겠습니까?\n삭제 후 복구할 수 없습니다.");
				if(result){
					let frm = document.createElement("form");
					let input = document.createElement("input");
					if(target.dataset.type != "feed"){
						frm.action = "/program/list/"+num;
					} else {
						frm.action = "/feedback/list/"+num;
					}
					frm.method = "post";
					input.type = "hidden";
					input.name = "_method";
					input.value = "delete";
					frm.append(input);
					document.body.prepend(frm);
					frm.submit();
				}
			}
		}
	});
	
	likeBtn.forEach(x=>{
		let type = x.dataset.btn;
		if(type=="like" || type=="dislike"){
			x.addEventListener('click',(ev)=>{
				let num = x.previousElementSibling;
				let likes = x.offsetParent.querySelector('.likes');
				let check = num.value.split("-");
				check = check.filter(x=>x!=='');
				if(check.length==1){
					alert("로그인을 먼저 해주세요.");
					return;
				}
				if(x.dataset.btn == "like") {
					x.dataset.btn = "dislike";
					x.innerHTML = "관심 +1";
					x.classList.replace("btn-success","btn-danger");
					if(likes){
						likes.innerHTML = parseInt(likes.innerText)+1;
					}
					$.ajax({
						data:{
							num: check[0],
							pnum: parseInt(check[1])
						},
						method: "post",
						url: "/program/like",
						success: (data)=>{
	//						console.log(data);
						},
						error: (xhr, error)=>{
							console.error(error);
						}
					});
				} else {
					x.dataset.btn = "like";
					x.innerHTML = "관심";
					x.classList.replace("btn-danger","btn-success");
					if(likes){
						likes.innerHTML = parseInt(likes.innerText)-1;
					}
					$.ajax({
						data:{
							num: parseInt(check[0]),
							pnum: parseInt(check[1])
						},
						method: "post",
						url: "/program/dislike",
						success: (data)=>{
	//						console.log(data);
						},
						error: (xhr, error)=>{
							console.error(error);
						}
					});
				}
			});
		} else if(type=="feed" || type=="unfeed") {
			x.addEventListener('click',(ev)=>{
				let num = x.previousElementSibling;
				let likes = x.offsetParent.querySelector('.likes');
				let check = num.value.split("-");
				check = check.filter(x=>x!=='');
				if(check.length==1){
					alert("로그인을 먼저 해주세요.");
					return;
				}
				if(x.dataset.btn == "feed") {
					x.dataset.btn = "unfeed";
					x.innerHTML = `<i class="fas fa-bookmark"></i>`;
					x.classList.replace("btn-success","btn-danger");
					if(likes){
						likes.innerHTML = parseInt(likes.innerText)+1;
					}
					$.ajax({
						data:{
							mnum: parseInt(check[0]),
							fnum: parseInt(check[1])
						},
						method: "post",
						url: "/feedback/feed",
						success: (data)=>{
	//						console.log(data);
						},
						error: (xhr, error)=>{
							console.error(error);
						}
					});
				}
				else {
					x.dataset.btn = "feed";
					x.innerHTML = `<i class="far fa-bookmark"></i>`;
					x.classList.replace("btn-danger","btn-success");
					if(likes){
						likes.innerHTML = parseInt(likes.innerText)-1;
					}
					$.ajax({
						data:{
							mnum: parseInt(check[0]),
							fnum: parseInt(check[1]),
							_method: "delete"
						},
						method: "post",
						url: "/feedback/feed",
						success: (data)=>{
	//						console.log(data);
						},
						error: (xhr, error)=>{
							console.error(error);
						}
					});
				}
			});
		}
	});
	
	let firstBtn;
	let reserveHandler = (ev)=>{
		let target = ev.target;
		let reserve = target.dataset.reserve;
		let prev = target.previousElementSibling;
		if(target.dataset.btn=="reserve"){
			firstBtn = target;
		}
		if(target.tagName ==="BUTTON" && target.dataset.reserve){
			let sp = prev.value.split("-").filter(x=>x!='');
			let capa = target.parentNode.previousElementSibling.querySelector(".capa");
			let capaInt = parseInt(capa.innerText);
			if(sp.length==1){
				alert("로그인 후 신청 가능합니다.");
			} else {
				let mnum = sp[0];
				let pnum = sp[1];
//				console.log(mnum, pnum);
				if(eval(reserve)){
					target.dataset.reserve = "false";
					target.innerHTML = "신청취소";
					firstBtn.innerHTML = "✔신청";
					capa.innerHTML = capaInt+1;
					$.ajax({
						data:{
							mnum: mnum,
							pnum: pnum
						},
						url: '/reserve',
						method: 'post',
						success:(data)=>{
							console.log(data);
						},
						error:(xhr, error)=>{
							console.error(error);
						}
					});
				} else {
					target.dataset.reserve = "true";
					target.innerHTML = "신청하기";
					firstBtn.innerHTML = "신청";
					capa.innerHTML = capaInt-1;
					$.ajax({
						data:{
							"_method": "delete",
							mnum: mnum,
							pnum: pnum
						},
						url: '/reserve',
						method: 'post',
						success:(data)=>{
							console.log(data);
						},
						error:(xhr, error)=>{
							console.error(error);
						}
					});
				}
			}
		}
	}
	
	let deleteCommentHandler = (ev)=>{
		let target = ev.target;
		let data = target.dataset.btnComment;
		let num = target.dataset.commentN;
		let wrapper = target.parentNode.parentNode.parentNode;
		if(data=='del'){
			wrapper.classList.add("del");
			$.ajax({
				data:{
					_method: "delete"
				},
				method: "post",
				url: "/comment/"+num,
				success:(data)=>{
					console.log(data);
				},
				error:(xhr, error)=>{
					console.error(error);
				}
			});
			setTimeout(()=>{
				wrapper.remove();
			}, 1000);
		}
	};
	
	let replyHandler = (ev)=>{
		let target = ev.target;
		let data = target.dataset.btnComment;
		let num = target.dataset.commentN;
		let pnum = target.dataset.programN;
		let wrapper = target.parentNode.parentNode.parentNode;
		let frm = document.querySelector("[data-frm='origin']");
		let clone = document.querySelectorAll("[data-frm='clone']");
		if(data=='re'){
			if(clone && wrapper.querySelector('[data-frm="clone"]')){
				clone.forEach(x=>{
					x.remove();
				});
			} else {
				clone.forEach(x=>{
					x.remove();
				});
				let origin = frm.cloneNode(true);
				origin.classList.add("col-12");
				origin.dataset.frm = 'clone';
				let form = origin.querySelector("form");
				form.action = '/comment/reply';
				let input = document.createElement("input");
				input.type = "hidden";
				input.name = "ori";
				input.value = num;
				let input2 = document.createElement("input");
				input2.type = "hidden";
				input2.name = "pnum";
				input2.value = pnum;
				form.prepend(input);
				form.prepend(input2);
				wrapper.classList.add("reply");
				wrapper.append(origin);
			}
//			$.ajax({
//				data:{
//					_method: "delete"
//				},
//				method: "post",
//				url: "/comment/"+num,
//				success:(data)=>{
//					console.log(data);
//				},
//				error:(xhr, error)=>{
//					console.error(error);
//				}
//			});
//			setTimeout(()=>{
//				wrapper.remove();
//			}, 1000);
		}
	};
	
	window.addEventListener('click', replyHandler)
	window.addEventListener('click', deleteCommentHandler);
	window.addEventListener('click', recommendHandler);
	window.addEventListener('click', reserveHandler);
});

let recommendHandler = (ev)=>{
	let target = ev.target;
	if(target.tagName == 'BUTTON' && target.dataset.recommend){
		let recommend = target.dataset.recommend;
		let info = target.dataset.info.split('-');
		info = info.filter(x=>x!='');
		if(info.length==1){
			alert("로그인 하셔야 추천 가능합니다.");
			ev.preventDefault();
		}
		if(!ev.defaultPrevented){
			let recommender = info[0];
			let referral = info[1];
			let num = info[2];
			let count = target.offsetParent.querySelector('.order .badge');
			if(eval(recommend)){
				target.dataset.recommend = "false";
				target.innerHTML = "추천 + 1";
				count.innerHTML = parseInt(count.innerText)+1;
				$.ajax({
					data:{
						recommender: recommender,
						referral: referral
					},
					url: "/mentees/recommend",
					method: "post",
					success:(data)=>{
//						console.log(data);
					},
					error:(xhr, error)=>{
						console.error(error);
					}
				});
			} else {
				target.dataset.recommend = "true";
				target.innerHTML = "추천";
				count.innerHTML = parseInt(count.innerText)-1;
				$.ajax({
					data:{
						_method: "delete",
						recommender: recommender,
						referral: referral
					},
					url:"/mentees/recommend",
					method: "post",
					success:(data)=>{
//						console.log(data);
					},
					error:(chr, error)=>{
						console.error(error);
					}
				});
			}
		}
	}
}