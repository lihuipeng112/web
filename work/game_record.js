





var btn = document.getElementsByClassName("add-data")[0];
var choose = document.getElementsByTagName("li");

var divCol = document.getElementsByClassName('pu');
for(var i = 0;i< choose.length;i++){
	(function(i){
		choose[i].addEventListener('click',function(){			
			for(var j=0;j<choose.length;j++){
				var a = choose[j].getElementsByTagName('a')[0];
				a.style.color = '#000';
				divCol[j].style.display = 'none';
			}
			// 改变a标签颜色
			var a = choose[i].getElementsByTagName('a')[0];
			a.style.color = '#49a9f8';
			divCol[i].style.display = 'block';

		},false);
	}(i))
}


btn.addEventListener("click",function(){
	var inputs = document.getElementsByClassName("in");
	var game_id = inputs[0].value;
	var game = inputs[1].value;
	var comment = inputs[2].value;
	var doing = document.getElementsByTagName("select")[0];
	var dd = doing.value;
	if(dd==0){
		dd = "压测";
	}else{
		dd = "付费";
	}

	//记录总项
	var checkList= ["apk参数检测","角色数据检测","支付验收","数据中心接口","实名验证","防沉迷","二次验证处理方案","唯一标识"];
	var checkall = [];
	// 获取通过的项
	var obj = document.getElementsByName("pass");
	var check_pass = [];
	for(k in obj){
		if (obj[k].checked){
			checkall.push(obj[k].value);
			check_pass.push(checkList[obj[k].value]);
		}	
	}

	// 获取未通过的项
	var obj = document.getElementsByName("unpass");
	var check_unpass = [];
	for(k in obj){
		if (obj[k].checked){
			checkall.push(obj[k].value);
			check_unpass.push(checkList[obj[k].value]);
		}	
	}

	//检查两项加起来是否为8项,且都已选择完
	// var checkall = unique(checkall);
	// if(checkall.length != 8){
	// 	alert("通过项与未通过项未选择完");
	// }

	console.log(game,game_id,dd,check_pass.toString(),check_unpass.toString(),checkall.length,comment);
	alert("提交成功");

	}
,false);


function unique(arr) {
    if (!Array.isArray(arr)) {
        console.log('type error!')
        return
    }
    var array = [];
    for (var i = 0; i < arr.length; i++) {
        if (array .indexOf(arr[i]) === -1) {
            array .push(arr[i])
        }
    }
    return array;
}

