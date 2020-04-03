

/*
	创建一个轮播图
*/

function createArea(area, options){
	
	var imgArea = document.createElement("div");
	var numberArea = document.createElement("div");
	var index = 0; //显示当前图片及图片
	var autoTimer = null; //计时器
	var dirution = 2000;
	var newTimer = null; //动画定时器
	//1、创建一个区域，放置图片
	initImg();


	//2、创建一个区域，放置角标
	initNumber();

	//3、设置状态
	setStatus(index);

	//4、自动播放
	aotuImg();

	//初始化图片内容区域
	function initImg(){
		
		imgArea.style.width = "100%";
		imgArea.style.height = "100%";
		imgArea.style.marginLeft = "0";
		imgArea.style.display = "flex";
		area.style.overflow = "hidden";
		for (var i = 0; i < options.length + 1; i++) {
			if(i === options.length){
				var obj = options[0];
			}else{
				var obj = options[i];
			}
			
			var img = document.createElement("img");
			img.style.width = "100%";
			img.style.height = "100%";
			img.style.marginLeft = "0";
			img.src = obj["imgurl"];
			

			imgArea.appendChild(img);
		}


		imgArea.addEventListener("mouseenter",function(){
			clearInterval(autoTimer);
			autoTimer = null;
		})
		imgArea.addEventListener("mouseleave",function(){
			aotuImg();
		})
		area.appendChild(imgArea);		
	}

	//初始化角标区域
	function initNumber(){
		numberArea.style.textAlign = "center";
		numberArea.style.marginTop = "-20px";

		for (var i = 0; i < options.length; i++) {
			var sp = document.createElement("span");
			sp.style.display = "inline-block";
			sp.style.width = "10px";
			sp.style.height = "10px";
			sp.style.borderRadius = "50%";
			sp.style.marginLeft = "5px";
			sp.style.cursor = "pointer";
			sp.style.background = "#E8E8E8";
			(function(current){
				sp.addEventListener("click",function(){
					index = current;
					setStatus();
					clearInterval(autoTimer);
			},false)
			}(i))
			numberArea.appendChild(sp);
		}
		numberArea.addEventListener("mouseenter",function(){
			clearInterval(autoTimer);
			autoTimer = null;
		})
		numberArea.addEventListener("mouseleave",function(){
			aotuImg();
		})

		area.appendChild(numberArea);
	}

	//设置选中状态
	function setStatus(){

		


		var numberSp = numberArea.children;
		for (var i = 0; i < numberSp.length; i++) {
			
			if(i === index){
				numberSp[i].style.background = "#FF7F00";
			}else{
				numberSp[i].style.background = "#E8E8E8";
			}
		}

		//设置当前显示的图片
		var start = parseInt(imgArea.children[0].style.marginLeft);
		var end = -100 * index; //最终的位置
		var dis = end - start;
		var speed = dis / 1000;
		if(newTimer){
			clearInterval(newTimer);
		}
		
		if(index === options.length){
			numberArea.children[0].style.background = "#FF7F00";
		}
		//划动效果
		newTimer = setInterval(function(){
			start += speed * 20;
			imgArea.children[0].style.marginLeft = start + "%";
			if(Math.abs(end - start) < 1){
				imgArea.children[0].style.marginLeft = end + "%";
				clearInterval(newTimer);
				//浏览完最后一张后，马上将图片设置在第一张的位置上
				if(index === options.length){
					imgArea.children[0].style.marginLeft = "0";
					index = 0;
				}

			}
		},20)
		
		

		
		
	}

	//设置自动播放
	function aotuImg(){
		autoTimer = setInterval(function(){
			if(index === options.length){
				index = 0;
			}else{
				index ++;
			}
			setStatus();

		},dirution)

	}
}