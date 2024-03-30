<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>

<html>
<head>
<title>상품등록</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript" src="../javascript/calendar.js">
</script>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">

function fncAddProduct(){
	//Form 유효성 검증
	var name = $("input[name='prodName']").val();
	var detail = $("input[name='prodDetail']").val();
	var manuDate = $("input[name='manuDate']").val();
	var price = $("input[name='price']").val();
	//var img = $("input[name='imageFile']").val();
	
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
	
	var inputElements = $('input');
	//var inputElements = document.detailForm.getElementsByTagName("input");
	for (var i = 0; i < inputElements.length; i++) {
	    var inputNode = inputElements[i];
	    console.log(inputNode);
	}
	
	$('form').attr("action" , "/product/addProduct").submit();
	//document.detailForm.action='/product/addProduct';
	//document.detailForm.submit();
	console.log(name, detail, manuDate, price);
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
<form name="detailForm" action="" method="post" enctype="application/x-www-form-urlencoded">

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