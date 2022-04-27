/**
 * 
 */


'use strict';
let idx = 1;
window.addEventListener('load',()=>{
    let graph = document.querySelectorAll('[data-graph="bar"]').forEach((bar, index)=>{
        let span = document.createElement('span');
        setTimeout(()=>{
            let v = bar.dataset.value;
            span.classList.add('bar');
            span.style.width = `${v}%`;
            bar.previousElementSibling.querySelector('.point').innerHTML = 100 * (v/100);
            bar.appendChild(span);
        });
        setTimeout(()=>{
            span.classList.add('show');
        }, index*500);
    });

    document.querySelectorAll('[data-card="text"]').forEach(x=>{
		let textNode = x.innerText;
		if(textNode.length>100){
	        let tmp = textNode.slice(0, 100)+'...';
	        x.innerHTML = tmp;
		} else {
			x.innerHTML = textNode;
		}
    });

    let tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    let tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    });

    document.querySelectorAll('[data-copy="true"]').forEach(x=>{
        let url = x.parentNode.previousElementSibling.previousElementSibling.querySelector('.card-title a').href;
        x.addEventListener('click',(ev)=>{
            let ta = document.createElement('textarea');
            document.body.appendChild(ta);
            ta.value = url;
            ta.select();
            document.execCommand("Copy");
            document.body.removeChild(ta);
            // copy check alert
            let copyDone = document.createElement("div");
            copyDone.classList.add("copyDone");
            copyDone.innerHTML = "복사 되었습니다";
            ev.target.prepend(copyDone);
            copyDone.style.opacity = 1;
            setTimeout(()=>{
				copyDone.style.opacity = 0;
				setTimeout(()=>{
					copyDone.remove();
				}, 100);
			}, 2000);
        });
    });
    let alertPop = document.getElementById("alertPop");
    setTimeout(()=>{
	    if(alertPop.classList.contains('show')){
			alertPop.classList.replace('show','hide');
		}
	}, 3000);
//    let observer = new MutationObserver((mutations)=>{
//	    mutations.forEach(mutation=>{
//	        console.log(mutation)
//	    });
//	});
//	let observerConfig = {
//	    attributes: true,
//	    childList: true,
//	    characterData: true
//	};
//	observer.observe(alertPop, observerConfig);
	let ex = document.querySelector('.exception');
	let exChild = document.querySelectorAll('.exception .text-center>*');
	exChild.forEach(x=>{
		x.addEventListener('mouseenter',()=>{
			ex.style.transition = "1s ease 0.5s";
			ex.classList.add('hide');
		});
		x.addEventListener('mouseleave',()=>{
			ex.classList.remove('hide');
			ex.style.transition = "1s ease 0.5s";
		});
	});
	
	// validateHandler
	let submitHandler = (ev)=>{
		ev.preventDefault();
		let custom = ev.target;
		let result = true;
		custom.querySelectorAll('[data-valid]').forEach((key) => {
			let about, target, v;
			about = key.dataset.valid;
			target = document.getElementById(about);
			v=target.value;
			key.style.display = "block";
			setTimeout(()=>{
			key.style.opacity = 0.7;
			});
			switch(about){
				case 'id':
					if(v.length>5 && v.length <=20){
						key.innerHTML = "적합";
					} else {
						result = false;
						key.innerHTML = "아이디는 6자 이상 20자 이하 입력되어야 합니다.";
					}
				break;
				case 'name':
					if(v.length>0){
						if(v.match(/[가-힣]+/gi)){
							if(v.length>1){
								key.innerHTML = "적합";
							} else {
								key.innerHTML = "최소 두 글자 이상이어야 합니다.";
							}
						} else {
							key.innerHTML = "한글 외 문자는 허용되지 않습니다. (낱개 모음도 포함입니다.)";
						}
					} else {
						result = false;
						key.innerHTML = "필수 항목입니다.";
					}
				break;
				case 'email':
					let reg = /[0-9a-zA-Z]+@[a-zA-Z]+\.[a-zA-Z]+/
					if(reg.test(v)){
						key.innerHTML = "적합";
					} else {
						key.innerHTML = "필수 항목입니다.";
						result = false;
					}
				break;
				case 'checkPw':
					if(v.length>0){
						key.innerHTML = "적합";
					} else {
						result = false;
						key.innerHTML = "필수 항목입니다.";
					}
				break;
				case 'pw':
					let check = document.querySelector("[name='checkPw']");
					if(v.length>0){
						key.innerHTML = "적합";
					} else {
						result = false;
						key.innerHTML = "필수 항목입니다.";
						target.focus();
					}
				break;
				case 'jumin':
					if(v.length>0){
						if(v.match(/[0-9]{6}-[0-9]{7}/gi)){
							key.innerHTML = "적합";
						} else {
							key.innerHTML = "총 13자리를 적어야합니다.";
						}
					} else {
						result = false;
						key.innerHTML = "필수 항목입니다.";
					}
				break;
				case 'address':
					if(v.length>0){
						key.innerHTML = "적합";
					} else {
						result = false;
						key.innerHTML = "필수 항목입니다.";
					}
				break;
				case 'zip':
					if(v.length>0){
						key.innerHTML = "적합";
					} else {
						result = false;
						key.innerHTML = "필수 항목입니다.";
					}
				break;
				
				case 'title':
					if(v.length>0){
						let regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
						if(regExp.test(v)){
							key.innerHTML = "특수문자는 사용할 수 없습니다.";
						} else {
							key.innerHTML = "적합";
						}
					} else {
						result = false;
						key.innerHTML = "필수 항목입니다.";
					}
				break;
				case 'content':
					if(v.length>0){
						key.innerHTML = "적합";
					} else {
						result = false;
						key.innerHTML = "필수 항목입니다.";
					}
				break;
				case 'address':
					if(v.length>0){
						let regExp2 = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
						if(regExp2.test(v)){
							key.innerHTML = "특수문자는 사용할 수 없습니다.";
						} else {
							key.innerHTML = "적합";
						}
					} else {
						result = false;
						key.innerHTML = "필수 항목입니다.";
					}
				break;
				case 'start':
					if(v.length>0){
						key.innerHTML = "적합";
					} else {
						result = false;
						key.innerHTML = "필수 항목입니다.";
					}
				break;
				case 'end':
					if(v.length>0){
						key.innerHTML = "적합";
					} else {
						result = false;
						key.innerHTML = "필수 항목입니다.";
					}
				break;
				case 'until':
					if(v.length>0){
						key.innerHTML = "적합";
					} else {
						result = false;
						key.innerHTML = "필수 항목입니다.";
					}
				break;
				case 'type':
					if(v.length>0){
						key.innerHTML = "적합";
					} else {
						result = false;
						key.innerHTML = "필수 항목입니다.";
					}
				break;
			}
			if(key.innerHTML == "적합"){
				if(!key.classList.contains("text-success"))
					key.classList.add('text-success');
				if(key.classList.contains("text-danger"))
					key.classList.remove("text-danger");
			} else {
				if(!key.classList.contains("text-danger"))
					key.classList.add('text-danger');
				if(key.classList.contains("text-success"))
					key.classList.remove("text-success");
			}
		});
		if(result){
			custom.submit();
		}
	};
	
	// validate for signup
	if(location.pathname.indexOf('signup')>-1 
	|| location.pathname.indexOf('setting')>-1 
	|| location.pathname.indexOf('program/form')>-1 
	|| location.pathname.indexOf('feedback/form')>-1){
		(function() {
			'use strict'
			let custom = document.querySelector('.custom-validate');
			custom.addEventListener('submit', submitHandler);
		})();
	}
	
	
	
	document.querySelectorAll('[data-pop="profile"]').forEach(btn=>{
		btn.addEventListener('click', x=>{
			let origin = x.target;
			let open = origin.dataset.opened;
			let profileIdx = document.querySelectorAll(`[data-pop-id]`);
			let profileBtn = document.querySelectorAll(`[data-id]`);
			idx = 1;
			if(open=="false"){
				let menteeId = origin.dataset.id;
				profileIdx.forEach(item=>{
					item.remove();
				});
				profileBtn.forEach(item=>{
					item.dataset.opened = false;
				});
				$.ajax({
					url:"/find/"+menteeId,
					method: 'post',
					success:(data)=>{
						popProfile(x, data);
					},
					error:(xhr, error)=>{
						console.error(error);
					}
				},false);
				origin.dataset.opened = true;
				idx += 1;
			} else {
				let pops = document.querySelector(`[data-pop-id="${origin.dataset.id}"]`);
				pops.remove();
				idx -= 1;
				origin.dataset.opened = false;
			}
		});
	});
	
	window.addEventListener('scroll', ResponsiveForGnbHandler);
});

let before = 0;
function ResponsiveForGnbHandler(ev){
	const gnb = document.querySelector('nav.navbar');
	const pops = document.querySelector('#alertPop');
	if(window.scrollY>200){
		if(before < window.scrollY){
			// down
//			console.log("down")
			gnb.classList.add("hide");
			if(pops) pops.style.transform = "translateX(-50%) translateY(-56px)";
		} else {
			// up
//			console.log("up")
			gnb.classList.remove("hide");
			if(pops) pops.style.transform = "translateX(-50%) translateY(0%)";
		}
	}
	before = window.scrollY;
}

function popProfile(ev, data){
	let origin = ev.target;
	let parsing = JSON.parse(data);
	let pop = document.createElement("ul");
	pop.dataset.idx = idx;
	pop.dataset.popId = origin.dataset.id;
	pop.classList.add("list-group","bg-white");
	pop.style.cssText = `
		position: absolute;
		top: ${origin.offsetTop}px;
		left: ${origin.offsetLeft}px;
		transform: translateY(-102%);
		z-index: 1020;
		width: 20rem;
	`;
	let tags = '';
	let regdate = new Date(parsing.regdate);
	let y = regdate.getFullYear();
	let mm = regdate.getMonth();
	let d = regdate.getDate();
	let h = regdate.getHours();
	let m = regdate.getMinutes();
	for(let i of parsing.interest.split("_")){
		tags+=`<span class="badge tag tag-purple">${i}</span>`
	}
	let innerPop = `
		<li class="list-group-item d-flex justify-content-between">
			<span>아이디</span><span>${parsing.id}</span>
		</li>
		<li class="list-group-item d-flex justify-content-between">
			<span>이메일</span><span>${parsing.email}</span>
		</li>
		<li class="list-group-item d-flex justify-content-between">
			<span>관심분야</span><span class="w-50 text-wrap text-end">${tags}</span>
		</li>
		<li class="list-group-item d-flex justify-content-between">
			<span>가입일</span><span>${y}-${mm}-${d} ${h}:${m}</span>
		</li>
	`;
	pop.innerHTML=innerPop;
	document.body.prepend(pop);
}
