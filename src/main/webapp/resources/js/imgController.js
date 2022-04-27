/**
 * 
 */


'use strict';
let befored = 0;
const IMG = document.querySelector("[alt=\"cover\"]");
if(IMG){
	window.addEventListener('scroll',(ev)=>{
	//	if(before < window.scrollY){
	//		// down
	//		tops += 1;
	//	}
	//	else{
	//		// up
	//		tops -= 1;
	//	}
		IMG.style.top = `${window.scrollY/10}%`;
		befored = window.scrollY;
	});
}