function aboutProductPhotos(data) {
	var originalName = getOriginalName(data);
	var imgLink = getImageLink(data);
	var img = checkImgType(data) ? "/resources/upload/" + imgLink : "/resources/esc.png";

	
	if(checkImgType(data)){
	
		var str = `<li><div class="scale"><img src="${img}"></li>`;
		return str;
	
	} else {
	
		var str = `<li><div class="scale"><img src="${img}"></li>`;
		return str;	
		
	}
}

function makeHtmlcode_list(data) {
	var name = data["filename"];
	var originalName = getOriginalName(name);
	var imgLink = getImageLink(name);
	var img = checkImgType(name) ? "/resources/upload/" + name : "/resources/esc.png";

	if(checkImgType(name)){
	
		var str = `<li><div class="scale col-sm-6 col-md-4"><a class="thumbnail" href="/product/show/${data["productId"]}"><img src="${img}"></a><div class="caption"><h3>${data["productName"]}</h3><h3>${data["price"]}&nbsp;<span>원</span></h3><p><a href="/product/show/${data["productId"]}" class="btn btn-primary" role="button">구입하기</a> <button class="btn btn-default btn-incart" value="${data["productId"]}" role="button">장바구니</button></p></div></div></li>`;
		return str;
	
	} else {
	
		var str = `<li><div class="scale col-sm-6 col-md-4"><a class="thumbnail" href="/product/show/${data["productId"]}"><img src="${img}"></a><div class="caption"><h3>${data["productName"]}</h3><h3>${data["price"]}&nbsp;<span>원</span></h3><p><a href="/product/show/${data["productId"]}" class="btn btn-primary" role="button">구입하기</a> <button class="btn btn-default btn-incart" value="${data["productId"]}" role="button">장바구니</button></p></div></div></li>`;
		return str;	
		
	}
}

function makeHtmlcode_read(data) {

	var originalName = getOriginalName(data);
	var imgLink = getImageLink(data);
	var img = checkImgType(data) ? "/resources/upload/" + data : "/resources/esc.png";

	
	if(checkImgType(data)){
	
		var str = `<li><div class="scale"><a target='_blank' href="/displayFile?filename=${imgLink}"><img src="${img}"></a><p class="oriName"> ${originalName}</p></div></li>`;
		return str;
	
	} else {
	
		var str = `<li><div class="scale"><a href="/displayFile?filename=${imgLink}"><img src="${img}"></a><p class="oriName"> ${originalName}</p></div></li>`;
		return str;	
		
	}
}
	
function makeHtmlcode(data) {
	var img = checkImgType(data) ? "/resources/upload/" + data : "/resources/esc.png";
	var originalName = getOriginalName(data);
	var imgLink = getImageLink(data);
	
	if(checkImgType(data)){
	
		var str = `<li class="col-xs-6"><div><a target='_blank' href="/displayFile?filename=${imgLink}"><img src="${img}"></a><p class="oriName"><span data-src="${data}" class="glyphicon glyphicon-trash delbtn" aria-hidden="true"></span> ${originalName}</p></div></li>`;
		return str;
	
	} else {
	
		var str = `<li class="col-xs-6"><div><a href="/displayFile?filename=${imgLink}"><img src="${img}"></a><p class="oriName"><span data-src="${data}" class="glyphicon glyphicon-trash delbtn" aria-hidden="true"></span> ${originalName}</p></div></li>`;
		return str;	
		
	}
	
}

function checkImgType(data) {

	var idx = data.lastIndexOf(".") + 1;
	var type = data.substring(idx).toUpperCase();

	if (type == "PNG" || type == "JPG" || type == "JPEG" || type == "GIF") {
		return true;
	} else {
		return false;
	}
}

function getImageLink(data) {

	if (checkImgType(data)) {
		var pre = data.substring(0, 12);
		var suf = data.substring(14);

		return pre + suf;
	} else {
		return data;
	}
}

function getOriginalName(data) {

	if (checkImgType(data)) {
		var idx = data.indexOf("_"); 
		idx = data.indexOf("_", idx + 1) + 1; 
		return data.substring(idx);
	} else {
		var idx = data.indexOf("_") + 1;
		return data.substring(idx);
	}

}