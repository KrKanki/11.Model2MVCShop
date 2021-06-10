<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<jsp:include page="/layout/toolbar.jsp" />

<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">

	function fncGetProductList(currentPage){
		$("#currentPage").val(currentPage)
	   	//document.detailForm.submit();
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct?"+"${url}").submit();
	
	}
	
	$(function() {
		 
		//==> 검색 Event 연결처리부분
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함. 
		 $( "td.ct_btn01:contains('검색')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('검색')" ).html() );
			alert($(this).val().html());
// 			fncGetProductList(1);
		});
		
		$("td.status").on("click", function(){
			
			var prodNo = $(this).parent().find("input").val();
			alert($(this).parent().find("input").val());
// 			alert("/product/getProduct?${url}&prodNo="+prodNo)
// 			$("form").attr("method", "GET").attr("action", "/product/getProduct?${url}&prodNo="+prodNo ).submit();
			self.location = "/product/getProduct?${url}&prodNo="+prodNo;
			
		});
		

		$( "td.prodNo" ).on("click" , function() {
				
				//Debug..
// 				alert( $( this ).html().trim() );
// 				alert( $(this).find('input').val());
				//prodNo 추출
				var prodNo = $(this).find('input').val();
// 				alert(prodNo);
// 				// tranCode null값에 따른 if문 
// 				if(prodNo !=null){
// 				self.location = "/product/getProduct?prodNo="+prodNo+"&"+"${url}";
				
				$.ajax( 
						{
							url : "/product/json/getProduct/"+prodNo ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {

// 								Debug...
// 								alert(status);
// 								Debug...
// 								alert("JSONData : \n"+JSONData);
								
								var displayValue = "<h4>"
															+"상품번호 : "+JSONData.prodNo+"<br/>"
															+"상품이름 : "+JSONData.prodName+"<br/>"
															+"상세설명 : "+JSONData.prodDetail+"<br/>"
															+"상품사진 : "+JSONData.fileName+"<br/>"
															+"상품가격 : "+JSONData.price+"<br/>"
															+"</h4>"
								//Debug...									
								//alert(displayValue);
								$("h4").remove();
								$( "#"+prodNo+"" ).html(displayValue);
							}
					});
					////////////////////////////////////////////////////////////////////////////////////////////
		});
		
		//==> UI 수정 추가부분  :  userId LINK Event End User 에게 보일수 있도록 
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		$("h7").css("color" , "red");
		
		
		//==> 아래와 같이 정의한 이유는 ??
		//==> 아래의 주석을 하나씩 풀어 가며 이해하세요.					
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	//		console.log ( $(".ct_list_pop:nth-child(1)" ).html() );
// 		console.log ( $(".ct_list_pop:nth-child(2)" ).html() );
	});	



</script>
</head>
<div class="container">
	
		<div class="page-header text-info">
			  <h3>${ title}</h3>
		  </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">			
							
		 <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0" ${ !empty search.searchCondition && search.searchCondition == '0' ? "selected" : ""}>상품번호</option>
						<option value="1" ${ !empty search.searchCondition && search.searchCondition == '1' ? "selected" : ""}>상품명</option>
						<option value="2" ${ !empty search.searchCondition && search.searchCondition == '2' ? "selected" : ""}>상품가격</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				</form>
	    	</div>
		</div>

		  <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >상품명</th>
            <th align="left">가격</th>
            <th align="left">
           <c:if test="${url == 'menu=manage'}" >
			수정
			</c:if>
			<c:if test="${url == 'menu=search'}">
			구매
			</c:if>
            </th>
            <th align="left">현재상태</th>
            <th align="left">간략정보</th>
          </tr>
        </thead>
       
		<tbody>
			
			<c:set var="i" value="0" />
				<c:forEach var="product" items="${ list }">
				<c:set var="i" value="${ i+1 }"/>
				
				<tr>
				<td align="center"> ${i}</td>
				<td align="left">
		 		${product.prodName}
			 	</td>
				<td align="left">${product.price}</td>
				<td align="left" class="status">
				<c:if test= "${ empty product.proTranCode || product.proTranCode == '0  '}">
					<c:if test= "${ url =='menu=manage' }">
					<i class="glyphicon glyphicon-pencil">수정하기</i>
<!-- 					<button type="button" class="btn btn-default">수정</button>	 -->
					</c:if>
					<c:if test=  "${ url =='menu=search' }">
					<i class="glyphicon glyphicon-gift" >구매하기</i>
					
<!-- 					<button type="button" class="btn btn-default">구매</button> -->
					</c:if>
				</c:if>
				<c:if test= "${ !empty product.proTranCode && product.proTranCode !='0  '}">
				판매완료
			 	</c:if>
				</td>
				<td align="left">
				
				<c:if test= "${ empty product.proTranCode || product.proTranCode =='0  '}">
			 		판매중
			 	</c:if>
				
				<c:if test= "${ !empty product.proTranCode && product.proTranCode =='1  '}">
			 		 
			 		<c:if test="${ !empty url && url =='menu=search' }">
			 		배송준비중  <a href="/updateTranCode.do?tranNo=${ product.prodNo}&tranCode=2">배송 시작</a>
			 		 </c:if>
			 		<c:if test="${ !empty url && url =='menu=manage' }">
			 		배송준비중  
			 		 </c:if>
			 	</c:if>			
				<c:if test= "${ !empty product.proTranCode && product.proTranCode =='2  '}">
			 		배송중
			 	</c:if>			
				<c:if test= "${ !empty product.proTranCode && product.proTranCode =='3  '}">
			 		배송완료 
			 	</c:if>			
				</td>
				<td align="left" class="prodNo">
					  	<i class="glyphicon glyphicon-zoom-in" id= "${product.prodNo}"></i>
					  	<input class="prodNo" name="prodNo" type="hidden" value="${product.prodNo}">
				</td>	
			</tr>
			</c:forEach>
		
		</tbody>		
	
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		 <input type="hidden" id="currentPage" name="currentPage" value=""/>
<%-- 			<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }"> --%>
<!-- 			◀ 이전 -->
<%-- 	</c:if> --%>
<%-- 	<c:if test="${ resultPage.currentPage > resultPage.pageUnit }"> --%>
<%-- 			<a href="javascript:fncGetProductList('${ resultPage.currentPage-1}')">◀ 이전</a> --%>
<%-- 	</c:if> --%>
	
<%-- 	<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1"> --%>
<%-- 		<a href="javascript:fncGetProductList('${i}');">${i}</a> --%>
<%-- 	</c:forEach> --%>
	
<%-- 	<c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }"> --%>
<!-- 			이후 ▶ -->
<%-- 	</c:if> --%>
<%-- 	<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }"> --%>
<%-- 			<a href="javascript:fncGetProductList('${resultPage.endUnitPage+1}')">이후 ▶</a> --%>
<%-- 	</c:if> --%>
			
			<jsp:include page="../common/pageNavigator.jsp"/>
			
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>