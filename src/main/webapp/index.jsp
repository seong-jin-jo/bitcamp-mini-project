<%@ page contentType="text/html; charset=euc-kr" %>

<%@ page isELIgnored = 'false'%>

<!-- ///////////////////////////// 로그인시 Forward  /////////////////////////////////////// -->
<c:if test="${ ! empty user }">
	<jsp:forward page="main.jsp"/>
</c:if>
<!-- //////////////////////////////////////////////////////////////////////////////////////////////////// -->

<!DOCTYPE html>

<html>

<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style></style>
   	
   	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		
		//============= 회원원가입 화면이동 =============
		$( function() {
			//==> 추가된부분 : "addUser"  Event 연결
			$("a[href='#' ]:contains('회원가입')").on("click" , function() {
				self.location = "/user/addUser"
			});
		});
		
		//============= 로그인 화면이동 =============
		$( function() {
			//==> 추가된부분 : "addUser"  Event 연결
			$("a[href='#' ]:contains('로 그 인')").on("click" , function() {
				self.location = "/user/login"
			});
		});
		
	</script>	
</head>

<!-- 
<frameset rows="80,*" cols="*" frameborder="NO" border="0" framespacing="0">
  <frame src="/layout/top.jsp" name="topFrame" scrolling="NO" noresize >
  <frameset rows="*" cols="160,*" framespacing="0" frameborder="NO" border="0">
    <frame src="/layout/left.jsp" name="leftFrame" scrolling="NO" noresize>
    <frame src="" name="rightFrame"  scrolling="auto">
  </frameset>

</frameset>
-->

<noframes>
<body>

</body>
</noframes>

</html>