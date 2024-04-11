<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>

<html>
<head>
<title>상품등록</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript" src="../javascript/calendar.js"></script>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<!-- 파일 미리보기 코드-->
<script type="text/javascript">

$(function() {
	
	console.log("ㅎㅎ8")
	/////////////////
	////파일 테스트중////
	////////////////
	var file = $("#fileUpload")
	console.log(file)
	console.log(file.get(0)); // input 태그
	
	var multiplefile = $("#fileUploadMultiple")
	console.log(multiplefile)
	console.log(multiplefile.get(0)) // Multiple input 태그
	
	
	//eventlistner 등록 
	file.get(0).onchange = () => {

		const selectedFile = file.get(0).files[0];
		console.log("selectedFile", selectedFile);
		
		//파일 미리보기
		const fileReader = new FileReader();
		fileReader.readAsDataURL(selectedFile);
		fileReader.onload = function () {
			
			console.log("fileReader", fileReader)
			
			var imgElement = $("<img>");
			imgElement.attr("src", fileReader.result);
			imgElement.css({
			    "width": "200px",
			    "height": "200px"
			});
			imgElement.addClass("uploadedImg")
			//js분리
			
	        //imgElement.click(() => {
	        //    alert("선택됨");
	        //});			
			
			$("#imgDisplaySpot").append(imgElement);
			
		  };
	}
	
	multiplefile.get(0).onchange = () => {
		//const selectedFileMultiple = multiplefile.get(0).files[0];
		const selectedFileMultiple = [...multiplefile.get(0).files];
		console.log("selectedFileMultiple!", selectedFileMultiple);
		
		//파일 미리보기
		selectedFileMultiple.forEach( (selectedFile) => {
			var fileReader = new FileReader();
			console.log("each selectedFile", selectedFile);
			
			fileReader.readAsDataURL(selectedFile);
			fileReader.onload = function () {
				
				console.log("fileReader", fileReader)
				
				var imgElement = $("<img>");
				imgElement.attr("src", fileReader.result);
				imgElement.css({
				    "width": "200px",
				    "height": "200px"
				});
				imgElement.addClass("uploadedImg")
		        //js분리
		        
				//imgElement.click(() => {
		        //    alert("선택됨");
		        //});
				
				$("#imgDisplaySpot").append(imgElement);
				
			  };
		})
	}
	
	
	// base64 : img(바이너리 data) binary 를 String 으로 바꾼것 
	
	// 참고 
	// spring 'multipart' => form data 를 서버가 받고 multipart (파일이름, 이미지데이터) 있는데 이를 outputstream 으로 확인하고...?
	// "서버에 전송한 파일을 java 객체로 바인딩해준다"
	// (@modelAttribute Multipart 파일이름)

	//String a = 1;
	//Multipart file = "설현.jpg"; // 이미지 이름, 이미지 데이터
	
	// 1. input 태그를 file 로 설정 ( input 태그. files  하면 올라온 파일 올라온게 뜸)
	// 2. fileReader 에서 URL 읽고 onload 에서(?) 이미지 주소에 읽은 file 주소를 쓰기
	// 3. 업로드 (단, multi 일때는 fileReader 를 새로 만들어서 갱신해야됨
	// 안그럼 Failed to execute 'readAsDataURL' on 'FileReader': parameter 1 is not of type 'Blob'. 에러뜸 )
	

})

</script>

<!-- 대표사진 설정 -->
<script type="text/javascript">

$(function() {
	
    console.log("대표사진 설정 하는중");
    
   
    // 이미지 클릭 이벤트 핸들러 함수 정의
    function ThumbnailImageSelectHandler() {
    	
    	var result = confirm("대표사진으로 선택하겠습니까?");
    	
    	if (result) {
    	    console.log("대표사진으로 설정되었습니다.");
    	} else {
    	    console.log("대표사진선택이 취소되었습니다.");
    	}
    	
    	//해당파일 선택했을때 마킹해서 서버에 넘겨야함
    	
    }
    
    // 이미지 클릭 이벤트 핸들러 등록
    $("#imgDisplaySpot").on("click", '.uploadedImg', ThumbnailImageSelectHandler);

    $("#imgDisplaySpot").hover(
    		  function() {
    		    // 호버 시작 시 이미지를 확대하여 보이도록 변경
    		    $(this).css("transform", "scale(1.1)");
    		    $(this).css("border", "2px solid limegreen");
    		  },
    		  function() {
    		    // 호버 종료 시 다시 원래 크기로 돌아가도록 변경
    		    $(this).css("transform", "scale(1)");
    		    $(this).css("border", "");
    		  }
    		);
	
})

</script>

<!-- form 전송 -->
<script type="text/javascript">

function fncAddProduct(){
	alert("ㄱㄱ")
	//Form 유효성 검증
	var name = $("input[name='prodName']").val();
	var detail = $("input[name='prodDetail']").val();
	var manuDate = $("input[name='manuDate']").val();
	var price = $("input[name='price']").val();
	//var img = $("input[name='imageFile']").val();
	var singleFile = $("input[name='singleFile']")[0].files[0];
	var multiFile = $("input[name='multipleFile']")[0].files;

	/*
 	var name = document.detailForm.prodName.value;
	var detail = document.detailForm.prodDetail.value;
	var manuDate = document.detailForm.manuDate.value;
	var price = document.detailForm.price.value;
	var img = document.detailForm.imageFile.value;
	*/
	
	if(name == null || name.length<1){
		alert("상품명은 반드시 입력하여야 합니다.");
		return;
	}
	if(detail == null || detail.length<1){
		alert("상품상세정보는 반드시 입력하여야 합니다.");
		return;
	}
	if(manuDate == null || manuDate.length<1){
		alert("제조일자는 반드시 입력하셔야 합니다.");
		return;
	}
	if(price == null || price.length<1){
		alert("가격은 반드시 입력하셔야 합니다.");
		return;
	}
	
	// [Dev] 어떤 input 보낼건지 
	var inputElements = $('input');
	//var inputElements = document.detailForm.getElementsByTagName("input");
	for (var i = 0; i < inputElements.length; i++) {
	    var inputNode = inputElements[i];
	    console.log(inputNode);
	}
	
	
	//////////////////////// 파일 수정후 보내기 위해 FETCH 요청으로 수정됨 ////////////////////////
	// $('form').attr("action" , "/product/addProduct").submit();

	// console.log(name, detail, manuDate, price, singleFile, multiFile);
	
	// alert("당연히바로바꾸지")
	/////////////////////////////////////////////////////////////////////////////////
	
	
	var formData = new FormData();
	formData.set('prodName', name);
	formData.set('prodDetail', detail);
	formData.set('manuDate', manuDate);
	formData.set('price', price);
	formData.set('singleFile', singleFile);
    for (var i = 0; i < multiFile.length; i++) {
        formData.append('multipleFile', multiFile[i]); // 다중 파일
    }
    
	//[dev] 받아올것 넘길것 확인
	console.log("받아올것", name,detail,manuDate,price,singleFile,multiFile)
	for (const value of formData.values()) {
		  console.log("넘길것",value);
		}
	
	fetch('/product/addProduct', {
		method: 'POST',
	    headers: {
	        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
	    },
		body: formData
	})
	.then(response => {
		
		if(response.redirected) {
        window.location.href = response.url; // 리다이렉트된 URL로 이동
    	}
		
		if(response.ok) {
			return response.json();
		}
		throw new Error('Network response was not ok.');
	})
	.then(data => {
		// 서버로부터의 응답 처리
		console.log(data);
		alert("상품이 성공적으로 추가되었습니다.");
	})
	.catch(error => {
		// 에러 처리
		console.error('There has been a problem with your fetch operation:', error);
		alert("상품 추가에 실패했습니다.");
	});
}

function resetData(){
	$('form').reset();
}

</script>

</head>
  
<body bgcolor="#ffffff" text="#000000">

<jsp:include page="/layout/toolbar.jsp" />
<jsp:include page="/layout/background.jsp" />

<div style="width: 70%; margin: 100px auto;">

<!-- enctype multipart/form-data에서 바꿈 이미지 안쓸거니까  -->
<form name="detailForm" action="" method="post" enctype="multipart/form-data">

		<div class="container">
	    <!-- 상단 배너 -->
	    <div class="page-header">
	        <h3 class="text-info">상품정보조회</h3>
	        <h5 class="text-muted">상품 정보를 <strong class="text-danger">업데이트</strong>해 주세요.</h5>
	    </div>
	
	    <!-- 상품번호 -->
	
	    <div class="row">
	        <div class="col-xs-4 col-md-2"><strong>상품명</strong></div>
	        <div class="col-xs-8 col-md-4"><input type="text" name="prodName" value="${vo.getProdName()}"></div>
	    </div>
	
	    <hr/>
	
	    <div class="row">
	        <div class="col-xs-4 col-md-2"><strong>상품이미지</strong></div>
	        
	        <br/>
	        파일 1개
	        <input id="fileUpload" name="singleFile" type="file" accept="image/*">
	        파일 여러개
	        <input id="fileUploadMultiple" name="multipleFile" multiple='multiple' type="file" accept="image/*"> 
	        <br/>
	        
	        <div id="imgDisplaySpot"></div>

	        <div class="col-xs-8 col-md-4">
	            <img width="30%" height="30%" src="https://mblogthumb-phinf.pstatic.net/20160817_259/retspe_14714118890125sC2j_PNG/%C7%C7%C4%AB%C3%F2_%281%29.png?type=w800"/>
	        </div>
	    </div>
	
	    <hr/>
	
	    <div class="row">
	        <div class="col-xs-4 col-md-2"><strong>상품상세정보</strong></div>
	        <div class="col-xs-8 col-md-4"><input type="text" name="prodDetail" value="${vo.getProdDetail()}"></div>
	    </div>
	
	    <hr/>
	
	    <div class="row">
	        <div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
	        <div class="col-xs-8 col-md-4"><input type="text" name="manuDate" value="${vo.getRegDate()}">
	        &nbsp;<img src="../images/ct_icon_date.gif" width="15" height="15" 
											onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)"/></div>
	    </div>
	
	    <hr/>
	
	    <div class="row">
	        <div class="col-xs-4 col-md-2"><strong>가격</strong></div>
	        <div class="col-xs-8 col-md-4"><input type="text" name="price" value="${vo.getPrice()}"></div>
	    </div>

	</div>
		
	
	<%-- 등록취소버튼 --%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
		<tr>
			<td width="53%"></td>
			<td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01"  style="padding-top: 3px;">
						<a href="javascript:fncAddProduct();">등록</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
					<td width="30"></td>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01"	 style="padding-top: 3px;">
						<a href="javascript:resetData();">취소</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

</form>

</div>
</body>
</html>