


var liCol = document.getElementsByTagName('li');
var divCol = document.getElementsByClassName('pu');
for(var i = 0;i< liCol.length;i++){
	(function(i){
		liCol[i].addEventListener('click',function(){			
			for(var j=0;j<liCol.length;j++){
				var a = liCol[j].getElementsByTagName('a')[0];
				a.style.color = '#fff';
				divCol[j].style.display = 'none';
			}
			// 改变a标签颜色
			var a = liCol[i].getElementsByTagName('a')[0];
			a.style.color = '#49a9f8';
			divCol[i].style.display = 'block';

		},false);
	}(i))
}
