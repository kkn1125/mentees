/**
 * 
 */


const orderList = document.querySelectorAll('.order');
let ordered = [];

orderList.forEach(o=>{
	ordered.push([o.innerText, o.offsetParent]);
});
ordered.sort().reverse();

let wrapper = orderList[0].offsetParent.parentNode;
wrapper.innerHTML = '';
ordered.forEach((x,idx)=>{
	if(idx==0){
		x[1].prepend(new DOMParser()
		.parseFromString(`
		<div class="position-absolute top-0 start-0 user-select-none">
   			<div class="badge bg-primary">Top</div>
   		</div>
   		`,"text/html").querySelector("div"));
	}
	wrapper.innerHTML+=x[1].outerHTML;
});